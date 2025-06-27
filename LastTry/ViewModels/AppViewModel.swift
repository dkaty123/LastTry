import Foundation
import SwiftUI
import AVFoundation

public class AppViewModel: ObservableObject {
    @Published public var scholarships: [Scholarship] = []
    @Published public var savedScholarships: [Scholarship] = []
    @Published public var userProfile: UserProfile?
    @Published public var hasCompletedOnboarding: Bool = false
    @Published public var matchedScholarships: [Scholarship] = []
    @AppStorage("soundtrackEnabled") public var soundtrackEnabled: Bool = true
    private var soundtrackPlayer: AVAudioPlayer?
    
    private let savedScholarshipsKey = "savedScholarships"
    private let onboardingKey = "hasCompletedOnboarding"
    
    public init() {
        resetAppState()
        updateDailyLoginStreak()
    }
    
    private func loadData() {
        // Load scholarships from real data
        scholarships = ScholarshipData.convertAndAddScholarships()
        
        // Load saved scholarships
        if let data = UserDefaults.standard.data(forKey: savedScholarshipsKey),
           let saved = try? JSONDecoder().decode([Scholarship].self, from: data) {
            savedScholarships = saved
        }
        
        // Load user profile
        userProfile = UserProfile.load()
        
        // Load onboarding status
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: onboardingKey)
    }
    
    public func resetAppState() {
        // Reset onboarding status
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: onboardingKey)
        
        // Clear saved scholarships
        savedScholarships = []
        UserDefaults.standard.removeObject(forKey: savedScholarshipsKey)
        
        // Reset user profile
        userProfile = nil
        UserDefaults.standard.removeObject(forKey: "userProfile")
        
        // Load fresh scholarship data
        scholarships = ScholarshipData.convertAndAddScholarships()
    }
    
    public func saveScholarship(_ scholarship: Scholarship) {
        savedScholarships.append(scholarship)
        saveSavedScholarships()
    }
    
    public func removeSavedScholarship(_ scholarship: Scholarship) {
        savedScholarships.removeAll { $0.id == scholarship.id }
        saveSavedScholarships()
    }
    
    private func saveSavedScholarships() {
        if let encoded = try? JSONEncoder().encode(savedScholarships) {
            UserDefaults.standard.set(encoded, forKey: savedScholarshipsKey)
        }
    }
    
    public func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }
    
    public func resetOnboarding() {
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: onboardingKey)
    }
    
    public func clearSavedScholarships() {
        savedScholarships.removeAll()
        saveSavedScholarships()
    }
    
    func clearAllSavedScholarships() {
        savedScholarships.removeAll()
    }
    
    public func updateMatchedScholarships() {
        guard let profile = userProfile else {
            // Default list when no profile exists
            matchedScholarships = scholarships
                .filter { $0.deadline > Date() }
                .filter { $0.category == .general || $0.requirements.contains(where: { $0.localizedCaseInsensitiveContains("open to all students") }) }
                .prefix(10)
                .map { $0 }
            return
        }
        
        let isIncomplete = profile.name.isEmpty || profile.fieldOfStudy.isEmpty || profile.gradeLevel.isEmpty || profile.gender.isEmpty || profile.ethnicity.isEmpty
        if (isIncomplete) {
            // Default list when profile is incomplete
            matchedScholarships = scholarships
                .filter { $0.deadline > Date() }
                .filter { $0.category == .general || $0.requirements.contains(where: { $0.localizedCaseInsensitiveContains("open to all students") }) }
                .prefix(10)
                .map { $0 }
            return
        }
        
        // Simple matching: check if field of study appears in scholarship name, description, or requirements
        let fieldOfStudy = profile.fieldOfStudy.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let now = Date()
        
        let matches = scholarships
            .filter { $0.deadline > now }
            .filter { scholarship in
                // Check if field of study appears in name, description, requirements, or category (case-insensitive)
                let scholarshipText = ([scholarship.name, scholarship.category.rawValue, scholarship.description] + scholarship.requirements).joined(separator: " ").lowercased()
                return scholarshipText.contains(fieldOfStudy)
            }
        
        if matches.isEmpty {
            // Default list when no matches found
            matchedScholarships = scholarships
                .filter { $0.deadline > now }
                .filter { $0.category == .general || $0.requirements.contains(where: { $0.localizedCaseInsensitiveContains("open to all students") }) }
                .prefix(10)
                .map { $0 }
        } else {
            matchedScholarships = matches
        }
    }
    
    // MARK: - Daily Login Streak Logic
    public func updateDailyLoginStreak() {
        guard var profile = userProfile else { return }
        let calendar = Calendar.current
        let now = Date()
        if let lastLogin = profile.lastLoginDate {
            if calendar.isDateInToday(lastLogin) {
                // Already logged in today, do nothing
                return
            } else if let yesterday = calendar.date(byAdding: .day, value: -1, to: now), calendar.isDate(lastLogin, inSameDayAs: yesterday) {
                // Continue streak
                profile.streakCount += 1
            } else {
                // Missed a day, reset streak
                profile.streakCount = 1
            }
        } else {
            // First login
            profile.streakCount = 1
        }
        profile.lastLoginDate = now
        userProfile = profile
        UserProfile.save(profile)
    }
    
    // Call this after updateDailyLoginStreak from a View, passing the shared AchievementViewModel
    func unlockStreakAchievementsIfNeeded(achievementViewModel: AchievementViewModel) {
        guard let streak = userProfile?.streakCount else { return }
        achievementViewModel.checkAndUnlockStreakAchievements(streakCount: streak)
    }
    
    public func playSoundtrack() {
        guard soundtrackEnabled else { stopSoundtrack(); return }
        if soundtrackPlayer?.isPlaying == true { return }
        if let url = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            do {
                soundtrackPlayer = try AVAudioPlayer(contentsOf: url)
                soundtrackPlayer?.numberOfLoops = -1
                soundtrackPlayer?.volume = 0.5
                soundtrackPlayer?.play()
            } catch {
                print("Failed to play soundtrack: \(error)")
            }
        }
    }
    
    public func stopSoundtrack() {
        soundtrackPlayer?.stop()
        soundtrackPlayer = nil
    }
    
    public func updateSoundtrackState() {
        if soundtrackEnabled { playSoundtrack() } else { stopSoundtrack() }
    }
} 
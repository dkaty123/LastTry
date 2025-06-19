import Foundation
import SwiftUI

public class AppViewModel: ObservableObject {
    @Published public var scholarships: [Scholarship] = []
    @Published public var savedScholarships: [Scholarship] = []
    @Published public var userProfile: UserProfile?
    @Published public var hasCompletedOnboarding: Bool = false
    
    private let savedScholarshipsKey = "savedScholarships"
    private let onboardingKey = "hasCompletedOnboarding"
    
    public init() {
        resetAppState()
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
} 
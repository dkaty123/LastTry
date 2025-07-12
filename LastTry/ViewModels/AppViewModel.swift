import Foundation
import SwiftUI
import AVFoundation

public class AppViewModel: ObservableObject {
    // MARK: - Opportunity Properties
    @Published public var opportunities: [Opportunity] = []
    @Published public var savedOpportunities: [Opportunity] = []
    @Published public var matchedOpportunities: [Opportunity] = []
    
    // MARK: - Backward Compatibility Properties
    @Published public var scholarships: [Scholarship] = []
    @Published public var savedScholarships: [Scholarship] = []
    @Published public var matchedScholarships: [Scholarship] = []
    
    // MARK: - User Properties
    @Published public var userProfile: UserProfile?
    @Published public var hasCompletedOnboarding: Bool = false
    @AppStorage("soundtrackEnabled") public var soundtrackEnabled: Bool = true
    private var soundtrackPlayer: AVAudioPlayer?
    
    // MARK: - Filter Properties
    @Published public var selectedOpportunityTypes: Set<OpportunityType> = Set(OpportunityType.allCases)
    @Published public var selectedOpportunityCategories: Set<OpportunityCategory> = Set(OpportunityCategory.allCases)
    @Published public var deadlineFilter: DeadlineFilter = .all
    @Published public var searchQuery: String = ""
    
    // MARK: - Storage Keys
    private let savedOpportunitiesKey = "savedOpportunities"
    private let savedScholarshipsKey = "savedScholarships"
    private let onboardingKey = "hasCompletedOnboarding"
    
    public init() {
        resetAppState()
        updateDailyLoginStreak()
    }
    
    private func loadData() {
        // Load opportunities from real data
        opportunities = loadOpportunitiesFromData()
        
        // Load saved opportunities
        if let data = UserDefaults.standard.data(forKey: savedOpportunitiesKey),
           let saved = try? JSONDecoder().decode([Opportunity].self, from: data) {
            savedOpportunities = saved
        }
        
        // Load user profile
        userProfile = UserProfile.load()
        
        // Load onboarding status
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: onboardingKey)
        
        // Update matched opportunities
        updateMatchedOpportunities()
        
        // Update backward compatibility
        updateBackwardCompatibility()
    }
    
    private func loadOpportunitiesFromData() -> [Opportunity] {
        // Use the new OpportunityData to load all opportunities
        return OpportunityData.convertAndAddOpportunities()
    }
    
    private func updateBackwardCompatibility() {
        // Update scholarship arrays for backward compatibility
        scholarships = opportunities.compactMap { $0.toScholarship() }
        savedScholarships = savedOpportunities.compactMap { $0.toScholarship() }
        matchedScholarships = matchedOpportunities.compactMap { $0.toScholarship() }
    }
    
    public func resetAppState() {
        // Reset onboarding status
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: onboardingKey)
        
        // Clear saved opportunities
        savedOpportunities = []
        UserDefaults.standard.removeObject(forKey: savedOpportunitiesKey)
        
        // Clear saved scholarships (backward compatibility)
        savedScholarships = []
        UserDefaults.standard.removeObject(forKey: savedScholarshipsKey)
        
        // Reset user profile
        userProfile = nil
        UserDefaults.standard.removeObject(forKey: "userProfile")
        
        // Load fresh opportunity data
        opportunities = loadOpportunitiesFromData()
        updateBackwardCompatibility()
    }
    
    // MARK: - Opportunity Management
    public func saveOpportunity(_ opportunity: Opportunity) {
        savedOpportunities.append(opportunity)
        saveSavedOpportunities()
        updateBackwardCompatibility()
    }
    
    public func removeSavedOpportunity(_ opportunity: Opportunity) {
        savedOpportunities.removeAll { $0.id == opportunity.id }
        saveSavedOpportunities()
        updateBackwardCompatibility()
    }
    
    private func saveSavedOpportunities() {
        if let encoded = try? JSONEncoder().encode(savedOpportunities) {
            UserDefaults.standard.set(encoded, forKey: savedOpportunitiesKey)
        }
    }
    
    // MARK: - Backward Compatibility Methods
    public func saveScholarship(_ scholarship: Scholarship) {
        // Convert to opportunity and save
        let opportunity = Opportunity(from: scholarship)
        saveOpportunity(opportunity)
    }
    
    public func removeSavedScholarship(_ scholarship: Scholarship) {
        // Find and remove the corresponding opportunity
        if let opportunity = savedOpportunities.first(where: { $0.id == scholarship.id }) {
            removeSavedOpportunity(opportunity)
        }
    }
    
    private func saveSavedScholarships() {
        if let encoded = try? JSONEncoder().encode(savedScholarships) {
            UserDefaults.standard.set(encoded, forKey: savedScholarshipsKey)
        }
    }
    
    // MARK: - User Management
    public func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }
    
    public func resetOnboarding() {
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: onboardingKey)
    }
    
    public func clearSavedOpportunities() {
        savedOpportunities.removeAll()
        saveSavedOpportunities()
        updateBackwardCompatibility()
    }
    
    public func clearSavedScholarships() {
        savedScholarships.removeAll()
        saveSavedScholarships()
    }
    
    func clearAllSavedScholarships() {
        savedScholarships.removeAll()
    }
    
    // MARK: - Matching Logic
    // Field of Study to Keywords Mapping
    private func keywordsForFieldOfStudy(_ field: String) -> [String] {
        let lowercased = field.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        switch lowercased {
        case "engineering":
            return ["engineering", "engineer", "stem", "technology", "mechanical", "electrical", "civil", "computer", "software", "robotics", "design"]
        case "business":
            return ["business", "commerce", "entrepreneur", "management", "finance", "accounting", "marketing", "economics"]
        case "arts":
            return ["arts", "art", "visual", "music", "theatre", "drama", "creative", "fine arts", "literature", "writing", "poetry"]
        case "science":
            return ["science", "biology", "chemistry", "physics", "mathematics", "math", "stem", "research", "lab"]
        case "education":
            return ["education", "teaching", "teacher", "pedagogy", "school", "learning"]
        case "health":
            return ["health", "medicine", "medical", "nursing", "doctor", "pharmacy", "public health", "biomedical", "psychology", "wellness"]
        case "law":
            return ["law", "legal", "justice", "criminology", "policy", "court", "rights"]
        case "other":
            return [""]
        default:
            return [lowercased]
        }
    }

    public func updateMatchedOpportunities() {
        guard let profile = userProfile else {
            matchedOpportunities = []
            updateBackwardCompatibility()
            return
        }
        let isIncomplete = profile.name.isEmpty || profile.fieldOfStudy.isEmpty || profile.gradeLevel.isEmpty || profile.gender.isEmpty || profile.ethnicity.isEmpty
        if (isIncomplete) {
            matchedOpportunities = []
            updateBackwardCompatibility()
            return
        }
        // Profile-based matching with mixed ordering
        let keywords = keywordsForFieldOfStudy(profile.fieldOfStudy)
        let now = Date()
        let matches = opportunities
            .filter { $0.isActive }
            .filter { $0.deadline == nil || $0.deadline! > now }
            .filter { opportunity in
                let opportunityText = ([opportunity.title, opportunity.category.rawValue, opportunity.description] + opportunity.requirements).joined(separator: " ").lowercased()
                return keywords.contains("") ? true : keywords.contains { keyword in !keyword.isEmpty && opportunityText.contains(keyword) }
            }
        if matches.isEmpty {
            matchedOpportunities = []
        } else {
            matchedOpportunities = createMixedListFromOpportunities(matches)
        }
        updateBackwardCompatibility()
    }
    
    // MARK: - Mixed Ordering Logic
    public func createMixedOpportunityList() -> [Opportunity] {
        let now = Date()
        var filteredOpportunities = opportunities
            .filter { $0.isActive }
            .filter { $0.deadline == nil || $0.deadline! > now }

        // Filter by selected types
        if !selectedOpportunityTypes.isEmpty && selectedOpportunityTypes.count < OpportunityType.allCases.count {
            filteredOpportunities = filteredOpportunities.filter { selectedOpportunityTypes.contains($0.type) }
        }

        // Filter by selected categories
        if !selectedOpportunityCategories.isEmpty && selectedOpportunityCategories.count < OpportunityCategory.allCases.count {
            filteredOpportunities = filteredOpportunities.filter { selectedOpportunityCategories.contains($0.category) }
        }

        // Filter by deadline
        switch deadlineFilter {
        case .all:
            break
        case .thisWeek:
            let weekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= weekFromNow
            }
        case .thisMonth:
            let monthFromNow = Calendar.current.date(byAdding: .month, value: 1, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= monthFromNow
            }
        case .urgent:
            let weekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= weekFromNow
            }
        @unknown default:
            break
        }

        // Filter by search query
        if !searchQuery.isEmpty {
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                let searchText = ([opportunity.title, opportunity.organization, opportunity.description] + opportunity.requirements + opportunity.tags).joined(separator: " ").lowercased()
                return searchText.contains(searchQuery.lowercased())
            }
        }

        return createMixedListFromOpportunities(filteredOpportunities)
    }
    
    private func createMixedListFromOpportunities(_ opportunities: [Opportunity]) -> [Opportunity] {
        // Group opportunities by type
        var groupedByType: [OpportunityType: [Opportunity]] = [:]
        
        for opportunity in opportunities {
            if groupedByType[opportunity.type] == nil {
                groupedByType[opportunity.type] = []
            }
            groupedByType[opportunity.type]?.append(opportunity)
        }
        
        // Create mixed list by taking one from each type, cycling through
        var mixedList: [Opportunity] = []
        var typeIndices: [OpportunityType: Int] = [:]
        
        // Initialize indices
        for type in groupedByType.keys {
            typeIndices[type] = 0
        }
        
        // Build mixed list with all available opportunities
        while mixedList.count < opportunities.count {
            var addedInThisRound = false
            
            for type in groupedByType.keys.sorted(by: { $0.rawValue < $1.rawValue }) {
                guard let opportunitiesOfType = groupedByType[type],
                      let currentIndex = typeIndices[type],
                      currentIndex < opportunitiesOfType.count else { continue }
                
                let opportunity = opportunitiesOfType[currentIndex]
                mixedList.append(opportunity)
                typeIndices[type] = currentIndex + 1
                addedInThisRound = true
                
                if mixedList.count >= opportunities.count {
                    break
                }
            }
            
            // If no opportunities were added in this round, we've exhausted all types
            if !addedInThisRound {
                break
            }
        }
        
        return mixedList
    }
    
    // MARK: - Filtering Methods
    public func filterOpportunitiesByType(_ type: OpportunityType?) -> [Opportunity] {
        let now = Date()
        let activeOpportunities = opportunities
            .filter { $0.isActive }
            .filter { $0.deadline == nil || $0.deadline! > now }
        
        if let type = type {
            return activeOpportunities.filter { $0.type == type }
        } else {
            return activeOpportunities
        }
    }
    
    public func filterOpportunitiesByCategory(_ category: OpportunityCategory?) -> [Opportunity] {
        let now = Date()
        let activeOpportunities = opportunities
            .filter { $0.isActive }
            .filter { $0.deadline == nil || $0.deadline! > now }
        
        if let category = category {
            return activeOpportunities.filter { $0.category == category }
        } else {
            return activeOpportunities
        }
    }
    
    public func filterOpportunitiesByDeadline(withinDays days: Int) -> [Opportunity] {
        let now = Date()
        let deadlineDate = Calendar.current.date(byAdding: .day, value: days, to: now) ?? now
        
        return opportunities
            .filter { $0.isActive }
            .filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline > now && deadline <= deadlineDate
            }
    }
    
    public func searchOpportunities(query: String) -> [Opportunity] {
        let now = Date()
        let activeOpportunities = opportunities
            .filter { $0.isActive }
            .filter { $0.deadline == nil || $0.deadline! > now }
        
        if query.isEmpty {
            return activeOpportunities
        }
        
        return activeOpportunities.filter { opportunity in
            let searchText = ([opportunity.title, opportunity.organization, opportunity.description] + opportunity.requirements + opportunity.tags).joined(separator: " ").lowercased()
            return searchText.contains(query.lowercased())
        }
    }
    
    // MARK: - Advanced Filtering
    public func applyFilters(
        types: Set<OpportunityType>,
        categories: Set<OpportunityCategory>,
        deadline: DeadlineFilter,
        searchQuery: String
    ) {
        selectedOpportunityTypes = types
        selectedOpportunityCategories = categories
        deadlineFilter = deadline
        self.searchQuery = searchQuery
        
        // Apply filters to matched opportunities
        let now = Date()
        var filteredOpportunities = opportunities
            .filter { $0.isActive }
            .filter { $0.deadline == nil || $0.deadline! > now }
        
        // Filter by selected types
        if !types.isEmpty && types.count < OpportunityType.allCases.count {
            filteredOpportunities = filteredOpportunities.filter { types.contains($0.type) }
        }
        
        // Filter by selected categories
        if !categories.isEmpty && categories.count < OpportunityCategory.allCases.count {
            filteredOpportunities = filteredOpportunities.filter { categories.contains($0.category) }
        }
        
        // Filter by deadline
        switch deadline {
        case .all:
            break // No additional filtering
        case .thisWeek:
            let weekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= weekFromNow
            }
        case .thisMonth:
            let monthFromNow = Calendar.current.date(byAdding: .month, value: 1, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= monthFromNow
            }
        case .nextThreeMonths:
            let threeMonthsFromNow = Calendar.current.date(byAdding: .month, value: 3, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= threeMonthsFromNow
            }
        case .urgent:
            let weekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now) ?? now
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                guard let deadline = opportunity.deadline else { return false }
                return deadline <= weekFromNow
            }
        }
        
        // Filter by search query
        if !searchQuery.isEmpty {
            filteredOpportunities = filteredOpportunities.filter { opportunity in
                let searchText = ([opportunity.title, opportunity.organization, opportunity.description] + opportunity.requirements + opportunity.tags).joined(separator: " ").lowercased()
                return searchText.contains(searchQuery.lowercased())
            }
        }
        
        // Apply mixed ordering to filtered results
        matchedOpportunities = createMixedListFromOpportunities(filteredOpportunities)
        updateBackwardCompatibility()
    }
    
    public func updateMatchedScholarships() {
        // This now delegates to the opportunity matching
        updateMatchedOpportunities()
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
    
    // MARK: - Soundtrack Management
    public func playSoundtrack() {
        guard soundtrackEnabled else { stopSoundtrack(); return }
        if soundtrackPlayer?.isPlaying == true { return }
        if let url = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            do {
                soundtrackPlayer = try AVAudioPlayer(contentsOf: url)
                soundtrackPlayer?.numberOfLoops = -1
                soundtrackPlayer?.volume = 0.5
                soundtrackPlayer?.play()

                // this line of code stops the soudn track : 
               soundtrackPlayer?.stop() 

               
            } catch {
                print("Failed to play soundtrack: \(error)")
            }
        }

    
    }
    
    public func stopSoundtrack() {
        soundtrackPlayer = nil
    }
    
    public func updateSoundtrackState() {
        if soundtrackEnabled { playSoundtrack() } else { stopSoundtrack() }
    }
} 
import Foundation

struct Achievement: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let icon: String
    let points: Int
    let category: AchievementCategory
    let isUnlocked: Bool
    let unlockedDate: Date?
    
    init(id: UUID = UUID(), title: String, description: String, icon: String, points: Int, category: AchievementCategory, isUnlocked: Bool = false, unlockedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.icon = icon
        self.points = points
        self.category = category
        self.isUnlocked = isUnlocked
        self.unlockedDate = unlockedDate
    }
}

enum AchievementCategory: String, Codable {
    case application = "Application"
    case scholarship = "Scholarship"
    case profile = "Profile"
    case community = "Community"
    case special = "Special"
}

// Sample achievements
extension Achievement {
    static let sampleAchievements: [Achievement] = [
        Achievement(
            title: "First Launch",
            description: "Complete your first scholarship application",
            icon: "rocket.fill",
            points: 100,
            category: .application
        ),
        Achievement(
            title: "Stellar Profile",
            description: "Complete your profile with all required information",
            icon: "star.fill",
            points: 150,
            category: .profile
        ),
        Achievement(
            title: "Scholarship Explorer",
            description: "Apply to 5 different scholarships",
            icon: "globe.americas.fill",
            points: 200,
            category: .scholarship
        ),
        Achievement(
            title: "Community Star",
            description: "Participate in 3 study group sessions",
            icon: "person.3.fill",
            points: 175,
            category: .community
        ),
        Achievement(
            title: "Milestone Master",
            description: "Earn 1000 total points",
            icon: "trophy.fill",
            points: 300,
            category: .special
        )
    ]
} 
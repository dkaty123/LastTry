import Foundation

public struct Achievement: Identifiable, Codable {
    public let id: UUID
    public let title: String
    public let description: String
    public let icon: String
    public let points: Int
    public let category: AchievementCategory
    public let isUnlocked: Bool
    public let unlockedDate: Date?
    
    public init(id: UUID = UUID(), title: String, description: String, icon: String, points: Int, category: AchievementCategory, isUnlocked: Bool = false, unlockedDate: Date? = nil) {
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

public enum AchievementCategory: String, Codable, CaseIterable {
    case application = "Application"
    case scholarship = "Scholarship"
    case profile = "Profile"
    case community = "Community"
    case special = "Special"

    public static var allCases: [AchievementCategory] = [
        .application,
        .scholarship,
        .profile,
        .community,
        .special
    ]
}

// Sample achievements
extension Achievement {
    static let sampleAchievements: [Achievement] = [
        Achievement(
            title: "3-Day Streak!",
            description: "Logged in for 3 days in a row. Keep it up!",
            icon: "flame.fill",
            points: 50,
            category: .special
        ),
        Achievement(
            title: "7-Day Streak!",
            description: "A whole week of daily logins. You're on fire!",
            icon: "sun.max.fill",
            points: 100,
            category: .special
        ),
        Achievement(
            title: "14-Day Streak!",
            description: "Two weeks of consistency. Impressive!",
            icon: "calendar",
            points: 200,
            category: .special
        ),
        Achievement(
            title: "30-Day Streak!",
            description: "A month of daily logins. You legend!",
            icon: "crown.fill",
            points: 500,
            category: .special
        ),
        Achievement(
            title: "Coffee Chat with a Cracked Waterloo CS Student",
            description: "You've reached the ultimate 100-day streak. Enjoy a virtual coffee chat with a legendary Waterloo CS student!",
            icon: "cup.and.saucer.fill",
            points: 1000,
            category: .special
        )
    ]
} 
import Foundation
import SwiftUI

public class AchievementViewModel: ObservableObject {
    @Published public var achievements: [Achievement] = []
    @Published public var totalPoints: Int = 0
    @Published public var selectedCategory: AchievementCategory?
    
    public init() {
        loadAchievements()
    }
    
    private func loadAchievements() {
        // In a real app, this would load from persistent storage
        achievements = Achievement.sampleAchievements
        calculateTotalPoints()
    }
    
    public func calculateTotalPoints() {
        totalPoints = achievements.filter { $0.isUnlocked }.reduce(0) { $0 + $1.points }
    }
    
    public func unlockAchievement(_ achievement: Achievement) {
        if let index = achievements.firstIndex(where: { $0.id == achievement.id }) {
            var updatedAchievement = achievement
            updatedAchievement = Achievement(
                id: achievement.id,
                title: achievement.title,
                description: achievement.description,
                icon: achievement.icon,
                points: achievement.points,
                category: achievement.category,
                isUnlocked: true,
                unlockedDate: Date()
            )
            achievements[index] = updatedAchievement
            calculateTotalPoints()
        }
    }
    
    public func filterAchievements(by category: AchievementCategory?) {
        selectedCategory = category
    }
    
    public var filteredAchievements: [Achievement] {
        guard let category = selectedCategory else {
            return achievements
        }
        return achievements.filter { $0.category == category }
    }
    
    // Call this after updating streakCount
    public func checkAndUnlockStreakAchievements(streakCount: Int) {
        let streakMilestones = [3, 7, 14, 30, 100]
        guard streakMilestones.contains(streakCount) else { return }
        if let achievement = achievements.first(where: { achievement in
            (achievement.title.contains("3-Day") && streakCount == 3) ||
            (achievement.title.contains("7-Day") && streakCount == 7) ||
            (achievement.title.contains("14-Day") && streakCount == 14) ||
            (achievement.title.contains("30-Day") && streakCount == 30) ||
            (achievement.title.contains("Coffee Chat") && streakCount == 100)
        }), !achievement.isUnlocked {
            unlockAchievement(achievement)
        }
    }
} 
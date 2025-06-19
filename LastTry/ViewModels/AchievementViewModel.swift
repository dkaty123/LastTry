import Foundation
import SwiftUI

class AchievementViewModel: ObservableObject {
    @Published var achievements: [Achievement] = []
    @Published var totalPoints: Int = 0
    @Published var selectedCategory: AchievementCategory?
    
    init() {
        loadAchievements()
    }
    
    private func loadAchievements() {
        // In a real app, this would load from persistent storage
        achievements = Achievement.sampleAchievements
        calculateTotalPoints()
    }
    
    func calculateTotalPoints() {
        totalPoints = achievements.filter { $0.isUnlocked }.reduce(0) { $0 + $1.points }
    }
    
    func unlockAchievement(_ achievement: Achievement) {
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
    
    func filterAchievements(by category: AchievementCategory?) {
        selectedCategory = category
    }
    
    var filteredAchievements: [Achievement] {
        guard let category = selectedCategory else {
            return achievements
        }
        return achievements.filter { $0.category == category }
    }
} 
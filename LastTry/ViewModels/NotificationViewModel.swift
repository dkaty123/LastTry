import Foundation
import SwiftUI

class NotificationViewModel: ObservableObject {
    @Published var notifications: [ScholarshipNotification] = []
    @Published var selectedType: NotificationType?
    @Published var unreadCount: Int = 0
    
    init() {
        loadNotifications()
    }
    
    private func loadNotifications() {
        // In a real app, this would load from persistent storage
        notifications = ScholarshipNotification.sampleNotifications
        updateUnreadCount()
    }
    
    func updateUnreadCount() {
        unreadCount = notifications.filter { !$0.isRead }.count
    }
    
    func markAsRead(_ notification: ScholarshipNotification) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            var updatedNotification = notification
            updatedNotification = ScholarshipNotification(
                id: notification.id,
                title: notification.title,
                message: notification.message,
                type: notification.type,
                priority: notification.priority,
                timestamp: notification.timestamp,
                isRead: true,
                actionURL: notification.actionURL
            )
            notifications[index] = updatedNotification
            updateUnreadCount()
        }
    }
    
    func markAllAsRead() {
        notifications = notifications.map { notification in
            ScholarshipNotification(
                id: notification.id,
                title: notification.title,
                message: notification.message,
                type: notification.type,
                priority: notification.priority,
                timestamp: notification.timestamp,
                isRead: true,
                actionURL: notification.actionURL
            )
        }
        updateUnreadCount()
    }
    
    func filterNotifications(by type: NotificationType?) {
        selectedType = type
    }
    
    var filteredNotifications: [ScholarshipNotification] {
        guard let type = selectedType else {
            return notifications
        }
        return notifications.filter { $0.type == type }
    }
    
    func addNotification(_ notification: ScholarshipNotification) {
        notifications.insert(notification, at: 0)
        updateUnreadCount()
    }
} 
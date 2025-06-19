import Foundation

struct ScholarshipNotification: Identifiable, Codable {
    let id: UUID
    let title: String
    let message: String
    let type: NotificationType
    let priority: NotificationPriority
    let timestamp: Date
    let isRead: Bool
    let actionURL: String?
    
    init(id: UUID = UUID(), title: String, message: String, type: NotificationType, priority: NotificationPriority, timestamp: Date = Date(), isRead: Bool = false, actionURL: String? = nil) {
        self.id = id
        self.title = title
        self.message = message
        self.type = type
        self.priority = priority
        self.timestamp = timestamp
        self.isRead = isRead
        self.actionURL = actionURL
    }
}

enum NotificationType: String, Codable {
    case deadline = "Deadline"
    case newMatch = "New Match"
    case status = "Status Update"
    case document = "Document"
    case system = "System"
    
    var icon: String {
        switch self {
        case .deadline: return "clock.fill"
        case .newMatch: return "star.fill"
        case .status: return "arrow.triangle.2.circlepath"
        case .document: return "doc.fill"
        case .system: return "gear"
        }
    }
    
    var color: String {
        switch self {
        case .deadline: return "red"
        case .newMatch: return "yellow"
        case .status: return "blue"
        case .document: return "green"
        case .system: return "purple"
        }
    }
}

enum NotificationPriority: String, Codable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

// Sample notifications
extension ScholarshipNotification {
    static let sampleNotifications: [ScholarshipNotification] = [
        ScholarshipNotification(
            title: "Deadline Approaching",
            message: "NASA Space Grant Scholarship application due in 3 days",
            type: .deadline,
            priority: .high
        ),
        ScholarshipNotification(
            title: "New Match Found",
            message: "You match 95% with the SpaceX Innovation Scholarship",
            type: .newMatch,
            priority: .medium
        ),
        ScholarshipNotification(
            title: "Application Status Update",
            message: "Your MIT Scholarship application is under review",
            type: .status,
            priority: .medium
        ),
        ScholarshipNotification(
            title: "Document Expiring",
            message: "Your recommendation letter will expire in 7 days",
            type: .document,
            priority: .high
        ),
        ScholarshipNotification(
            title: "System Update",
            message: "New features available in the app",
            type: .system,
            priority: .low
        )
    ]
} 
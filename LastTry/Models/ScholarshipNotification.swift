import Foundation

// MARK: - Updated Notification Models for Opportunities
public struct OpportunityNotification: Identifiable, Codable {
    public let id: UUID
    public let title: String
    public let message: String
    public let type: NotificationType
    public let priority: NotificationPriority
    public let timestamp: Date
    public let isRead: Bool
    public let actionURL: String?
    public let opportunityType: OpportunityType?
    
    public init(id: UUID = UUID(), title: String, message: String, type: NotificationType, priority: NotificationPriority, timestamp: Date = Date(), isRead: Bool = false, actionURL: String? = nil, opportunityType: OpportunityType? = nil) {
        self.id = id
        self.title = title
        self.message = message
        self.type = type
        self.priority = priority
        self.timestamp = timestamp
        self.isRead = isRead
        self.actionURL = actionURL
        self.opportunityType = opportunityType
    }
}

// MARK: - Backward Compatibility for Scholarship Notifications
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
    
    // Convert to OpportunityNotification
    func toOpportunityNotification() -> OpportunityNotification {
        return OpportunityNotification(
            id: id,
            title: title,
            message: message,
            type: type,
            priority: priority,
            timestamp: timestamp,
            isRead: isRead,
            actionURL: actionURL,
            opportunityType: .scholarship
        )
    }
}

// MARK: - Notification Types (expanded for opportunities)
public enum NotificationType: String, Codable, CaseIterable {
    case deadline = "Deadline"
    case newMatch = "New Match"
    case status = "Status Update"
    case document = "Document"
    case system = "System"
    case reminder = "Reminder"
    case update = "Update"
    
    public var icon: String {
        switch self {
        case .deadline: return "clock.fill"
        case .newMatch: return "star.fill"
        case .status: return "arrow.triangle.2.circlepath"
        case .document: return "doc.fill"
        case .system: return "gear"
        case .reminder: return "bell.fill"
        case .update: return "info.circle.fill"
        }
    }
    
    public var color: String {
        switch self {
        case .deadline: return "red"
        case .newMatch: return "yellow"
        case .status: return "blue"
        case .document: return "green"
        case .system: return "purple"
        case .reminder: return "orange"
        case .update: return "cyan"
        }
    }
}

// MARK: - Notification Priority (unchanged)
public enum NotificationPriority: String, Codable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

// MARK: - Sample Notifications
extension OpportunityNotification {
    static let sampleNotifications: [OpportunityNotification] = [
        OpportunityNotification(
            title: "Deadline Approaching",
            message: "NASA Space Grant Scholarship application due in 3 days",
            type: .deadline,
            priority: .high,
            opportunityType: .scholarship
        ),
        OpportunityNotification(
            title: "New Internship Match",
            message: "You match 95% with the SpaceX Innovation Internship",
            type: .newMatch,
            priority: .medium,
            opportunityType: .internship
        ),
        OpportunityNotification(
            title: "Application Status Update",
            message: "Your MIT Scholarship application is under review",
            type: .status,
            priority: .medium,
            opportunityType: .scholarship
        ),
        OpportunityNotification(
            title: "Conference Registration Open",
            message: "Environmental Leadership Summit registration is now open",
            type: .update,
            priority: .medium,
            opportunityType: .conference
        ),
        OpportunityNotification(
            title: "Document Expiring",
            message: "Your recommendation letter will expire in 7 days",
            type: .document,
            priority: .high
        ),
        OpportunityNotification(
            title: "System Update",
            message: "New features available in the app",
            type: .system,
            priority: .low
        )
    ]
}

// MARK: - Backward Compatibility Sample Notifications
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
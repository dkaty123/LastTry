import Foundation

struct ScholarshipAlert: Identifiable, Codable {
    let id: UUID
    let scholarshipName: String
    let amount: Double
    let description: String
    let deadline: Date
    let matchPercentage: Double
    let urgency: UrgencyLevel
    let createdTime: Date
    var isRead: Bool
    var isUrgent: Bool
    
    enum UrgencyLevel: String, Codable, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
    }
    
    init(id: UUID = UUID(), scholarshipName: String, amount: Double, description: String, deadline: Date, matchPercentage: Double, urgency: UrgencyLevel = .medium, createdTime: Date = Date(), isRead: Bool = false, isUrgent: Bool = false) {
        self.id = id
        self.scholarshipName = scholarshipName
        self.amount = amount
        self.description = description
        self.deadline = deadline
        self.matchPercentage = matchPercentage
        self.urgency = urgency
        self.createdTime = createdTime
        self.isRead = isRead
        self.isUrgent = isUrgent
    }
} 
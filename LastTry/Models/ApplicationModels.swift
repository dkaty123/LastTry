import Foundation
import SwiftUI

struct ScholarshipApplication: Identifiable, Equatable {
    let id: UUID
    var scholarshipName: String
    var status: ApplicationStatus
    var deadline: Date
    var category: Scholarship.ScholarshipCategory
    var documents: [ApplicationDocument]
    var milestones: [ApplicationMilestone]
    
    init(id: UUID = UUID(), scholarshipName: String, status: ApplicationStatus = .inProgress, deadline: Date, category: Scholarship.ScholarshipCategory, documents: [ApplicationDocument] = [], milestones: [ApplicationMilestone] = []) {
        self.id = id
        self.scholarshipName = scholarshipName
        self.status = status
        self.deadline = deadline
        self.category = category
        self.documents = documents
        self.milestones = milestones
    }
}

enum ApplicationStatus: String, CaseIterable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case submitted = "Submitted"
    case accepted = "Accepted"
    case rejected = "Rejected"
    
    var color: Color {
        switch self {
        case .notStarted: return .gray
        case .inProgress: return .blue
        case .submitted: return .orange
        case .accepted: return .green
        case .rejected: return .red
        }
    }
}

struct ApplicationDocument: Identifiable, Equatable {
    let id: UUID
    var name: String
    var type: DocumentType
    var isUploaded: Bool
    var uploadDate: Date?
    
    init(id: UUID = UUID(), name: String, type: DocumentType, isUploaded: Bool = false, uploadDate: Date? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.isUploaded = isUploaded
        self.uploadDate = uploadDate
    }
}

enum DocumentType: String, CaseIterable {
    case transcript = "Transcript"
    case essay = "Essay"
    case recommendation = "Recommendation"
    case resume = "Resume"
    case other = "Other"
}

struct ApplicationMilestone: Identifiable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, description: String, dueDate: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
} 
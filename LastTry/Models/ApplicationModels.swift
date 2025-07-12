import Foundation
import SwiftUI

// MARK: - Updated Application Models for Opportunities
public struct OpportunityApplication: Identifiable, Equatable {
    public let id: UUID
    public var opportunityTitle: String
    public var opportunityType: OpportunityType
    public var status: ApplicationStatus
    public var deadline: Date?
    public var category: OpportunityCategory
    public var documents: [ApplicationDocument]
    public var milestones: [ApplicationMilestone]
    
    public init(id: UUID = UUID(), opportunityTitle: String, opportunityType: OpportunityType, status: ApplicationStatus = .inProgress, deadline: Date? = nil, category: OpportunityCategory, documents: [ApplicationDocument] = [], milestones: [ApplicationMilestone] = []) {
        self.id = id
        self.opportunityTitle = opportunityTitle
        self.opportunityType = opportunityType
        self.status = status
        self.deadline = deadline
        self.category = category
        self.documents = documents
        self.milestones = milestones
    }
}

// MARK: - Backward Compatibility for Scholarship Applications
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
    
    // Convert to OpportunityApplication
    func toOpportunityApplication() -> OpportunityApplication {
        return OpportunityApplication(
            id: id,
            opportunityTitle: scholarshipName,
            opportunityType: .scholarship,
            status: status,
            deadline: deadline,
            category: OpportunityCategory(rawValue: category.rawValue.capitalized) ?? .general,
            documents: documents,
            milestones: milestones
        )
    }
}

// MARK: - Application Status (unchanged)
public enum ApplicationStatus: String, CaseIterable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case submitted = "Submitted"
    case accepted = "Accepted"
    case rejected = "Rejected"
    
    public var color: Color {
        switch self {
        case .notStarted: return .gray
        case .inProgress: return .blue
        case .submitted: return .orange
        case .accepted: return .green
        case .rejected: return .red
        }
    }
}

// MARK: - Application Document (unchanged)
public struct ApplicationDocument: Identifiable, Equatable {
    public let id: UUID
    public var name: String
    public var type: DocumentType
    public var isUploaded: Bool
    public var uploadDate: Date?
    
    public init(id: UUID = UUID(), name: String, type: DocumentType, isUploaded: Bool = false, uploadDate: Date? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.isUploaded = isUploaded
        self.uploadDate = uploadDate
    }
}

// MARK: - Document Type (expanded for opportunities)
public enum DocumentType: String, CaseIterable {
    case transcript = "Transcript"
    case essay = "Essay"
    case recommendation = "Recommendation"
    case resume = "Resume"
    case coverLetter = "Cover Letter"
    case portfolio = "Portfolio"
    case projectProposal = "Project Proposal"
    case researchPaper = "Research Paper"
    case videoSubmission = "Video Submission"
    case other = "Other"
}

// MARK: - Application Milestone (unchanged)
public struct ApplicationMilestone: Identifiable, Equatable {
    public let id: UUID
    public var title: String
    public var description: String
    public var dueDate: Date
    public var isCompleted: Bool
    
    public init(id: UUID = UUID(), title: String, description: String, dueDate: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
} 
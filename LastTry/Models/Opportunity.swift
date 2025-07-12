import Foundation
import SwiftUI

// MARK: - Deadline Filter
public enum DeadlineFilter: String, CaseIterable {
    case all = "All Deadlines"
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case nextThreeMonths = "Next 3 Months"
    case urgent = "Urgent (< 1 week)"
    
    public var displayName: String {
        return self.rawValue
    }
}

// MARK: - Opportunity Types
public enum OpportunityType: String, Codable, CaseIterable, Equatable {
    case scholarship = "Scholarship"
    case internship = "Internship"
    case fellowship = "Fellowship"
    case conference = "Conference"
    case competition = "Competition"
    case grant = "Grant"
    case leadership = "Leadership Program"
    case volunteer = "Volunteer"
    case bootcamp = "Bootcamp"
    case exchange = "Exchange Program"
    
    public var displayName: String {
        return self.rawValue
    }
    
    public var icon: String {
        switch self {
        case .scholarship: return "graduationcap.fill"
        case .internship: return "briefcase.fill"
        case .fellowship: return "person.2.fill"
        case .conference: return "person.3.fill"
        case .competition: return "trophy.fill"
        case .grant: return "dollarsign.circle.fill"
        case .leadership: return "star.fill"
        case .volunteer: return "heart.fill"
        case .bootcamp: return "laptopcomputer"
        case .exchange: return "airplane"
        }
    }
    
    public var color: String {
        switch self {
        case .scholarship: return "blue"
        case .internship: return "green"
        case .fellowship: return "purple"
        case .conference: return "orange"
        case .competition: return "yellow"
        case .grant: return "red"
        case .leadership: return "pink"
        case .volunteer: return "mint"
        case .bootcamp: return "indigo"
        case .exchange: return "teal"
        }
    }
    
    public var displayColor: String {
        switch self {
        case .scholarship: return "blue"
        case .internship: return "green"
        case .fellowship: return "purple"
        case .conference: return "orange"
        case .competition: return "yellow"
        case .grant: return "red"
        case .leadership: return "pink"
        case .volunteer: return "mint"
        case .bootcamp: return "indigo"
        case .exchange: return "teal"
        }
    }
}

// MARK: - Opportunity Categories (expanded from scholarship categories)
public enum OpportunityCategory: String, Codable, CaseIterable, Equatable {
    case stem = "STEM"
    case arts = "Arts"
    case humanities = "Humanities"
    case business = "Business"
    case general = "General"
    case technology = "Technology"
    case healthcare = "Healthcare"
    case environment = "Environment"
    case socialJustice = "Social Justice"
    case entrepreneurship = "Entrepreneurship"
    case research = "Research"
    case communityService = "Community Service"
    
    public var displayName: String {
        return self.rawValue
    }
    
    public var icon: String {
        switch self {
        case .stem: return "atom"
        case .arts: return "paintbrush.fill"
        case .humanities: return "book.fill"
        case .business: return "building.2.fill"
        case .general: return "star.fill"
        case .technology: return "laptopcomputer"
        case .healthcare: return "cross.fill"
        case .environment: return "leaf.fill"
        case .socialJustice: return "heart.fill"
        case .entrepreneurship: return "lightbulb.fill"
        case .research: return "magnifyingglass"
        case .communityService: return "person.3.fill"
        }
    }
    
    public var color: String {
        switch self {
        case .stem: return "blue"
        case .arts: return "purple"
        case .humanities: return "orange"
        case .business: return "green"
        case .general: return "gray"
        case .technology: return "indigo"
        case .healthcare: return "red"
        case .environment: return "mint"
        case .socialJustice: return "pink"
        case .entrepreneurship: return "yellow"
        case .research: return "teal"
        case .communityService: return "cyan"
        }
    }
}

// MARK: - Main Opportunity Model
public struct Opportunity: Identifiable, Codable, Equatable {
    public let id: UUID
    public let title: String
    public let type: OpportunityType
    public let category: OpportunityCategory
    public let organization: String
    public let description: String
    public let requirements: [String]
    public let benefits: [String]
    public let deadline: Date?
    public let startDate: Date?
    public let endDate: Date?
    public let location: String?
    public let isRemote: Bool
    public let amount: Double?
    public let stipend: Double?
    public let applicationUrl: String?
    public let website: String?
    public let contactEmail: String?
    public let tags: [String]
    public let isActive: Bool
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(
        id: UUID = UUID(),
        title: String,
        type: OpportunityType,
        category: OpportunityCategory,
        organization: String,
        description: String,
        requirements: [String],
        benefits: [String] = [],
        deadline: Date? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        location: String? = nil,
        isRemote: Bool = false,
        amount: Double? = nil,
        stipend: Double? = nil,
        applicationUrl: String? = nil,
        website: String? = nil,
        contactEmail: String? = nil,
        tags: [String] = [],
        isActive: Bool = true,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.type = type
        self.category = category
        self.organization = organization
        self.description = description
        self.requirements = requirements
        self.benefits = benefits
        self.deadline = deadline
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.isRemote = isRemote
        self.amount = amount
        self.stipend = stipend
        self.applicationUrl = applicationUrl
        self.website = website
        self.contactEmail = contactEmail
        self.tags = tags
        self.isActive = isActive
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Backward Compatibility Extension
extension Opportunity {
    // Convert from old Scholarship model
    public init(from scholarship: Scholarship) {
        self.init(
            id: scholarship.id,
            title: scholarship.name,
            type: .scholarship,
            category: OpportunityCategory(rawValue: scholarship.category.rawValue.capitalized) ?? .general,
            organization: "Various Organizations",
            description: scholarship.description,
            requirements: scholarship.requirements,
            benefits: ["Financial support for education"],
            deadline: scholarship.deadline,
            amount: scholarship.amount,
            website: scholarship.website
        )
    }
    
    // Convert to old Scholarship model for backward compatibility
    public func toScholarship() -> Scholarship? {
        guard type == .scholarship else { return nil }
        
        return Scholarship(
            id: id,
            name: title,
            amount: amount ?? 0.0,
            deadline: deadline ?? Date(),
            description: description,
            category: Scholarship.ScholarshipCategory(rawValue: category.rawValue.lowercased()) ?? .general,
            requirements: requirements,
            website: website
        )
    }
}

// MARK: - Sample Data
extension Opportunity {
    public static var sampleOpportunities: [Opportunity] {
        [
            Opportunity(
                title: "Galactic STEM Explorer",
                type: .scholarship,
                category: .stem,
                organization: "NASA",
                description: "A stellar opportunity for future space engineers!",
                requirements: ["3.5+ GPA", "STEM Major", "Research Experience"],
                benefits: ["$10,000 scholarship", "NASA mentorship", "Research opportunities"],
                deadline: Date().addingTimeInterval(86400 * 30),
                amount: 10000,
                website: "https://example.com/stem"
            ),
            Opportunity(
                title: "Tech Startup Internship",
                type: .internship,
                category: .technology,
                organization: "SpaceX",
                description: "Join the future of space technology!",
                requirements: ["Computer Science major", "Python experience", "3.0+ GPA"],
                benefits: ["$25/hour stipend", "Mentorship", "Potential full-time offer"],
                deadline: Date().addingTimeInterval(86400 * 45),
                startDate: Date().addingTimeInterval(86400 * 60),
                endDate: Date().addingTimeInterval(86400 * 120),
                location: "Hawthorne, CA",
                isRemote: false,
                stipend: 25.0,
                applicationUrl: "https://example.com/internship"
            ),
            Opportunity(
                title: "Environmental Leadership Summit",
                type: .conference,
                category: .environment,
                organization: "EarthEcho International",
                description: "Connect with environmental leaders and innovators!",
                requirements: ["Passion for environment", "Leadership experience"],
                benefits: ["Networking", "Skill development", "Travel covered"],
                deadline: Date().addingTimeInterval(86400 * 20),
                startDate: Date().addingTimeInterval(86400 * 40),
                endDate: Date().addingTimeInterval(86400 * 43),
                location: "Vancouver, BC",
                isRemote: false,
                applicationUrl: "https://example.com/conference"
            )
        ]
    }
} 
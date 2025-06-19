import Foundation

public struct Scholarship: Identifiable, Codable {
    public let id: UUID
    public let name: String
    public let amount: Double
    public let deadline: Date
    public let description: String
    public let category: ScholarshipCategory
    public let requirements: [String]
    public let website: String?
    
    public enum ScholarshipCategory: String, Codable {
        case stem
        case arts
        case humanities
        case business
        case general
    }
    
    public init(id: UUID = UUID(), name: String, amount: Double, deadline: Date, description: String, category: ScholarshipCategory, requirements: [String], website: String? = nil) {
        self.id = id
        self.name = name
        self.amount = amount
        self.deadline = deadline
        self.description = description
        self.category = category
        self.requirements = requirements
        self.website = website
    }
}

// Extension for sample data
extension Scholarship {
    public static var sampleScholarships: [Scholarship] {
        [
            Scholarship(
                name: "Galactic STEM Explorer",
                amount: 10000,
                deadline: Date().addingTimeInterval(86400 * 30),
                description: "A stellar opportunity for future space engineers!",
                category: .stem,
                requirements: ["3.5+ GPA", "STEM Major", "Research Experience"],
                website: "https://example.com/stem"
            ),
            Scholarship(
                name: "Cosmic Arts Fellowship",
                amount: 5000,
                deadline: Date().addingTimeInterval(86400 * 45),
                description: "For creative minds reaching for the stars!",
                category: .arts,
                requirements: ["Portfolio", "2.8+ GPA", "Art Major"],
                website: "https://example.com/arts"
            )
        ]
    }
} 
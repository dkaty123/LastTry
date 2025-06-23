import Foundation

struct Essay: Identifiable, Codable {
    let id: UUID
    let title: String
    var content: String
    let scholarshipName: String
    var status: EssayStatus
    var plagiarismChecked: Bool
    let wordCount: Int
    let createdDate: Date
    var lastModified: Date
    var aiSuggestions: [AISuggestion]
    var plagiarismScore: Double?
    
    enum EssayStatus: String, Codable, CaseIterable {
        case draft = "Draft"
        case polished = "Polished"
        case final = "Final"
    }
    
    init(id: UUID = UUID(), title: String, content: String, scholarshipName: String, status: EssayStatus = .draft, plagiarismChecked: Bool = false, wordCount: Int, createdDate: Date = Date(), lastModified: Date = Date(), aiSuggestions: [AISuggestion] = [], plagiarismScore: Double? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.scholarshipName = scholarshipName
        self.status = status
        self.plagiarismChecked = plagiarismChecked
        self.wordCount = wordCount
        self.createdDate = createdDate
        self.lastModified = lastModified
        self.aiSuggestions = aiSuggestions
        self.plagiarismScore = plagiarismScore
    }
}

struct AISuggestion: Identifiable, Codable {
    let id: UUID
    let type: SuggestionType
    let content: String
    let confidence: Double
    var applied: Bool
    
    enum SuggestionType: String, Codable, CaseIterable {
        case hook = "Hook"
        case rewrite = "Rewrite"
        case edit = "Edit"
        case tone = "Tone"
        case structure = "Structure"
    }
    
    init(id: UUID = UUID(), type: SuggestionType, content: String, confidence: Double, applied: Bool = false) {
        self.id = id
        self.type = type
        self.content = content
        self.confidence = confidence
        self.applied = applied
    }
} 
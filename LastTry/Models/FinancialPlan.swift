import Foundation

struct FinancialPlan: Identifiable, Codable {
    let id: UUID
    var totalCost: Double
    var scholarships: [ScholarshipAmount]
    var expenses: [Expense]
    var savings: Double
    var monthlyBudget: Double
    
    struct ScholarshipAmount: Identifiable, Codable {
        let id: UUID
        let scholarshipId: UUID
        let amount: Double
        let isConfirmed: Bool
        
        public init(id: UUID = UUID(), scholarshipId: UUID, amount: Double, isConfirmed: Bool) {
            self.id = id
            self.scholarshipId = scholarshipId
            self.amount = amount
            self.isConfirmed = isConfirmed
        }
    }
    
    struct Expense: Identifiable, Codable {
        let id: UUID
        let name: String
        let amount: Double
        let category: ExpenseCategory
        let frequency: ExpenseFrequency
        let isRecurring: Bool
        
        enum ExpenseCategory: String, Codable, CaseIterable {
            case tuition
            case housing
            case books
            case transportation
            case food
            case entertainment
            case other
        }
        
        enum ExpenseFrequency: String, Codable, CaseIterable {
            case oneTime = "One Time"
            case monthly
            case semester
            case yearly
        }
        
        public init(id: UUID = UUID(), name: String, amount: Double, category: ExpenseCategory, frequency: ExpenseFrequency, isRecurring: Bool) {
            self.id = id
            self.name = name
            self.amount = amount
            self.category = category
            self.frequency = frequency
            self.isRecurring = isRecurring
        }
    }
    
    init(id: UUID = UUID(), totalCost: Double, scholarships: [ScholarshipAmount] = [], expenses: [Expense] = [], savings: Double = 0, monthlyBudget: Double = 0) {
        self.id = id
        self.totalCost = totalCost
        self.scholarships = scholarships
        self.expenses = expenses
        self.savings = savings
        self.monthlyBudget = monthlyBudget
    }
}

// Extension for sample data
extension FinancialPlan {
    static var samplePlan: FinancialPlan {
        FinancialPlan(
            totalCost: 50000,
            scholarships: [
                ScholarshipAmount(scholarshipId: UUID(), amount: 10000, isConfirmed: true),
                ScholarshipAmount(scholarshipId: UUID(), amount: 5000, isConfirmed: false)
            ],
            expenses: [
                Expense(name: "Tuition", amount: 25000, category: .tuition, frequency: .yearly, isRecurring: true),
                Expense(name: "Housing", amount: 1200, category: .housing, frequency: .monthly, isRecurring: true),
                Expense(name: "Books", amount: 500, category: .books, frequency: .semester, isRecurring: true)
            ],
            savings: 5000,
            monthlyBudget: 2000
        )
    }
} 
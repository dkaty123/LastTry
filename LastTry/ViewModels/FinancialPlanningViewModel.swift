import Foundation
import Combine

class FinancialPlanningViewModel: ObservableObject {
    @Published var financialPlan: FinancialPlan
    @Published var selectedTimeFrame: TimeFrame = .yearly
    @Published var showingAddExpense = false
    @Published var showingAddScholarship = false
    
    enum TimeFrame: String, CaseIterable {
        case monthly = "Monthly"
        case semester = "Semester"
        case yearly = "Yearly"
    }
    
    init(initialPlan: FinancialPlan = .samplePlan) {
        self.financialPlan = initialPlan
    }
    
    var totalScholarships: Double {
        financialPlan.scholarships.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpenses: Double {
        financialPlan.expenses.reduce(0) { $0 + $1.amount }
    }
    
    var remainingBalance: Double {
        financialPlan.totalCost - totalScholarships - financialPlan.savings
    }
    
    var monthlyExpenses: Double {
        financialPlan.expenses.reduce(0) { total, expense in
            switch expense.frequency {
            case .monthly:
                return total + expense.amount
            case .semester:
                return total + (expense.amount / 6)
            case .yearly:
                return total + (expense.amount / 12)
            case .oneTime:
                return total
            }
        }
    }
    
    func addExpense(_ expense: FinancialPlan.Expense) {
        financialPlan.expenses.append(expense)
    }
    
    func removeExpense(_ expense: FinancialPlan.Expense) {
        financialPlan.expenses.removeAll { $0.id == expense.id }
    }
    
    func addScholarship(_ scholarship: FinancialPlan.ScholarshipAmount) {
        financialPlan.scholarships.append(scholarship)
    }
    
    func removeScholarship(_ scholarship: FinancialPlan.ScholarshipAmount) {
        financialPlan.scholarships.removeAll { $0.id == scholarship.id }
    }
    
    func updateSavings(_ amount: Double) {
        financialPlan.savings = amount
    }
    
    func updateMonthlyBudget(_ amount: Double) {
        financialPlan.monthlyBudget = amount
    }
    
    func calculateROI() -> Double {
        let totalInvestment = financialPlan.totalCost
        let totalReturn = totalScholarships + financialPlan.savings
        return (totalReturn / totalInvestment) * 100
    }
    
    func updateTotalCost(_ amount: Double) {
        financialPlan.totalCost = amount
    }
} 
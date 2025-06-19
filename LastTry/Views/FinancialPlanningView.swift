import SwiftUI
import Charts

struct FinancialPlanningView: View {
    @StateObject private var viewModel = FinancialPlanningViewModel()
    
    init() {
        // Set the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Theme.backgroundColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.backgroundColor
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        overviewSection
                        expensesSection
                        scholarshipsSection
                        savingsSection
                        budgetSection
                    }
                    .padding()
                }
            }
            .navigationTitle("Financial Planning")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewModel.showingAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.showingAddScholarship) {
                AddScholarshipView(viewModel: viewModel)
            }
        }
    }
    
    private var overviewSection: some View {
        VStack(spacing: 15) {
            Text("Financial Overview")
                .font(.title2.bold())
                .foregroundColor(Theme.textColor)
            
            HStack {
                EditableFinancialCard(
                    title: "Total Cost",
                    amount: viewModel.financialPlan.totalCost,
                    icon: "dollarsign.circle.fill",
                    color: Theme.errorColor,
                    onCommit: { newValue in
                        viewModel.updateTotalCost(newValue)
                    }
                )
                
                EditableFinancialCard(
                    title: "Scholarships",
                    amount: viewModel.totalScholarships,
                    icon: "star.circle.fill",
                    color: Theme.successColor,
                    isScholarship: true,
                    onScholarshipTap: {
                        viewModel.showingAddScholarship = true
                    }
                )
            }
            
            HStack {
                EditableFinancialCard(
                    title: "Savings",
                    amount: viewModel.financialPlan.savings,
                    icon: "banknote.fill",
                    color: Theme.accentColor,
                    onCommit: { newValue in
                        viewModel.updateSavings(newValue)
                    }
                )
                
                FinancialCard(
                    title: "Remaining",
                    amount: viewModel.remainingBalance,
                    icon: "chart.line.uptrend.xyaxis.circle.fill",
                    color: .orange
                )
            }
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
    
    private var expensesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Expenses")
                .font(.title2.bold())
                .foregroundColor(Theme.textColor)
            
            ForEach(viewModel.financialPlan.expenses) { expense in
                ExpenseRow(expense: expense)
            }
            
            if viewModel.financialPlan.expenses.isEmpty {
                Text("No expenses added yet")
                    .foregroundColor(Theme.textColor.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
    
    private var scholarshipsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Scholarships")
                .font(.title2.bold())
                .foregroundColor(Theme.textColor)
            
            ForEach(viewModel.financialPlan.scholarships) { scholarship in
                ScholarshipRow(scholarship: scholarship)
            }
            
            if viewModel.financialPlan.scholarships.isEmpty {
                Text("No scholarships added yet")
                    .foregroundColor(Theme.textColor.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
    
    private var savingsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Savings & Budget")
                .font(.title2.bold())
                .foregroundColor(Theme.textColor)
            
            VStack(spacing: 10) {
                HStack {
                    Text("Monthly Budget")
                        .foregroundColor(Theme.textColor)
                    Spacer()
                    TextField("Amount", value: $viewModel.financialPlan.monthlyBudget, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Theme.textColor)
                }
                
                Divider()
                    .background(Theme.cardBorder)
                
                HStack {
                    Text("Current Savings")
                        .foregroundColor(Theme.textColor)
                    Spacer()
                    TextField("Amount", value: $viewModel.financialPlan.savings, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Theme.textColor)
                }
            }
            .padding()
            .background(Theme.cardBackground.opacity(0.5))
            .cornerRadius(15)
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
    
    private var budgetSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Monthly Budget Analysis")
                .font(.title2.bold())
                .foregroundColor(Theme.textColor)
            
            VStack(spacing: 10) {
                HStack {
                    Text("Monthly Expenses")
                        .foregroundColor(Theme.textColor)
                    Spacer()
                    Text(viewModel.monthlyExpenses, format: .currency(code: "USD"))
                        .foregroundColor(Theme.textColor)
                }
                
                Divider()
                    .background(Theme.cardBorder)
                
                HStack {
                    Text("Monthly Budget")
                        .foregroundColor(Theme.textColor)
                    Spacer()
                    Text(viewModel.financialPlan.monthlyBudget, format: .currency(code: "USD"))
                        .foregroundColor(Theme.textColor)
                }
                
                Divider()
                    .background(Theme.cardBorder)
                
                HStack {
                    Text("Remaining")
                        .foregroundColor(Theme.textColor)
                    Spacer()
                    Text(viewModel.financialPlan.monthlyBudget - viewModel.monthlyExpenses, format: .currency(code: "USD"))
                        .foregroundColor(viewModel.financialPlan.monthlyBudget - viewModel.monthlyExpenses >= 0 ? Theme.successColor : Theme.errorColor)
                }
            }
            .padding()
            .background(Theme.cardBackground.opacity(0.5))
            .cornerRadius(15)
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
}

struct FinancialCard: View {
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(Theme.textColor)
            
            Text(amount, format: .currency(code: "USD"))
                .font(.headline)
                .foregroundColor(Theme.textColor)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.cardBackground.opacity(0.5))
        .cornerRadius(15)
    }
}

struct ExpenseRow: View {
    let expense: FinancialPlan.Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                    .foregroundColor(Theme.textColor)
                
                Text(expense.category.rawValue.capitalized)
                    .font(.caption)
                    .foregroundColor(Theme.textColor.opacity(0.6))
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(expense.amount, format: .currency(code: "USD"))
                    .font(.headline)
                    .foregroundColor(Theme.textColor)
                
                Text(expense.frequency.rawValue)
                    .font(.caption)
                    .foregroundColor(Theme.textColor.opacity(0.6))
            }
        }
        .padding()
        .background(Theme.cardBackground.opacity(0.5))
        .cornerRadius(10)
    }
}

struct ScholarshipRow: View {
    let scholarship: FinancialPlan.ScholarshipAmount
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Scholarship")
                    .font(.headline)
                    .foregroundColor(Theme.textColor)
                
                Text(scholarship.isConfirmed ? "Confirmed" : "Pending")
                    .font(.caption)
                    .foregroundColor(scholarship.isConfirmed ? Theme.successColor : .orange)
            }
            
            Spacer()
            
            Text(scholarship.amount, format: .currency(code: "USD"))
                .font(.headline)
                .foregroundColor(Theme.textColor)
        }
        .padding()
        .background(Theme.cardBackground.opacity(0.5))
        .cornerRadius(10)
    }
}

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    @State private var name = ""
    @State private var amount = 0.0
    @State private var category = FinancialPlan.Expense.ExpenseCategory.tuition
    @State private var frequency = FinancialPlan.Expense.ExpenseFrequency.monthly
    @State private var isRecurring = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details")) {
                    TextField("Name", text: $name)
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("Category", selection: $category) {
                        ForEach(FinancialPlan.Expense.ExpenseCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized)
                                .tag(category)
                        }
                    }
                    
                    Picker("Frequency", selection: $frequency) {
                        ForEach(FinancialPlan.Expense.ExpenseFrequency.allCases, id: \.self) { frequency in
                            Text(frequency.rawValue)
                                .tag(frequency)
                        }
                    }
                    
                    Toggle("Recurring", isOn: $isRecurring)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let expense = FinancialPlan.Expense(
                            name: name,
                            amount: amount,
                            category: category,
                            frequency: frequency,
                            isRecurring: isRecurring
                        )
                        viewModel.addExpense(expense)
                        dismiss()
                    }
                    .disabled(name.isEmpty || amount <= 0)
                }
            }
        }
    }
}

struct AddScholarshipView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    @State private var amount = 0.0
    @State private var isConfirmed = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Scholarship Details")) {
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                    
                    Toggle("Confirmed", isOn: $isConfirmed)
                }
            }
            .navigationTitle("Add Scholarship")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let scholarship = FinancialPlan.ScholarshipAmount(
                            scholarshipId: UUID(),
                            amount: amount,
                            isConfirmed: isConfirmed
                        )
                        viewModel.addScholarship(scholarship)
                        dismiss()
                    }
                    .disabled(amount <= 0)
                }
            }
        }
    }
}

struct EditableFinancialCard: View {
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    var isScholarship: Bool = false
    var onCommit: ((Double) -> Void)? = nil
    var onScholarshipTap: (() -> Void)? = nil
    
    @State private var isEditing = false
    @State private var inputValue: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(Theme.textColor)
            
            if isEditing && !isScholarship {
                TextField("Amount", text: $inputValue, onCommit: {
                    if let value = Double(inputValue) {
                        onCommit?(value)
                    }
                    isEditing = false
                })
                .keyboardType(.decimalPad)
                .font(.headline)
                .foregroundColor(Theme.textColor)
                .multilineTextAlignment(.center)
                .onAppear { inputValue = String(format: "%.2f", amount) }
            } else {
                Text(amount, format: .currency(code: "USD"))
                    .font(.headline)
                    .foregroundColor(Theme.textColor)
                    .onTapGesture {
                        if isScholarship {
                            onScholarshipTap?()
                        } else {
                            isEditing = true
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.cardBackground.opacity(0.5))
        .cornerRadius(15)
    }
}

#Preview {
    FinancialPlanningView()
} 
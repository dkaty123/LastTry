import SwiftUI
import Charts

struct FinancialPlanningView: View {
    @StateObject private var viewModel = FinancialPlanningViewModel()
    @StateObject private var motion = SplashMotionManager()
    @State private var headerOffset: CGFloat = -50
    @State private var headerOpacity: Double = 0
    @State private var contentOffset: CGFloat = 100
    @State private var contentOpacity: Double = 0
    @State private var selectedTab = 0
    
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
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    enhancedHeaderView
                    tabSelectorView
                    
                    TabView(selection: $selectedTab) {
                        overviewTab
                            .tag(0)
                        expensesTab
                            .tag(1)
                        scholarshipsTab
                            .tag(2)
                        budgetTab
                            .tag(3)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    headerOffset = 0
                    headerOpacity = 1
                }
                
                withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                    contentOffset = 0
                    contentOpacity = 1
                }
            }
            .sheet(isPresented: $viewModel.showingAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.showingAddScholarship) {
                AddScholarshipView(viewModel: viewModel)
            }
        }
    }
    
    private var enhancedHeaderView: some View {
        VStack(spacing: 16) {
            // Header with title and mascot
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Financial Planning")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Text("Navigate your financial galaxy")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Mascot placeholder
                ZStack {
                    Circle()
                        .fill(Theme.accentColor.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "chart.pie.fill")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Quick stats
            HStack(spacing: 16) {
                QuickStatCard(
                    icon: "dollarsign.circle.fill",
                    title: "Total Cost",
                    value: viewModel.financialPlan.totalCost,
                    color: Theme.errorColor
                )
                
                QuickStatCard(
                    icon: "star.circle.fill",
                    title: "Scholarships",
                    value: viewModel.totalScholarships,
                    color: Theme.successColor
                )
                
                QuickStatCard(
                    icon: "chart.line.uptrend.xyaxis.circle.fill",
                    title: "Remaining",
                    value: viewModel.remainingBalance,
                    color: viewModel.remainingBalance >= 0 ? Theme.successColor : Theme.errorColor
                )
            }
            .padding(.horizontal, 20)
        }
        .background(Theme.backgroundColor.opacity(0.3))
        .offset(y: headerOffset)
        .opacity(headerOpacity)
    }
    
    private var tabSelectorView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(["Overview", "Expenses", "Scholarships", "Budget"], id: \.self) { tab in
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = ["Overview", "Expenses", "Scholarships", "Budget"].firstIndex(of: tab) ?? 0
                        }
                    }) {
                        Text(tab)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(selectedTab == ["Overview", "Expenses", "Scholarships", "Budget"].firstIndex(of: tab) ? .white : .white.opacity(0.7))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedTab == ["Overview", "Expenses", "Scholarships", "Budget"].firstIndex(of: tab) ? Theme.accentColor : Theme.cardBackground.opacity(0.6))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedTab == ["Overview", "Expenses", "Scholarships", "Budget"].firstIndex(of: tab) ? Theme.accentColor : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    .scaleEffect(selectedTab == ["Overview", "Expenses", "Scholarships", "Budget"].firstIndex(of: tab) ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    private var overviewTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Financial summary chart
                EnhancedFinancialSummaryCard(viewModel: viewModel)
                
                // Savings and budget
                EnhancedSavingsCard(viewModel: viewModel)
                
                // Quick actions
                QuickActionsCard(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
    
    private var expensesTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Add expense button
                Button(action: {
                    viewModel.showingAddExpense = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 20, weight: .medium))
                        Text("Add New Expense")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Theme.accentColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                
                // Expenses list
                VStack(spacing: 12) {
                    ForEach(viewModel.financialPlan.expenses) { expense in
                        EnhancedExpenseRow(viewModel: viewModel, expense: expense)
            }
            
            if viewModel.financialPlan.expenses.isEmpty {
                        EmptyStateView(
                            icon: "creditcard",
                            title: "No Expenses Yet",
                            subtitle: "Add your first expense to start tracking your spending"
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
    
    private var scholarshipsTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Add scholarship button
                Button(action: {
                    viewModel.showingAddScholarship = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 20, weight: .medium))
                        Text("Add New Scholarship")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Theme.successColor)
        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Theme.successColor.opacity(0.5), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                
                // Scholarships list
                VStack(spacing: 12) {
                    ForEach(viewModel.financialPlan.scholarships) { scholarship in
                        EnhancedScholarshipRow(viewModel: viewModel, scholarship: scholarship)
                    }
                    
                    if viewModel.financialPlan.scholarships.isEmpty {
                        EmptyStateView(
                            icon: "star",
                            title: "No Scholarships Yet",
                            subtitle: "Add your scholarships to reduce your total cost"
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
    
    private var budgetTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Budget analysis
                EnhancedBudgetAnalysisCard(viewModel: viewModel)
                
                // Monthly breakdown
                EnhancedMonthlyBreakdownCard(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
}

struct QuickStatCard: View {
    let icon: String
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(color)
            }
            
            VStack(spacing: 2) {
                Text(value, format: .currency(code: "USD"))
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
        .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: color.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct EnhancedFinancialSummaryCard: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "chart.pie.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Financial Summary")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            // Summary grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                SummaryItem(
                    title: "Total Cost",
                    value: viewModel.financialPlan.totalCost,
                    color: Theme.errorColor,
                    icon: "dollarsign.circle.fill"
                )
                
                SummaryItem(
                    title: "Scholarships",
                    value: viewModel.totalScholarships,
                    color: Theme.successColor,
                    icon: "star.circle.fill"
                )
                
                SummaryItem(
                    title: "Savings",
                    value: viewModel.financialPlan.savings,
                    color: Theme.accentColor,
                    icon: "banknote.fill"
                )
                
                SummaryItem(
                    title: "Remaining",
                    value: viewModel.remainingBalance,
                    color: viewModel.remainingBalance >= 0 ? Theme.successColor : Theme.errorColor,
                    icon: "chart.line.uptrend.xyaxis.circle.fill"
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct SummaryItem: View {
    let title: String
    let value: Double
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(color)
            
            Text(value, format: .currency(code: "USD"))
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct EnhancedSavingsCard: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    var body: some View {
        VStack(spacing: 16) {
                HStack {
                Image(systemName: "banknote.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Savings & Budget")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                    Spacer()
            }
            
            VStack(spacing: 12) {
                EditableField(
                    title: "Monthly Budget",
                    value: $viewModel.financialPlan.monthlyBudget,
                    icon: "calendar",
                    color: Theme.accentColor
                )
                
                Divider()
                    .background(Theme.cardBorder.opacity(0.3))
                
                EditableField(
                    title: "Current Savings",
                    value: $viewModel.financialPlan.savings,
                    icon: "banknote",
                    color: Theme.successColor
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct EditableField: View {
    let title: String
    @Binding var value: Double
    let icon: String
    let color: Color
    
    @State private var isEditing = false
    @State private var inputValue: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            if isEditing {
                TextField("Amount", text: $inputValue, onCommit: {
                    if let newValue = Double(inputValue) {
                        value = newValue
                    }
                    isEditing = false
                })
                .keyboardType(.decimalPad)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .onAppear { inputValue = String(format: "%.2f", value) }
            } else {
                Text(value, format: .currency(code: "USD"))
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .onTapGesture {
                        isEditing = true
                    }
            }
        }
        .padding(.vertical, 8)
    }
}

struct QuickActionsCard: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Quick Actions")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack(spacing: 12) {
                Button(action: {
                    viewModel.showingAddExpense = true
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Theme.errorColor)
                        
                        Text("Add Expense")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Theme.errorColor.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.errorColor.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
                
                Button(action: {
                    viewModel.showingAddScholarship = true
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Theme.successColor)
                        
                        Text("Add Scholarship")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Theme.successColor.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.successColor.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct EnhancedExpenseRow: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    let expense: FinancialPlan.Expense
    @State private var isEditing = false
    @State private var inputValue: String = ""
    
    var body: some View {
        HStack(spacing: 12) {
            // Category icon
            ZStack {
                Circle()
                    .fill(categoryColor(for: expense.category).opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: categoryIcon(for: expense.category))
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(categoryColor(for: expense.category))
            }
            
            // Expense details
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.name)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                Text(expense.category.rawValue.capitalized)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text("•")
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text(expense.frequency.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            Spacer()
            
            // Amount
            VStack(alignment: .trailing, spacing: 4) {
                if isEditing {
                    TextField("Amount", text: $inputValue, onCommit: {
                        if let value = Double(inputValue) {
                            viewModel.updateExpenseAmount(expenseId: expense.id, newAmount: value)
                        }
                        isEditing = false
                    })
                    .keyboardType(.decimalPad)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .onAppear { inputValue = String(format: "%.2f", expense.amount) }
                } else {
                    Text(expense.amount, format: .currency(code: "USD"))
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .onTapGesture {
                            isEditing = true
                        }
                }
                
                if expense.isRecurring {
                    Text("Recurring")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundColor(Theme.accentColor)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: categoryColor(for: expense.category).opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private func categoryColor(for category: FinancialPlan.Expense.ExpenseCategory) -> Color {
        switch category {
        case .tuition: return .blue
        case .housing: return .green
        case .food: return .orange
        case .transportation: return .purple
        case .books: return .pink
        case .entertainment: return .red
        case .other: return .gray
        }
    }
    
    private func categoryIcon(for category: FinancialPlan.Expense.ExpenseCategory) -> String {
        switch category {
        case .tuition: return "graduationcap.fill"
        case .housing: return "house.fill"
        case .food: return "fork.knife"
        case .transportation: return "car.fill"
        case .books: return "book.fill"
        case .entertainment: return "gamecontroller.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }
}

struct EnhancedScholarshipRow: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    let scholarship: FinancialPlan.ScholarshipAmount
    @State private var isEditing = false
    @State private var inputValue: String = ""
    
    var body: some View {
        HStack(spacing: 12) {
            // Status icon
            ZStack {
                Circle()
                    .fill(scholarship.isConfirmed ? Theme.successColor.opacity(0.2) : Theme.amberColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: scholarship.isConfirmed ? "checkmark.circle.fill" : "clock.circle.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(scholarship.isConfirmed ? Theme.successColor : Theme.amberColor)
            }
            
            // Scholarship details
            VStack(alignment: .leading, spacing: 4) {
                Text("Scholarship")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(scholarship.isConfirmed ? "Confirmed" : "Pending")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(scholarship.isConfirmed ? Theme.successColor : Theme.amberColor)
            }
            
            Spacer()
            
            // Amount
            VStack(alignment: .trailing, spacing: 4) {
            if isEditing {
                TextField("Amount", text: $inputValue, onCommit: {
                    if let value = Double(inputValue) {
                        viewModel.updateScholarshipAmount(scholarshipId: scholarship.id, newAmount: value)
                    }
                    isEditing = false
                })
                .keyboardType(.decimalPad)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .onAppear { inputValue = String(format: "%.2f", scholarship.amount) }
            } else {
                Text(scholarship.amount, format: .currency(code: "USD"))
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    .onTapGesture {
                        isEditing = true
                    }
                }
                
                Text("Scholarship")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(Theme.successColor)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.successColor.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct EnhancedBudgetAnalysisCard: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Monthly Budget Analysis")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            VStack(spacing: 12) {
                BudgetRow(
                    title: "Monthly Expenses",
                    value: viewModel.monthlyExpenses,
                    color: Theme.errorColor
                )
                
                Divider()
                    .background(Theme.cardBorder.opacity(0.3))
                
                BudgetRow(
                    title: "Monthly Budget",
                    value: viewModel.financialPlan.monthlyBudget,
                    color: Theme.accentColor
                )
                
                Divider()
                    .background(Theme.cardBorder.opacity(0.3))
                
                BudgetRow(
                    title: "Remaining",
                    value: viewModel.financialPlan.monthlyBudget - viewModel.monthlyExpenses,
                    color: viewModel.financialPlan.monthlyBudget - viewModel.monthlyExpenses >= 0 ? Theme.successColor : Theme.errorColor
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct BudgetRow: View {
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Text(value, format: .currency(code: "USD"))
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(color)
        }
        .padding(.vertical, 4)
    }
}

struct EnhancedMonthlyBreakdownCard: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Monthly Breakdown")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            // Simple chart representation
            VStack(spacing: 8) {
                ForEach(Array(viewModel.financialPlan.expenses.enumerated()), id: \.offset) { index, expense in
                    HStack {
                        Text(expense.name)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                            .frame(width: 80, alignment: .leading)
                        
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(categoryColor(for: expense.category))
                                .frame(width: geometry.size.width * CGFloat(expense.amount / max(viewModel.monthlyExpenses, 1)))
                        }
                        .frame(height: 8)
                        
                        Text(expense.amount, format: .currency(code: "USD"))
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 60, alignment: .trailing)
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    private func categoryColor(for category: FinancialPlan.Expense.ExpenseCategory) -> Color {
        switch category {
        case .tuition: return .blue
        case .housing: return .green
        case .food: return .orange
        case .transportation: return .purple
        case .books: return .pink
        case .entertainment: return .red
        case .other: return .gray
        }
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Theme.accentColor.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: icon)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(Theme.accentColor)
            }
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
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

#Preview {
    FinancialPlanningView()
} 
import SwiftUI

struct SmartFiltersView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var searchText = ""
    @State private var selectedCategories: Set<Scholarship.ScholarshipCategory> = []
    @State private var minAmount: Double = 0
    @State private var maxAmount: Double = 50000
    @State private var selectedSortOption: SortOption = .deadline
    @State private var showDeadlineThisMonth = false
    @State private var showNoEssayRequired = false
    @State private var showHighAmount = false
    @State private var selectedGPA: GPARange = .any
    @State private var selectedCountry: String = "Any"
    @State private var selectedLevel: EducationLevel = .any
    @State private var showFilters = false
    @State private var filteredScholarships: [Scholarship] = []
    
    private let countries = ["Any", "Canada", "United States", "International"]
    private let gpaRanges: [GPARange] = [.any, .low, .medium, .high]
    private let educationLevels: [EducationLevel] = [.any, .undergraduate, .graduate, .highSchool]
    
    enum SortOption: String, CaseIterable {
        case deadline = "Deadline"
        case amount = "Amount (High to Low)"
        case amountLow = "Amount (Low to High)"
        case effort = "Effort (Easy First)"
        case name = "Name"
    }
    
    enum GPARange: String, CaseIterable {
        case any = "Any GPA"
        case low = "2.0-2.9"
        case medium = "3.0-3.5"
        case high = "3.6+"
    }
    
    enum EducationLevel: String, CaseIterable {
        case any = "Any Level"
        case highSchool = "High School"
        case undergraduate = "Undergraduate"
        case graduate = "Graduate"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    quickFiltersView
                    searchAndFiltersView
                    resultsView
                }
            }
            .onAppear {
                applyFilters()
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            Text("Smart Filters")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .shadow(color: Theme.accentColor.opacity(0.5), radius: 8, x: 0, y: 2)
            
            Text("Find your perfect scholarship match")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.top, 32)
        .padding(.bottom, 20)
    }
    
    private var quickFiltersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                QuickFilterButton(
                    title: "Due This Month",
                    icon: "calendar",
                    isActive: showDeadlineThisMonth,
                    action: {
                        showDeadlineThisMonth.toggle()
                        applyFilters()
                    }
                )
                
                QuickFilterButton(
                    title: "No Essay",
                    icon: "doc.text",
                    isActive: showNoEssayRequired,
                    action: {
                        showNoEssayRequired.toggle()
                        applyFilters()
                    }
                )
                
                QuickFilterButton(
                    title: "$5K+",
                    icon: "dollarsign.circle",
                    isActive: showHighAmount,
                    action: {
                        showHighAmount.toggle()
                        applyFilters()
                    }
                )
                
                QuickFilterButton(
                    title: "Easy Apply",
                    icon: "checkmark.circle",
                    isActive: false,
                    action: {
                        // Filter for scholarships with minimal requirements
                        applyFilters()
                    }
                )
                
                QuickFilterButton(
                    title: "Easiest This Month",
                    icon: "star.circle",
                    isActive: false,
                    action: {
                        // Special filter: easiest scholarships due this month
                        showDeadlineThisMonth = true
                        selectedSortOption = .effort
                        applyFilters()
                    }
                )
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
    }
    
    private var searchAndFiltersView: some View {
        VStack(spacing: 16) {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white.opacity(0.7))
                
                TextField("Search scholarships...", text: $searchText)
                    .foregroundColor(.white)
                    .onChange(of: searchText) { _ in
                        applyFilters()
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        applyFilters()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Search suggestions
            if searchText.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(["STEM", "No Essay", "High Amount", "Canada", "Engineering", "Arts"], id: \.self) { suggestion in
                            Button(action: {
                                searchText = suggestion
                                applyFilters()
                            }) {
                                Text(suggestion)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Advanced filters toggle
            Button(action: {
                withAnimation(.spring()) {
                    showFilters.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                    Text("Advanced Filters")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: showFilters ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            
            // Advanced filters
            if showFilters {
                advancedFiltersView
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
    
    private var advancedFiltersView: some View {
        VStack(spacing: 16) {
            // Categories
            VStack(alignment: .leading, spacing: 8) {
                Text("Categories")
                    .font(.headline)
                    .foregroundColor(.white)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                    ForEach(Scholarship.ScholarshipCategory.allCases, id: \.self) { category in
                        FilterChip(
                            title: category.rawValue.capitalized,
                            isSelected: selectedCategories.contains(category),
                            action: {
                                if selectedCategories.contains(category) {
                                    selectedCategories.remove(category)
                                } else {
                                    selectedCategories.insert(category)
                                }
                                applyFilters()
                            }
                        )
                    }
                }
            }
            
            // Amount range
            VStack(alignment: .leading, spacing: 8) {
                Text("Amount Range")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    Text("$\(Int(minAmount))")
                        .foregroundColor(.white.opacity(0.8))
                    
                    Slider(value: $minAmount, in: 0...50000, step: 1000)
                        .accentColor(Theme.accentColor)
                        .onChange(of: minAmount) { _ in
                            if minAmount > maxAmount {
                                maxAmount = minAmount
                            }
                            applyFilters()
                        }
                    
                    Text("$\(Int(maxAmount))")
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            // GPA Range
            VStack(alignment: .leading, spacing: 8) {
                Text("GPA Range")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Picker("GPA Range", selection: $selectedGPA) {
                    ForEach(gpaRanges, id: \.self) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedGPA) { _ in
                    applyFilters()
                }
            }
            
            // Education Level
            VStack(alignment: .leading, spacing: 8) {
                Text("Education Level")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Picker("Education Level", selection: $selectedLevel) {
                    ForEach(educationLevels, id: \.self) { level in
                        Text(level.rawValue).tag(level)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedLevel) { _ in
                    applyFilters()
                }
            }
            
            // Country
            VStack(alignment: .leading, spacing: 8) {
                Text("Country")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Picker("Country", selection: $selectedCountry) {
                    ForEach(countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedCountry) { _ in
                    applyFilters()
                }
            }
            
            // Sort options
            VStack(alignment: .leading, spacing: 8) {
                Text("Sort By")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Picker("Sort By", selection: $selectedSortOption) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedSortOption) { _ in
                    applyFilters()
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    private var resultsView: some View {
        VStack {
            HStack {
                Text("\(filteredScholarships.count) scholarships found")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                if !filteredScholarships.isEmpty {
                    Button("Clear All") {
                        clearAllFilters()
                    }
                    .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal)
            
            if filteredScholarships.isEmpty {
                emptyStateView
            } else {
                scholarshipListView
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(Theme.accentColor.opacity(0.7))
            
            Text("No scholarships match your criteria")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Text("Try adjusting your filters or search terms")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
            
            Button("Clear Filters") {
                clearAllFilters()
            }
            .foregroundColor(.white)
            .padding()
            .background(Theme.accentColor.opacity(0.3))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
    
    private var scholarshipListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredScholarships) { scholarship in
                    SmartFilterScholarshipCard(scholarship: scholarship)
                }
            }
            .padding()
        }
    }
    
    private func applyFilters() {
        var filtered = viewModel.scholarships
        
        // Text search
        if !searchText.isEmpty {
            filtered = filtered.filter { scholarship in
                scholarship.name.localizedCaseInsensitiveContains(searchText) ||
                scholarship.description.localizedCaseInsensitiveContains(searchText) ||
                scholarship.requirements.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        // Categories
        if !selectedCategories.isEmpty {
            filtered = filtered.filter { selectedCategories.contains($0.category) }
        }
        
        // Amount range
        filtered = filtered.filter { scholarship in
            scholarship.amount >= minAmount && scholarship.amount <= maxAmount
        }
        
        // Quick filters
        if showDeadlineThisMonth {
            let calendar = Calendar.current
            let now = Date()
            let endOfMonth = calendar.dateInterval(of: .month, for: now)?.end ?? now
            filtered = filtered.filter { scholarship in
                scholarship.deadline <= endOfMonth && scholarship.deadline > now
            }
        }
        
        if showNoEssayRequired {
            filtered = filtered.filter { scholarship in
                !scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("essay") ||
                    requirement.localizedCaseInsensitiveContains("writing")
                }
            }
        }
        
        if showHighAmount {
            filtered = filtered.filter { $0.amount >= 5000 }
        }
        
        // GPA filter
        switch selectedGPA {
        case .low:
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("2.0") ||
                    requirement.localizedCaseInsensitiveContains("2.5") ||
                    requirement.localizedCaseInsensitiveContains("2.9")
                }
            }
        case .medium:
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("3.0") ||
                    requirement.localizedCaseInsensitiveContains("3.5")
                }
            }
        case .high:
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("3.6") ||
                    requirement.localizedCaseInsensitiveContains("3.8") ||
                    requirement.localizedCaseInsensitiveContains("4.0")
                }
            }
        case .any:
            break
        }
        
        // Country filter
        if selectedCountry != "Any" {
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains(selectedCountry.lowercased())
                }
            }
        }
        
        // Education level filter
        switch selectedLevel {
        case .highSchool:
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("high school") ||
                    requirement.localizedCaseInsensitiveContains("senior")
                }
            }
        case .undergraduate:
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("undergraduate") ||
                    requirement.localizedCaseInsensitiveContains("bachelor")
                }
            }
        case .graduate:
            filtered = filtered.filter { scholarship in
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains("graduate") ||
                    requirement.localizedCaseInsensitiveContains("master") ||
                    requirement.localizedCaseInsensitiveContains("phd")
                }
            }
        case .any:
            break
        }
        
        // Sort
        switch selectedSortOption {
        case .deadline:
            filtered.sort { $0.deadline < $1.deadline }
        case .amount:
            filtered.sort { $0.amount > $1.amount }
        case .amountLow:
            filtered.sort { $0.amount < $1.amount }
        case .effort:
            filtered.sort { scholarship1, scholarship2 in
                let effort1 = calculateEffortScore(scholarship1)
                let effort2 = calculateEffortScore(scholarship2)
                return effort1 < effort2
            }
        case .name:
            filtered.sort { $0.name < $1.name }
        }
        
        filteredScholarships = filtered
    }
    
    private func calculateEffortScore(_ scholarship: Scholarship) -> Int {
        var score = 0
        
        // Higher score = more effort required
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("essay") }) {
            score += 3
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("portfolio") }) {
            score += 4
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("interview") }) {
            score += 5
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("recommendation") }) {
            score += 2
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("video") }) {
            score += 4
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("transcript") }) {
            score += 1
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("resume") }) {
            score += 1
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("letter") }) {
            score += 2
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("project") }) {
            score += 3
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("presentation") }) {
            score += 4
        }
        
        return score
    }
    
    private func clearAllFilters() {
        searchText = ""
        selectedCategories.removeAll()
        minAmount = 0
        maxAmount = 50000
        selectedSortOption = .deadline
        showDeadlineThisMonth = false
        showNoEssayRequired = false
        showHighAmount = false
        selectedGPA = .any
        selectedCountry = "Any"
        selectedLevel = .any
        applyFilters()
    }
}

struct QuickFilterButton: View {
    let title: String
    let icon: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.caption.bold())
            }
            .foregroundColor(isActive ? .white : .white.opacity(0.8))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                isActive ? Theme.accentColor : Color.white.opacity(0.2)
            )
            .cornerRadius(20)
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.bold())
                .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    isSelected ? Theme.accentColor : Color.white.opacity(0.2)
                )
                .cornerRadius(12)
        }
    }
}

struct SmartFilterScholarshipCard: View {
    let scholarship: Scholarship
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var isExpanded = false
    @State private var isSaved = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(scholarship.name)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    Text(scholarship.category.rawValue.capitalized)
                        .font(.caption)
                        .foregroundColor(Theme.accentColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Theme.accentColor.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        isSaved.toggle()
                        if isSaved {
                            viewModel.saveScholarship(scholarship)
                        } else {
                            viewModel.removeSavedScholarship(scholarship)
                        }
                    }
                }) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isSaved ? Theme.accentColor : .white.opacity(0.7))
                        .font(.title3)
                }
            }
            
            // Amount and deadline
            HStack {
                Text("$\(Int(scholarship.amount))")
                    .font(.title2.bold())
                    .foregroundColor(Theme.accentColor)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Deadline")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(scholarship.deadline, style: .date)
                        .font(.caption.bold())
                        .foregroundColor(deadlineColor)
                    
                    Text(deadlineStatus)
                        .font(.caption2)
                        .foregroundColor(deadlineColor)
                }
            }
            
            // Description
            Text(scholarship.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(isExpanded ? nil : 2)
            
            // Requirements preview
            if !scholarship.requirements.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Requirements:")
                        .font(.caption.bold())
                        .foregroundColor(.white.opacity(0.7))
                    
                    ForEach(Array(scholarship.requirements.prefix(isExpanded ? scholarship.requirements.count : 2)), id: \.self) { requirement in
                        HStack(alignment: .top, spacing: 6) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.caption)
                                .foregroundColor(Theme.accentColor)
                            
                            Text(requirement)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                                .lineLimit(2)
                        }
                    }
                    
                    if scholarship.requirements.count > 2 && !isExpanded {
                        Button("Show \(scholarship.requirements.count - 2) more") {
                            withAnimation(.spring()) {
                                isExpanded = true
                            }
                        }
                        .font(.caption)
                        .foregroundColor(Theme.accentColor)
                    }
                }
            }
            
            // Effort indicator
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Effort Level:")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < calculateEffortLevel() ? "star.fill" : "star")
                                .font(.caption2)
                                .foregroundColor(index < calculateEffortLevel() ? Theme.accentColor : .white.opacity(0.3))
                        }
                    }
                    
                    Text(effortDescription)
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                Button("Expand") {
                    withAnimation(.spring()) {
                        isExpanded.toggle()
                    }
                }
                .font(.caption)
                .foregroundColor(Theme.accentColor)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
        .onAppear {
            isSaved = viewModel.savedScholarships.contains { $0.id == scholarship.id }
        }
    }
    
    private func calculateEffortLevel() -> Int {
        var score = 1 // Base level
        
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("essay") }) {
            score += 1
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("portfolio") }) {
            score += 1
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("interview") }) {
            score += 1
        }
        if scholarship.requirements.contains(where: { $0.localizedCaseInsensitiveContains("video") }) {
            score += 1
        }
        
        return min(score, 5)
    }
    
    private var effortDescription: String {
        let level = calculateEffortLevel()
        switch level {
        case 1:
            return "Very Easy - Basic requirements"
        case 2:
            return "Easy - Simple application"
        case 3:
            return "Moderate - Some effort needed"
        case 4:
            return "Hard - Complex requirements"
        case 5:
            return "Very Hard - Extensive work"
        default:
            return "Standard application"
        }
    }
    
    private var deadlineColor: Color {
        let calendar = Calendar.current
        let now = Date()
        let endOfMonth = calendar.dateInterval(of: .month, for: now)?.end ?? now
        let deadline = scholarship.deadline
        
        if deadline <= endOfMonth && deadline > now {
            return Theme.accentColor
        } else if deadline <= now {
            return .red
        } else {
            return .green
        }
    }
    
    private var deadlineStatus: String {
        let calendar = Calendar.current
        let now = Date()
        let endOfMonth = calendar.dateInterval(of: .month, for: now)?.end ?? now
        let deadline = scholarship.deadline
        
        if deadline <= endOfMonth && deadline > now {
            return "Due Soon"
        } else if deadline <= now {
            return "Past Due"
        } else {
            return "Upcoming"
        }
    }
}

#Preview {
    SmartFiltersView()
        .environmentObject(AppViewModel())
} 
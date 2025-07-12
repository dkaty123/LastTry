import SwiftUI

// MARK: - Background Components

struct StarryBackgroundView: View {
    let animateStars: Bool
    @State private var stars: [(id: Int, x: CGFloat, y: CGFloat, size: CGFloat, opacity: Double)] = []
    
    var body: some View {
        ZStack {
            // Gradient background
            Theme.primaryGradient
                .ignoresSafeArea()
            
            // Animated stars
            ForEach(stars, id: \.id) { star in
                Circle()
                    .fill(Color.white)
                    .frame(width: star.size, height: star.size)
                    .position(x: star.x, y: star.y)
                    .opacity(star.opacity)
                    .scaleEffect(animateStars ? 1.2 : 0.8)
                    .animation(
                        .easeInOut(duration: Double.random(in: 2...4))
                        .repeatForever(autoreverses: true)
                        .delay(Double.random(in: 0...2)),
                        value: animateStars
                    )
            }
        }
        .onAppear {
            generateStars()
        }
    }
    
    private func generateStars() {
        stars = (0..<50).map { id in
            (
                id: id,
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                size: CGFloat.random(in: 1...3),
                opacity: Double.random(in: 0.3...0.8)
            )
        }
    }
}

struct FloatingParticlesView: View {
    @State private var particles: [(id: Int, x: CGFloat, y: CGFloat, size: CGFloat, speed: Double)] = []
    @State private var animateParticles = false
    
    var body: some View {
        ZStack {
            ForEach(particles, id: \.id) { particle in
                Circle()
                    .fill(Theme.accentColor.opacity(0.3))
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x, y: particle.y)
                    .blur(radius: 1)
                    .scaleEffect(animateParticles ? 1.5 : 0.5)
                    .opacity(animateParticles ? 0.8 : 0.2)
                    .animation(
                        .easeInOut(duration: particle.speed)
                        .repeatForever(autoreverses: true)
                        .delay(Double.random(in: 0...particle.speed)),
                        value: animateParticles
                    )
            }
        }
        .onAppear {
            generateParticles()
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateParticles = true
            }
        }
    }
    
    private func generateParticles() {
        particles = (0..<20).map { id in
            (
                id: id,
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                size: CGFloat.random(in: 2...6),
                speed: Double.random(in: 2...5)
            )
        }
    }
}

struct SpaceStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    @State private var animateCard = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption.bold())
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Text(value)
                .font(.title2.bold())
                .foregroundColor(.white)
                .scaleEffect(animateCard ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: animateCard)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3).delay(0.2)) {
                animateCard = true
            }
        }
    }
}

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
    @State private var animateStars = false
    @State private var showMascot = false
    
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
                // Animated starry background
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                // Animated stars overlay
                starsOverlay
                
                VStack(spacing: 0) {
                    headerView
                    quickFiltersView
                    searchAndFiltersView
                    resultsView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 8) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(Theme.accentColor)
                        
                        Text("Filters")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        clearAllFilters()
                    }) {
                        Text("Clear All")
                            .font(.subheadline.bold())
                            .foregroundColor(Theme.accentColor)
                    }
                }
            }
            .toolbarBackground(Theme.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    animateStars = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring()) {
                        showMascot = true
                    }
                }
                
                applyFilters()
            }
        }
    }
    
    private var starsOverlay: some View {
        ZStack {
            ForEach(0..<30, id: \.self) { index in
                Circle()
                    .fill(Color.white)
                    .frame(width: CGFloat.random(in: 1...3))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .opacity(Double.random(in: 0.3...0.8))
                    .scaleEffect(animateStars ? 1.2 : 0.8)
                    .animation(
                        .easeInOut(duration: Double.random(in: 2...4))
                        .repeatForever(autoreverses: true)
                        .delay(Double.random(in: 0...2)),
                        value: animateStars
                    )
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            // Subtitle and mascot
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Find your perfect scholarship match")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(color: Theme.accentColor.opacity(0.3), radius: 4, x: 0, y: 2)
                }
                
                Spacer()
                
                // Animated mascot
                if showMascot {
                    Image(systemName: "telescope.fill")
                        .font(.system(size: 32))
                        .foregroundColor(Theme.accentColor)
                        .shadow(color: Theme.accentColor.opacity(0.5), radius: 8)
                        .scaleEffect(animateStars ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: animateStars)
                }
            }
            
            // Stats cards
            HStack(spacing: 12) {
                SpaceStatCard(
                    title: "Total",
                    value: "\(viewModel.scholarships.count)",
                    icon: "star.fill",
                    color: Theme.accentColor
                )
                
                SpaceStatCard(
                    title: "Found",
                    value: "\(filteredScholarships.count)",
                    icon: "magnifyingglass",
                    color: .green
                )
                
                SpaceStatCard(
                    title: "Saved",
                    value: "\(viewModel.savedScholarships.count)",
                    icon: "bookmark.fill",
                    color: .orange
                )
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 20)
        .padding(.horizontal)
    }
    
    private var quickFiltersView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Quick Filters")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 2, x: 0, y: 1)
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    EnhancedQuickFilterButton(
                        title: "Due This Month",
                        icon: "calendar",
                        isActive: showDeadlineThisMonth,
                        color: .red
                    ) {
                        showDeadlineThisMonth.toggle()
                        applyFilters()
                    }
                    
                    EnhancedQuickFilterButton(
                        title: "No Essay",
                        icon: "doc.text",
                        isActive: showNoEssayRequired,
                        color: .green
                    ) {
                        showNoEssayRequired.toggle()
                        applyFilters()
                    }
                    
                    EnhancedQuickFilterButton(
                        title: "$5K+",
                        icon: "dollarsign.circle",
                        isActive: showHighAmount,
                        color: .yellow
                    ) {
                        showHighAmount.toggle()
                        applyFilters()
                    }
                    
                    EnhancedQuickFilterButton(
                        title: "Easy Apply",
                        icon: "checkmark.circle",
                        isActive: false,
                        color: .blue
                    ) {
                        // Filter for scholarships with minimal requirements
                        applyFilters()
                    }
                    
                    EnhancedQuickFilterButton(
                        title: "Easiest This Month",
                        icon: "star.circle",
                        isActive: false,
                        color: .purple
                    ) {
                        // Special filter: easiest scholarships due this month
                        showDeadlineThisMonth = true
                        selectedSortOption = .effort
                        applyFilters()
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 20)
    }
    
    private var searchAndFiltersView: some View {
        VStack(spacing: 16) {
            // Enhanced search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Theme.accentColor.opacity(0.8))
                    .font(.title3)
                
                TextField("Search scholarships...", text: $searchText)
                    .foregroundColor(.white)
                    .font(.body)
                    .onChange(of: searchText) { _ in
                        applyFilters()
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        applyFilters()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Theme.accentColor.opacity(0.8))
                            .font(.title3)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Theme.cardBackground.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Theme.accentColor.opacity(0.4), lineWidth: 1.5)
                    )
            )
            .shadow(color: Theme.accentColor.opacity(0.2), radius: 8, x: 0, y: 4)
            .padding(.horizontal)
            
            // Enhanced search suggestions
            if searchText.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Popular Searches")
                        .font(.caption.bold())
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(["STEM", "No Essay", "High Amount", "Canada", "Engineering", "Arts", "Women", "Minority"], id: \.self) { suggestion in
                                Button(action: {
                                    searchText = suggestion
                                    applyFilters()
                                }) {
                                    Text(suggestion)
                                        .font(.caption.bold())
                                        .foregroundColor(.white.opacity(0.9))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(Color.white.opacity(0.2))
                                                .overlay(
                                                    Capsule()
                                                        .stroke(Theme.accentColor.opacity(0.3), lineWidth: 1)
                                                )
                                        )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            // Enhanced advanced filters toggle
            Button(action: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    showFilters.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Theme.accentColor)
                        .font(.title3)
                    Text("Advanced Filters")
                        .foregroundColor(.white)
                        .font(.body.bold())
                    Spacer()
                    Image(systemName: showFilters ? "chevron.up" : "chevron.down")
                        .foregroundColor(Theme.accentColor)
                        .font(.title3)
                        .rotationEffect(.degrees(showFilters ? 180 : 0))
                        .animation(.spring(), value: showFilters)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Theme.cardBackground.opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Theme.accentColor.opacity(0.4), lineWidth: 1.5)
                        )
                )
                .shadow(color: Theme.accentColor.opacity(0.2), radius: 8, x: 0, y: 4)
                .padding(.horizontal)
            }
            
            // Enhanced advanced filters
            if showFilters {
                enhancedAdvancedFiltersView
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .top)),
                        removal: .opacity.combined(with: .move(edge: .top))
                    ))
            }
        }
    }
    
    private var enhancedAdvancedFiltersView: some View {
        VStack(spacing: 20) {
            // Categories
            EnhancedFilterSection(
                title: "Categories",
                icon: "tag.fill"
            ) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                    ForEach(Scholarship.ScholarshipCategory.allCases, id: \.self) { category in
                        EnhancedFilterChip(
                            title: category.rawValue.capitalized,
                            isSelected: selectedCategories.contains(category),
                            color: Theme.accentColor
                        ) {
                            if selectedCategories.contains(category) {
                                selectedCategories.remove(category)
                            } else {
                                selectedCategories.insert(category)
                            }
                            applyFilters()
                        }
                    }
                }
            }
            
            // Amount range
            EnhancedFilterSection(
                title: "Amount Range",
                icon: "dollarsign.circle.fill"
            ) {
                VStack(spacing: 12) {
                    HStack {
                        Text("$\(Int(minAmount))")
                            .font(.caption.bold())
                            .foregroundColor(.white.opacity(0.8))
                        
                        Spacer()
                        
                        Text("$\(Int(maxAmount))")
                            .font(.caption.bold())
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    RangeSlider(minValue: $minAmount, maxValue: $maxAmount, bounds: 0...50000)
                        .onChange(of: minAmount) { _ in
                            if minAmount > maxAmount {
                                maxAmount = minAmount
                            }
                            applyFilters()
                        }
                        .onChange(of: maxAmount) { _ in
                            applyFilters()
                        }
                }
            }
            
            // GPA Range
            EnhancedFilterSection(
                title: "GPA Range",
                icon: "graduationcap.fill"
            ) {
                EnhancedSegmentedPicker(
                    selection: $selectedGPA,
                    options: gpaRanges,
                    color: .green
                ) {
                    applyFilters()
                }
            }
            
            // Education Level
            EnhancedFilterSection(
                title: "Education Level",
                icon: "book.fill"
            ) {
                EnhancedSegmentedPicker(
                    selection: $selectedLevel,
                    options: educationLevels,
                    color: .blue
                ) {
                    applyFilters()
                }
            }
            
            // Country
            EnhancedFilterSection(
                title: "Country",
                icon: "globe"
            ) {
                EnhancedSegmentedPicker(
                    selection: $selectedCountry,
                    options: countries,
                    color: .orange
                ) {
                    applyFilters()
                }
            }
            
            // Sort options
            EnhancedFilterSection(
                title: "Sort By",
                icon: "arrow.up.arrow.down"
            ) {
                EnhancedSegmentedPicker(
                    selection: $selectedSortOption,
                    options: SortOption.allCases,
                    color: .purple
                ) {
                    applyFilters()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.accentColor.opacity(0.2), lineWidth: 1)
                )
        )
        .padding(.horizontal)
    }
    
    private var resultsView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(filteredScholarships.count) scholarships found")
                        .font(.headline.bold())
                        .foregroundColor(.white)
                    
                    Text("Based on your filters")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                if !filteredScholarships.isEmpty {
                    Button("Clear All") {
                        clearAllFilters()
                    }
                    .font(.caption.bold())
                    .foregroundColor(Theme.accentColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Theme.accentColor.opacity(0.2))
                    )
                }
            }
            .padding(.horizontal)
            
            if filteredScholarships.isEmpty {
                enhancedEmptyStateView
            } else {
                enhancedScholarshipListView
            }
        }
    }
    
    private var enhancedEmptyStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Animated empty state
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 60))
                    .foregroundColor(Theme.accentColor.opacity(0.7))
                    .scaleEffect(animateStars ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: animateStars)
                
                VStack(spacing: 8) {
                    Text("No scholarships match your criteria")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    
                    Text("Try adjusting your filters or search terms to find more opportunities")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            }
            
            VStack(spacing: 12) {
                Button("Clear Filters") {
                    clearAllFilters()
                }
                .font(.body.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Theme.accentColor.opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                        )
                )
                
                Button("Browse All") {
                    clearAllFilters()
                }
                .font(.body)
                .foregroundColor(Theme.accentColor)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                )
            }
            
            Spacer()
        }
        .padding()
    }
    
    private var enhancedScholarshipListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredScholarships) { scholarship in
                    EnhancedSmartFilterScholarshipCard(scholarship: scholarship)
                        .transition(.opacity.combined(with: .scale))
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

// MARK: - Enhanced Components

struct EnhancedQuickFilterButton: View {
    let title: String
    let icon: String
    let isActive: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption.bold())
                Text(title)
                    .font(.caption.bold())
            }
            .foregroundColor(isActive ? .white : .white.opacity(0.8))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isActive ? color : Color.white.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isActive ? color.opacity(0.5) : Color.clear, lineWidth: 1)
                    )
            )
            .scaleEffect(isActive ? 1.05 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isActive)
        }
    }
}

struct EnhancedFilterChip: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.bold())
                .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? color : Color.white.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? color.opacity(0.5) : Color.clear, lineWidth: 1)
                        )
                )
                .scaleEffect(isSelected ? 1.05 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
        }
    }
}

struct EnhancedFilterSection<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(Theme.accentColor)
                    .font(.title3)
                
                Text(title)
                    .font(.headline.bold())
                    .foregroundColor(.white)
            }
            
            content
        }
    }
}

struct EnhancedSegmentedPicker<T: Hashable>: View {
    @Binding var selection: T
    let options: [T]
    let color: Color
    let onChange: () -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selection = option
                        onChange()
                    }) {
                        Text(String(describing: option))
                            .font(.caption.bold())
                            .foregroundColor(selection == option ? .white : .white.opacity(0.8))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(selection == option ? color : Color.white.opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selection == option ? color.opacity(0.5) : Color.clear, lineWidth: 1)
                                    )
                            )
                            .scaleEffect(selection == option ? 1.05 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selection)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

struct RangeSlider: View {
    @Binding var minValue: Double
    @Binding var maxValue: Double
    let bounds: ClosedRange<Double>
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 4)
                    .cornerRadius(2)
                
                // Selected range
                Rectangle()
                    .fill(Theme.accentColor)
                    .frame(width: CGFloat((maxValue - minValue) / (bounds.upperBound - bounds.lowerBound)) * geometry.size.width,
                           height: 4)
                    .offset(x: CGFloat((minValue - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)) * geometry.size.width)
                    .cornerRadius(2)
                
                // Min thumb
                Circle()
                    .fill(Theme.accentColor)
                    .frame(width: 20, height: 20)
                    .offset(x: CGFloat((minValue - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)) * geometry.size.width - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = bounds.lowerBound + Double(value.location.x / geometry.size.width) * (bounds.upperBound - bounds.lowerBound)
                                minValue = max(bounds.lowerBound, min(newValue, maxValue))
                            }
                    )
                
                // Max thumb
                Circle()
                    .fill(Theme.accentColor)
                    .frame(width: 20, height: 20)
                    .offset(x: CGFloat((maxValue - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)) * geometry.size.width - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = bounds.lowerBound + Double(value.location.x / geometry.size.width) * (bounds.upperBound - bounds.lowerBound)
                                maxValue = max(minValue, min(newValue, bounds.upperBound))
                            }
                    )
            }
        }
        .frame(height: 20)
    }
}

struct EnhancedSmartFilterScholarshipCard: View {
    let scholarship: Scholarship
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var isExpanded = false
    @State private var isSaved = false
    @State private var animateCard = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(scholarship.name)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    HStack(spacing: 8) {
                        Text(scholarship.category.rawValue.capitalized)
                            .font(.caption.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Theme.accentColor.opacity(0.3))
                                    .overlay(
                                        Capsule()
                                            .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                                    )
                            )
                        
                        // Effort badge
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(Theme.accentColor)
                            Text("\(calculateEffortLevel())/5")
                                .font(.caption2.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.2))
                        )
                    }
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
                        .scaleEffect(isSaved ? 1.2 : 1.0)
                        .animation(.spring(), value: isSaved)
                }
            }
            
            // Amount and deadline
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("$\(Int(scholarship.amount))")
                        .font(.title2.bold())
                        .foregroundColor(Theme.accentColor)
                    
                    Text("Award Amount")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(scholarship.deadline, style: .date)
                        .font(.caption.bold())
                        .foregroundColor(deadlineColor)
                    
                    Text(deadlineStatus)
                        .font(.caption2)
                        .foregroundColor(deadlineColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(deadlineColor.opacity(0.2))
                        )
                }
            }
            
            // Description
            Text(scholarship.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(isExpanded ? nil : 2)
            
            // Requirements preview
            if !scholarship.requirements.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Requirements:")
                            .font(.caption.bold())
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer()
                        
                        Text("\(scholarship.requirements.count) items")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    
                    LazyVStack(alignment: .leading, spacing: 4) {
                        ForEach(Array(scholarship.requirements.prefix(isExpanded ? scholarship.requirements.count : 2)), id: \.self) { requirement in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(Theme.accentColor)
                                
                                Text(requirement)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    if scholarship.requirements.count > 2 {
                        Button(action: {
                            withAnimation(.spring()) {
                                isExpanded.toggle()
                            }
                        }) {
                            HStack(spacing: 4) {
                                Text(isExpanded ? "Show Less" : "Show \(scholarship.requirements.count - 2) More")
                                    .font(.caption.bold())
                                    .foregroundColor(Theme.accentColor)
                                
                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(Theme.accentColor)
                            }
                        }
                    }
                }
            }
            
            // Action buttons
            HStack(spacing: 12) {
                Button(action: {
                    // Apply action
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "paperplane.fill")
                            .font(.caption)
                        Text("Apply Now")
                            .font(.caption.bold())
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Theme.accentColor)
                    )
                }
                
                Button(action: {
                    // Share action
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.caption)
                        Text("Share")
                            .font(.caption.bold())
                    }
                    .foregroundColor(Theme.accentColor)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                    )
                }
                
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.accentColor.opacity(0.2), lineWidth: 1)
                )
        )
        .scaleEffect(animateCard ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: animateCard)
        .onAppear {
            isSaved = viewModel.savedScholarships.contains { $0.id == scholarship.id }
            
            withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                animateCard = true
            }
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

// MARK: - Legacy Components (for backward compatibility)

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

// MARK: - Helper Components

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    @State private var animateCard = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption.bold())
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Text(value)
                .font(.title2.bold())
                .foregroundColor(.white)
                .scaleEffect(animateCard ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: animateCard)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3).delay(0.2)) {
                animateCard = true
            }
        }
    }
} 
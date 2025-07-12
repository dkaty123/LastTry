import SwiftUI

struct OpportunityFilterView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @Binding var isPresented: Bool
    @State private var selectedTypes: Set<OpportunityType> = Set(OpportunityType.allCases)
    @State private var selectedCategories: Set<OpportunityCategory> = Set(OpportunityCategory.allCases)
    @State private var deadlineFilter: DeadlineFilter = .all
    @State private var searchQuery: String = ""
    @State private var showAdvancedFilters = false
    @StateObject private var motion = SplashMotionManager(parallax: .zero)
    
    var body: some View {
        NavigationView {
            ZStack {
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.7))
                        TextField("Search opportunities...", text: $searchQuery)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.white)
                            .onChange(of: searchQuery) { _ in
                                applyFilters()
                            }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 24) {
                            // Opportunity Types
                            FilterSection(title: "Opportunity Types", icon: "star.fill") {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                                    ForEach(OpportunityType.allCases, id: \.self) { type in
                                        OpportunityFilterChip(
                                            title: type.displayName,
                                            icon: type.icon,
                                            isSelected: selectedTypes.contains(type),
                                            color: type.color
                                        ) {
                                            if selectedTypes.contains(type) {
                                                selectedTypes.remove(type)
                                            } else {
                                                selectedTypes.insert(type)
                                            }
                                            applyFilters()
                                        }
                                    }
                                }
                            }
                            
                            // Categories
                            FilterSection(title: "Categories", icon: "tag.fill") {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                                    ForEach(OpportunityCategory.allCases, id: \.self) { category in
                                        OpportunityFilterChip(
                                            title: category.displayName,
                                            icon: category.icon,
                                            isSelected: selectedCategories.contains(category),
                                            color: category.color
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
                            
                            // Deadline Filter
                            FilterSection(title: "Deadline", icon: "clock.fill") {
                                VStack(spacing: 12) {
                                    ForEach(DeadlineFilter.allCases, id: \.self) { filter in
                                        HStack {
                                            Button(action: {
                                                deadlineFilter = filter
                                                applyFilters()
                                            }) {
                                                HStack {
                                                    Image(systemName: deadlineFilter == filter ? "checkmark.circle.fill" : "circle")
                                                        .foregroundColor(deadlineFilter == filter ? .blue : .white.opacity(0.6))
                                                    Text(filter.displayName)
                                                        .foregroundColor(.white)
                                                    Spacer()
                                                }
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                            
                            // Quick Actions
                            VStack(spacing: 16) {
                                Button("Select All") {
                                    selectedTypes = Set(OpportunityType.allCases)
                                    selectedCategories = Set(OpportunityCategory.allCases)
                                    applyFilters()
                                }
                                .buttonStyle(SpaceButtonStyle())
                                
                                Button("Clear All") {
                                    selectedTypes.removeAll()
                                    selectedCategories.removeAll()
                                    applyFilters()
                                }
                                .buttonStyle(SpaceButtonStyle())
                                
                                Button("Reset to Default") {
                                    selectedTypes = Set(OpportunityType.allCases)
                                    selectedCategories = Set(OpportunityCategory.allCases)
                                    deadlineFilter = .all
                                    searchQuery = ""
                                    applyFilters()
                                }
                                .buttonStyle(SpaceButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        applyFilters()
                        isPresented = false
                    }
                    .buttonStyle(SpaceButtonStyle())
                }
            }
        }
        .onAppear {
            // Initialize with current filter state
            selectedTypes = viewModel.selectedOpportunityTypes
            selectedCategories = viewModel.selectedOpportunityCategories
            deadlineFilter = viewModel.deadlineFilter
            searchQuery = viewModel.searchQuery
        }
    }
    
    private func applyFilters() {
        viewModel.applyFilters(
            types: selectedTypes,
            categories: selectedCategories,
            deadline: deadlineFilter,
            searchQuery: searchQuery
        )
    }
}

struct FilterSection<Content: View>: View {
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
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            content
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

struct OpportunityFilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let color: String
    let action: () -> Void
    
    private var swiftUIColor: Color {
        switch color.lowercased() {
        case "blue": return .blue
        case "green": return .green
        case "purple": return .purple
        case "orange": return .orange
        case "yellow": return .yellow
        case "red": return .red
        case "pink": return .pink
        case "mint": return .mint
        case "indigo": return .indigo
        case "teal": return .teal
        case "cyan": return .cyan
        case "gray": return .gray
        default: return .blue
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .white : swiftUIColor)
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? swiftUIColor : Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? swiftUIColor : Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FilterButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(configuration.isPressed ? 0.7 : 1.0))
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    OpportunityFilterView(isPresented: .constant(true))
        .environmentObject(AppViewModel())
} 
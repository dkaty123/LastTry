import SwiftUI

struct SmartSearchView: View {
    @StateObject private var viewModel = SmartSearchViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var isSearchBarFocused = false
    @State private var showMascot = true
    @StateObject private var motion = SplashMotionManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Starry background
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Enhanced Search Header
                    VStack(spacing: 20) {
                        // Navigation and Title
                        HStack {
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(8)
                                    .background(
                                        Circle()
                                            .fill(Theme.cardBackground.opacity(0.6))
                                            .overlay(
                                                Circle()
                                                    .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 4) {
                                Text("Smart Search")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                                
                                Text("AI-Powered Scholarship Discovery")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            // Placeholder for balance
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 40, height: 40)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        // Enhanced Search Bar
                        enhancedSearchBar
                            .padding(.horizontal, 20)
                    }
                    
                    // Content Area
                    if viewModel.searchQuery.isEmpty {
                        enhancedRecentSearches
                    } else {
                        enhancedSearchResults
                    }
                    
                    // Enhanced Mascot
                    if showMascot {
                        enhancedMascotView
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var enhancedSearchBar: some View {
        HStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                TextField("Search scholarships...", text: $viewModel.searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .accentColor(Theme.accentColor)
                    .submitLabel(.search)
                    .onTapGesture {
                        isSearchBarFocused = true
                    }
                    .placeholder(when: viewModel.searchQuery.isEmpty) {
                        Text("Search scholarships...")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                
                if !viewModel.searchQuery.isEmpty {
                    Button(action: { 
                        viewModel.clearSearch()
                        isSearchBarFocused = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.accentColor.opacity(0.7))
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Theme.cardBackground.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                isSearchBarFocused ? Theme.accentColor : Theme.cardBorder.opacity(0.3),
                                lineWidth: isSearchBarFocused ? 2 : 1
                            )
                    )
            )
            .shadow(color: Theme.accentColor.opacity(isSearchBarFocused ? 0.3 : 0.1), radius: isSearchBarFocused ? 15 : 8, x: 0, y: isSearchBarFocused ? 8 : 4)
            .scaleEffect(isSearchBarFocused ? 1.02 : 1.0)
        }
    }
    
    private var enhancedRecentSearches: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Popular Searches Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(Theme.accentColor)
                            .font(.title3)
                        
                        Text("Popular Searches")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.popularSearches, id: \.self) { search in
                                Button(action: {
                                    viewModel.searchQuery = search
                                    viewModel.performSearch(query: search)
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "magnifyingglass")
                                            .font(.system(size: 12, weight: .medium))
                                        Text(search)
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Theme.accentColor.opacity(0.2))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Theme.accentColor.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                                    .foregroundColor(Theme.accentColor)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                // Recent Searches Section
                if !viewModel.recentSearches.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(Theme.accentColor)
                                .font(.title3)
                            
                            Text("Recent Searches")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.recentSearches.prefix(5), id: \.self) { search in
                                Button(action: {
                                    viewModel.searchQuery = search
                                    viewModel.performSearch(query: search)
                                }) {
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundColor(.white.opacity(0.6))
                                            .font(.system(size: 14))
                                        
                                        Text(search)
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "arrow.up.left")
                                            .foregroundColor(.white.opacity(0.4))
                                            .font(.system(size: 12))
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Theme.cardBackground.opacity(0.6))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Theme.cardBorder.opacity(0.2), lineWidth: 1)
                                            )
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                // Search Tips Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(Theme.amberColor)
                            .font(.title3)
                        
                        Text("Search Tips")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 12) {
                        SearchTipRow(icon: "graduationcap.fill", tip: "Try your field of study (e.g., 'Engineering', 'Arts')")
                        SearchTipRow(icon: "location.fill", tip: "Search by location (e.g., 'Ontario', 'Toronto')")
                        SearchTipRow(icon: "dollarsign.circle.fill", tip: "Filter by amount (e.g., 'High value', '5000+')")
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 20)
        }
    }
    
    private var enhancedSearchResults: some View {
        ScrollView {
            if viewModel.isSearching {
                VStack(spacing: 20) {
                    // Loading Animation without rotation
                    ZStack {
                        Circle()
                            .stroke(Theme.accentColor.opacity(0.2), lineWidth: 4)
                            .frame(width: 60, height: 60)
                        
                        Circle()
                            .trim(from: 0, to: 0.7)
                            .stroke(
                                LinearGradient(
                                    colors: [Theme.accentColor, Theme.accentColor.opacity(0.5)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                style: StrokeStyle(lineWidth: 4, lineCap: .round)
                            )
                            .frame(width: 60, height: 60)
                            .rotationEffect(.degrees(-90))
                    }
                    
                    Text("Searching the Scholarship Galaxy...")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Finding perfect matches for you")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 100)
            } else if viewModel.searchResults.isEmpty {
                VStack(spacing: 25) {
                    // Enhanced Empty State
                    ZStack {
                        Circle()
                            .fill(Theme.accentColor.opacity(0.1))
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50, weight: .light))
                            .foregroundColor(Theme.accentColor.opacity(0.7))
                    }
                    
                    VStack(spacing: 12) {
                        Text("No scholarships found")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Try different keywords or browse popular searches")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 100)
            } else {
                VStack(spacing: 16) {
                    // Results Header
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Theme.successColor)
                            .font(.title3)
                        
                        Text("Found \(viewModel.searchResults.count) scholarships")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Results List
                    LazyVStack(spacing: 16) {
                        ForEach(Array(viewModel.searchResults.enumerated()), id: \.element.id) { index, scholarship in
                            ScholarshipCardView(scholarship: scholarship, swipeDirection: nil)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    private var enhancedMascotView: some View {
        VStack(spacing: 16) {
            // Enhanced Mascot with better styling
            CuteMascotView(message: "Ready to explore the scholarship universe? 🚀")
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
    }
}

struct SearchTipRow: View {
    let icon: String
    let tip: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Theme.accentColor)
                .font(.system(size: 16))
                .frame(width: 20)
            
            Text(tip)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Theme.cardBackground.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.cardBorder.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

// Helper view for flowing layout of popular search tags
struct FlowLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, proposal: proposal).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let positions = layout(sizes: sizes, proposal: proposal).positions
        
        for (index, subview) in subviews.enumerated() {
            subview.place(at: positions[index], proposal: .unspecified)
        }
    }
    
    private func layout(sizes: [CGSize], proposal: ProposedViewSize) -> (positions: [CGPoint], size: CGSize) {
        var positions: [CGPoint] = []
        var currentPosition = CGPoint.zero
        var maxHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        
        for size in sizes {
            if currentPosition.x + size.width > maxWidth {
                currentPosition.x = 0
                currentPosition.y += maxHeight + spacing
                maxHeight = 0
            }
            
            positions.append(currentPosition)
            currentPosition.x += size.width + spacing
            maxHeight = max(maxHeight, size.height)
        }
        
        return (positions, CGSize(width: maxWidth, height: currentPosition.y + maxHeight))
    }
}

#Preview {
    SmartSearchView()
}

// Extension to support custom placeholder text
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
} 
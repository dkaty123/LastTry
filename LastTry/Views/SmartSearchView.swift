import SwiftUI

struct SmartSearchView: View {
    @StateObject private var viewModel = SmartSearchViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var isSearchBarFocused = false
    @State private var showMascot = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    searchBar
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .background(Theme.backgroundColor)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                    if viewModel.searchQuery.isEmpty {
                        recentSearches
                            .transition(.opacity)
                    } else {
                        searchResults
                            .transition(.opacity)
                    }
                    
                    if showMascot {
                        CuteMascotView(message: "Let's find your perfect scholarship! 🎓")
                            .padding(.bottom)
                    }
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.searchQuery)
            }
            .navigationBarHidden(true)
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 12) {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Theme.textColor)
            }
            
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                TextField("Search scholarships...", text: $viewModel.searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 16))
                    .foregroundColor(Theme.textColor)
                    .submitLabel(.search)
                
                if !viewModel.searchQuery.isEmpty {
                    Button(action: { viewModel.clearSearch() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Theme.accentColor.opacity(0.7))
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Theme.cardBackground)
                    .shadow(color: Theme.accentColor.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSearchBarFocused ? Theme.accentColor : Theme.cardBorder, lineWidth: 1)
            )
            .scaleEffect(isSearchBarFocused ? 1.02 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSearchBarFocused)
        }
    }
    
    private var recentSearches: some View {
        ScrollView {
            if !viewModel.recentSearches.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Searches")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Theme.textColor)
                        .padding(.horizontal)
                        .padding(.top, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.recentSearches, id: \.self) { search in
                                Button(action: {
                                    viewModel.searchQuery = search
                                    viewModel.performSearch(query: search)
                                }) {
                                    Text(search)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Theme.accentColor.opacity(0.1))
                                        .foregroundColor(Theme.accentColor)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    private var searchResults: some View {
        ScrollView {
            if viewModel.isSearching {
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Theme.accentColor))
                        .scaleEffect(1.5)
                    Text("Searching...")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Theme.textColor.opacity(0.7))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 50)
            } else if viewModel.searchResults.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(Theme.accentColor.opacity(0.7))
                    Text("No scholarships found")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Theme.textColor)
                    Text("Try different keywords")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.textColor.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 50)
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.searchResults) { scholarship in
                        ScholarshipCardView(scholarship: scholarship)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .padding()
            }
        }
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
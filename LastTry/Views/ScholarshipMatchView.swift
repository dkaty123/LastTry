import SwiftUI

struct OpportunityMatchView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var showMascot = false
    @State private var perfectMatchOpportunity: Opportunity?
    @State private var dismissedOpportunities: Set<UUID> = []
    @StateObject private var motion = SplashMotionManager()
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            contentView
            mascotView
        }
        .onAppear {
            viewModel.updateMatchedOpportunities()
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            titleView
            opportunityListView
        }
    }
    
    private var titleView: some View {
        VStack(spacing: 0) {
            Text("Cosmic Match")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.top, 32)
                .shadow(color: Theme.accentColor.opacity(0.5), radius: 8, x: 0, y: 2)
            
            if let profile = viewModel.userProfile {
                Text("Personalized opportunities for \(profile.name)")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 8)
            }
        }
    }
    
    private var opportunityListView: some View {
        let visibleOpportunities = viewModel.matchedOpportunities.filter { !dismissedOpportunities.contains($0.id) }
        
        return Group {
            if visibleOpportunities.isEmpty {
                emptyStateView
            } else {
                opportunityScrollView(visibleOpportunities: visibleOpportunities)
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 60))
                .foregroundColor(Theme.accentColor)
            Text("No cosmic matches found yet!")
                .font(.title3.bold())
                .foregroundColor(.white)
            Text("Update your profile or check back soon for new opportunities.")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private func opportunityScrollView(visibleOpportunities: [Opportunity]) -> some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(visibleOpportunities) { opportunity in
                    opportunityCard(opportunity: opportunity)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
        }
    }
    
    private func opportunityCard(opportunity: Opportunity) -> some View {
        OpportunityCardView(
            opportunity: opportunity,
            swipeDirection: nil
        )
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        if isPerfectMatch(opportunity: opportunity) {
                            perfectMatchOpportunity = opportunity
                            showMascot = true
                        }
                    }
            }
        )
    }
    
    private var mascotView: some View {
        Group {
            if showMascot, let opportunity = perfectMatchOpportunity {
                VStack {
                    Spacer()
                    CuteMascotView(message: "Cosmic Match! \(opportunity.title)")
                        .padding(.bottom, 40)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                showMascot = false
                                perfectMatchOpportunity = nil
                            }
                        }
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
    }
    
    private func isPerfectMatch(opportunity: Opportunity) -> Bool {
        return viewModel.matchedOpportunities.first == opportunity && !viewModel.matchedOpportunities.isEmpty
    }
}

struct CosmicMatchCardView: View {
    let scholarship: Scholarship
    let isSaved: Bool
    let onSave: () -> Void
    let onUnsave: () -> Void
    let onDismiss: () -> Void
    
    @State private var isExpanded = false
    @State private var isAnimating = false
    @State private var isHovered = false
    @State private var showConfetti = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with action buttons
            HStack {
                // Dismiss button (X)
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Save/Unsave button
                Button(action: {
                    withAnimation(.spring()) {
                        if isSaved {
                            onUnsave()
                        } else {
                            onSave()
                            showConfetti = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showConfetti = false
                            }
                        }
                    }
                }) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .font(.title2)
                        .foregroundColor(isSaved ? Theme.accentColor : .white.opacity(0.7))
                        .scaleEffect(isSaved ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3), value: isSaved)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Scholarship content
            VStack(spacing: 10) {
                Text(scholarship.name)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                
                Text("$\(Int(scholarship.amount))")
                    .font(.title.bold())
                    .foregroundColor(Theme.accentColor)
                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                    .scaleEffect(isHovered ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            }
            .offset(y: isAnimating ? 0 : -20)
            .opacity(isAnimating ? 1 : 0)
            
            // Category Badge
            Text(scholarship.category.rawValue.uppercased())
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    ZStack {
                        Theme.accentColor.opacity(0.3)
                        Circle()
                            .fill(Theme.accentColor.opacity(0.2))
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .opacity(isAnimating ? 0 : 1)
                    }
                )
                .cornerRadius(15)
                .scaleEffect(isHovered ? 1.05 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            
            // Description
            HStack(alignment: .top, spacing: 12) {
                Image(categoryCatImageName(for: scholarship.category))
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                
                Text(scholarship.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal)
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : 20)
            
            if isExpanded {
                // Requirements
                VStack(alignment: .leading, spacing: 10) {
                    Text("Requirements:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    ForEach(Array(scholarship.requirements.enumerated()), id: \.element) { index, requirement in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Theme.successColor)
                                .scaleEffect(isAnimating ? 1 : 0.5)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6).delay(Double(index) * 0.1), value: isAnimating)
                            
                            Text(requirement)
                                .foregroundColor(.white)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(x: isAnimating ? 0 : 20)
                                .animation(.easeOut(duration: 0.3).delay(Double(index) * 0.1), value: isAnimating)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Theme.cardBackground.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Theme.accentColor.opacity(0.3), lineWidth: 1)
                        )
                )
                
                // Deadline
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Theme.accentColor)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isAnimating)
                    
                    Text("Deadline: \(scholarship.deadline.formatted(date: .long, time: .omitted))")
                        .foregroundColor(.white)
                }
                .padding(.vertical, 5)
                
                if let website = scholarship.website {
                    // Website button
                    Link(destination: URL(string: website)!) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.white)
                            Text("Visit Website")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Theme.accentColor)
                                .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                        )
                    }
                    .scaleEffect(isHovered ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
                }
            }
            
            // Expand/Collapse Button
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                    if isExpanded {
                        showConfetti = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            showConfetti = false
                        }
                    }
                }
            }) {
                Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Theme.accentColor)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .scaleEffect(isHovered ? 1.2 : 1.0)
            }
            .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Theme.cardBackground
                
                // Animated gradient overlay
                LinearGradient(
                    gradient: Gradient(colors: [
                        Theme.accentColor.opacity(0.1),
                        Theme.accentColor.opacity(0.05),
                        Theme.accentColor.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(isAnimating ? 1 : 0)
            }
        )
        .cornerRadius(20)
        .shadow(color: Theme.accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()
        .scaleEffect(isAnimating ? 1 : 0.9)
        .opacity(isAnimating ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
        .onHover { hovering in
            isHovered = hovering
        }
        .overlay(
            ConfettiView()
                .opacity(showConfetti ? 1 : 0)
        )
    }
    
    // Helper function to map category to cat image asset name
    private func categoryCatImageName(for category: Scholarship.ScholarshipCategory) -> String {
        switch category {
        case .stem: return "stem"
        case .arts: return "art"
        case .humanities: return "human"
        case .business: return "business"
        case .general: return "general"
        }
    }
}

#Preview {
    OpportunityMatchView()
        .environmentObject(AppViewModel())
} 
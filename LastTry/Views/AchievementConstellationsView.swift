import SwiftUI

struct AchievementStar: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let position: CGPoint // x, y in 0...1 (relative to view size)
    let achieved: Bool
    let category: AchievementCategory
    let points: Int
}

struct AchievementConstellationsView: View {
    @StateObject private var motion = SplashMotionManager()
    @State private var selectedStar: AchievementStar? = nil
    @State private var headerOffset: CGFloat = -50
    @State private var headerOpacity: Double = 0
    @State private var constellationOffset: CGFloat = 100
    @State private var constellationOpacity: Double = 0
    @State private var selectedCategory: AchievementCategory? = nil
    @State private var showAchievementDetail = false
    @State private var totalPoints: Int = 0
    
    // Enhanced achievements with categories and points
    @State private var achievements: [AchievementStar] = [
        AchievementStar(name: "First Save", description: "Saved your first scholarship!", position: CGPoint(x: 0.15, y: 0.7), achieved: true, category: .scholarship, points: 10),
        AchievementStar(name: "10 Swipes", description: "Swiped 10 scholarships!", position: CGPoint(x: 0.3, y: 0.4), achieved: true, category: .scholarship, points: 15),
        AchievementStar(name: "Profile Complete", description: "Completed your profile!", position: CGPoint(x: 0.5, y: 0.2), achieved: false, category: .profile, points: 20),
        AchievementStar(name: "First Application", description: "Sent your first application!", position: CGPoint(x: 0.7, y: 0.5), achieved: false, category: .application, points: 25),
        AchievementStar(name: "AI Interview", description: "Tried the AI Interview Simulator!", position: CGPoint(x: 0.85, y: 0.8), achieved: false, category: .application, points: 30),
        AchievementStar(name: "7-Day Streak", description: "Used ScholarSwipe 7 days in a row!", position: CGPoint(x: 0.6, y: 0.85), achieved: true, category: .special, points: 40),
        AchievementStar(name: "Shared Scholarship", description: "Shared a scholarship!", position: CGPoint(x: 0.4, y: 0.85), achieved: false, category: .community, points: 35),
        AchievementStar(name: "Perfect Match", description: "Found your first perfect match!", position: CGPoint(x: 0.2, y: 0.3), achieved: false, category: .scholarship, points: 50),
        AchievementStar(name: "Constellation Master", description: "Unlocked all achievements!", position: CGPoint(x: 0.5, y: 0.5), achieved: false, category: .special, points: 100)
    ]
    
    // Define connections between stars (by index)
    let connections: [(Int, Int)] = [
        (0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (7, 8), (8, 0)
    ]
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                enhancedHeaderView
                categoryFilterView
                constellationView
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            calculateTotalPoints()
            
            withAnimation(.easeOut(duration: 0.8)) {
                headerOffset = 0
                headerOpacity = 1
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                constellationOffset = 0
                constellationOpacity = 1
            }
        }
        .sheet(isPresented: $showAchievementDetail) {
            if let star = selectedStar {
                AchievementDetailView(star: star)
            }
        }
    }
    
    private var enhancedHeaderView: some View {
        VStack(spacing: 16) {
            // Header with title and stats
            HStack {
                // Placeholder for balance
                Circle()
                    .fill(Color.clear)
                    .frame(width: 40, height: 40)
                
                Spacer()
                
                VStack(spacing: 6) {
                    Text("Achievement Constellations")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Text("Light up your cosmic journey")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Total points badge
                ZStack {
                    Circle()
                        .fill(Theme.accentColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Text("\(totalPoints)")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Progress stats
            HStack(spacing: 20) {
                AchievementStatCard(
                    icon: "star.fill",
                    title: "Achieved",
                    value: "\(achievedCount)",
                    color: Theme.successColor
                )
                
                AchievementStatCard(
                    icon: "sparkles",
                    title: "Total",
                    value: "\(achievements.count)",
                    color: Theme.accentColor
                )
                
                AchievementStatCard(
                    icon: "crown.fill",
                    title: "Points",
                    value: "\(totalPoints)",
                    color: Theme.amberColor
                )
            }
            .padding(.horizontal, 20)
        }
        .background(Theme.backgroundColor.opacity(0.3))
        .offset(y: headerOffset)
        .opacity(headerOpacity)
    }
    
    private var categoryFilterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // All categories button
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedCategory = nil
                    }
                }) {
                    Text("All")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(selectedCategory == nil ? .white : .white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedCategory == nil ? Theme.accentColor : Theme.cardBackground.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(selectedCategory == nil ? Theme.accentColor : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
                .scaleEffect(selectedCategory == nil ? 1.05 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedCategory)
                
                ForEach(AchievementCategory.allCases, id: \.self) { category in
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCategory = category
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: categoryIcon(for: category))
                                .font(.system(size: 12, weight: .medium))
                            
                            Text(category.rawValue)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                        .foregroundColor(selectedCategory == category ? .white : .white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedCategory == category ? categoryColor(for: category) : Theme.cardBackground.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(selectedCategory == category ? categoryColor(for: category) : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                )
                        )
                    }
                    .scaleEffect(selectedCategory == category ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedCategory)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    private var constellationView: some View {
        let filteredAchievements = getFilteredAchievements()
        
        return GeometryReader { geo in
            ZStack {
                // Draw constellation lines
                ForEach(Array(connections.enumerated()), id: \.offset) { (idx, pair) in
                    let (from, to) = pair
                    if from < filteredAchievements.count && to < filteredAchievements.count {
                        let start = filteredAchievements[from].position
                        let end = filteredAchievements[to].position
                        Path { path in
                            path.move(to: CGPoint(x: start.x * geo.size.width, y: start.y * geo.size.height))
                            path.addLine(to: CGPoint(x: end.x * geo.size.width, y: end.y * geo.size.height))
                        }
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Theme.accentColor.opacity(0.3),
                                    Theme.accentColor.opacity(0.1)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                        .shadow(color: Theme.accentColor.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
                
                // Draw stars
                ForEach(Array(filteredAchievements.enumerated()), id: \.offset) { (idx, star) in
                    EnhancedStarView(
                        star: star,
                        onTap: {
                            selectedStar = star
                            showAchievementDetail = true
                        }
                    )
                    .position(x: star.position.x * geo.size.width, y: star.position.y * geo.size.height)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .offset(y: constellationOffset)
        .opacity(constellationOpacity)
    }
    
    private func getFilteredAchievements() -> [AchievementStar] {
        if let category = selectedCategory {
            return achievements.filter { $0.category == category }
        }
        return achievements
    }
    
    private var achievedCount: Int {
        achievements.filter { $0.achieved }.count
    }
    
    private func calculateTotalPoints() {
        totalPoints = achievements.filter { $0.achieved }.reduce(0) { $0 + $1.points }
    }
    
    private func categoryColor(for category: AchievementCategory) -> Color {
        switch category {
        case .application: return .blue
        case .scholarship: return .green
        case .profile: return .purple
        case .community: return .orange
        case .special: return .pink
        }
    }
    
    private func categoryIcon(for category: AchievementCategory) -> String {
        switch category {
        case .application: return "doc.text.fill"
        case .scholarship: return "star.fill"
        case .profile: return "person.fill"
        case .community: return "person.3.fill"
        case .special: return "crown.fill"
        }
    }
}

struct AchievementStatCard: View {
    let icon: String
    let title: String
    let value: String
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
                Text(value)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
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

struct EnhancedStarView: View {
    let star: AchievementStar
    let onTap: () -> Void
    
    @State private var isPressed = false
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isPressed = true
            }
            onTap()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(180)) {
                isPressed = false
            }
        }) {
            ZStack {
                // Background glow
                Circle()
                    .fill(star.achieved ? categoryColor(for: star.category).opacity(0.3) : Color.white.opacity(0.1))
                    .frame(width: star.achieved ? 50 : 40, height: star.achieved ? 50 : 40)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                
                // Main star circle
                Circle()
                    .fill(star.achieved ? categoryColor(for: star.category).opacity(0.8) : Color.white.opacity(0.2))
                    .frame(width: star.achieved ? 40 : 30, height: star.achieved ? 40 : 30)
                    .overlay(
                        Circle()
                            .stroke(star.achieved ? categoryColor(for: star.category) : Color.white.opacity(0.5), lineWidth: 2)
                    )
                    .shadow(color: star.achieved ? categoryColor(for: star.category).opacity(0.5) : Color.clear, radius: star.achieved ? 10 : 0)
                
                // Star icon
                Image(systemName: star.achieved ? "star.fill" : "star")
                    .font(.system(size: star.achieved ? 20 : 16, weight: .medium))
                    .foregroundColor(star.achieved ? .white : .white.opacity(0.7))
                
                // Category indicator
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: categoryIcon(for: star.category))
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(categoryColor(for: star.category))
                            .padding(4)
                            .background(
                                Circle()
                                    .fill(Theme.cardBackground.opacity(0.8))
                            )
                    }
                    Spacer()
                }
                .padding(.top, 4)
                .padding(.trailing, 4)
            }
            .scaleEffect(isPressed ? 1.2 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if star.achieved {
                isAnimating = true
            }
        }
    }
    
    private func categoryColor(for category: AchievementCategory) -> Color {
        switch category {
        case .application: return .blue
        case .scholarship: return .green
        case .profile: return .purple
        case .community: return .orange
        case .special: return .pink
        }
    }
    
    private func categoryIcon(for category: AchievementCategory) -> String {
        switch category {
        case .application: return "doc.text.fill"
        case .scholarship: return "star.fill"
        case .profile: return "person.fill"
        case .community: return "person.3.fill"
        case .special: return "crown.fill"
        }
    }
}

struct AchievementDetailView: View {
    let star: AchievementStar
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: SplashMotionManager())
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Theme.cardBackground.opacity(0.6))
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                // Achievement icon
                ZStack {
                    Circle()
                        .fill(star.achieved ? categoryColor(for: star.category).opacity(0.3) : Color.white.opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: star.achieved ? "star.fill" : "star")
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(star.achieved ? categoryColor(for: star.category) : .white.opacity(0.7))
                }
                
                // Achievement info
                VStack(spacing: 16) {
                    Text(star.name)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(star.description)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    // Category and points
                    HStack(spacing: 20) {
                        VStack(spacing: 4) {
                            Text(star.category.rawValue)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(categoryColor(for: star.category))
                            
                            Text("Category")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        VStack(spacing: 4) {
                            Text("\(star.points)")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(Theme.amberColor)
                            
                            Text("Points")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Theme.cardBackground.opacity(0.6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                            )
                    )
                    
                    // Status indicator
                    HStack(spacing: 8) {
                        Image(systemName: star.achieved ? "checkmark.circle.fill" : "clock.circle.fill")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(star.achieved ? Theme.successColor : Theme.amberColor)
                        
                        Text(star.achieved ? "Achieved!" : "Not yet achieved")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(star.achieved ? Theme.successColor : Theme.amberColor)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(star.achieved ? Theme.successColor.opacity(0.2) : Theme.amberColor.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(star.achieved ? Theme.successColor.opacity(0.5) : Theme.amberColor.opacity(0.5), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
    
    private func categoryColor(for category: AchievementCategory) -> Color {
        switch category {
        case .application: return .blue
        case .scholarship: return .green
        case .profile: return .purple
        case .community: return .orange
        case .special: return .pink
        }
    }
}

#Preview {
    AchievementConstellationsView()
} 
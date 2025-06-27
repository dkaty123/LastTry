import SwiftUI

struct AchievementStar: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let position: CGPoint // x, y in 0...1 (relative to view size)
    let achieved: Bool
}

struct AchievementConstellationsView: View {
    // Sample achievements (replace with real user data)
    @State private var achievements: [AchievementStar] = [
        AchievementStar(name: "First Save", description: "Saved your first scholarship!", position: CGPoint(x: 0.15, y: 0.7), achieved: true),
        AchievementStar(name: "10 Swipes", description: "Swiped 10 scholarships!", position: CGPoint(x: 0.3, y: 0.4), achieved: true),
        AchievementStar(name: "Profile Complete", description: "Completed your profile!", position: CGPoint(x: 0.5, y: 0.2), achieved: false),
        AchievementStar(name: "First Application", description: "Sent your first application!", position: CGPoint(x: 0.7, y: 0.5), achieved: false),
        AchievementStar(name: "AI Interview", description: "Tried the AI Interview Simulator!", position: CGPoint(x: 0.85, y: 0.8), achieved: false),
        AchievementStar(name: "7-Day Streak", description: "Used ScholarSwipe 7 days in a row!", position: CGPoint(x: 0.6, y: 0.85), achieved: true),
        AchievementStar(name: "Shared Scholarship", description: "Shared a scholarship!", position: CGPoint(x: 0.4, y: 0.85), achieved: false)
    ]
    @State private var selectedStar: AchievementStar? = nil
    
    // Define connections between stars (by index)
    let connections: [(Int, Int)] = [
        (0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 0)
    ]
    
    var constellationView: some View {
        GeometryReader { geo in
            ZStack {
                // Draw constellation lines
                ForEach(Array(connections.enumerated()), id: \.offset) { (idx, pair) in
                    let (from, to) = pair
                    let start = achievements[from].position
                    let end = achievements[to].position
                    Path { path in
                        path.move(to: CGPoint(x: start.x * geo.size.width, y: start.y * geo.size.height))
                        path.addLine(to: CGPoint(x: end.x * geo.size.width, y: end.y * geo.size.height))
                    }
                    .stroke(Color.white.opacity(0.25), lineWidth: 2)
                }
                // Draw stars
                ForEach(Array(achievements.enumerated()), id: \.offset) { (idx, star) in
                    Button(action: { selectedStar = star }) {
                        ZStack {
                            Circle()
                                .fill(star.achieved ? Color.yellow : Color.white.opacity(0.18))
                                .frame(width: star.achieved ? 32 : 22, height: star.achieved ? 32 : 22)
                                .shadow(color: star.achieved ? Color.yellow.opacity(0.7) : .clear, radius: star.achieved ? 16 : 0)
                            if star.achieved {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 18))
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.system(size: 14))
                            }
                        }
                        .scaleEffect(star.achieved ? 1.15 : 1.0)
                        .animation(.spring(), value: star.achieved)
                    }
                    .position(x: star.position.x * geo.size.width, y: star.position.y * geo.size.height)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, 12)
        .padding(.top, 8)
    }

    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: SplashMotionManager())
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(.yellow)
                        .font(.system(size: 28))
                    Text("Achievement Constellations")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                Text("Each star represents an achievement in your ScholarSwipe journey. Light them all up!")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.bottom, 12)
                    .multilineTextAlignment(.center)
                constellationView
                Spacer()
            }
            // Achievement detail popup
            if let star = selectedStar {
                VStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Text(star.name)
                            .font(.headline)
                            .foregroundColor(.yellow)
                        Text(star.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(18)
                    .shadow(radius: 12)
                    .padding(.bottom, 60)
                    Button("Close") { selectedStar = nil }
                        .foregroundColor(.yellow)
                        .padding(.top, 4)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

#Preview {
    AchievementConstellationsView()
} 
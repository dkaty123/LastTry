import SwiftUI

struct ScholarshipStatsView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var isAnimating = false
    @StateObject private var motion = SplashMotionManager()
    
    // Sample data - in a real app, this would come from your data model
    private let stats = [
        ("Total Applications", "12"),
        ("Successful", "5"),
        ("Pending", "4"),
        ("Declined", "3")
    ]
    
    private let successRate: Double = 41.7 // 5/12 * 100
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    Text("Scholarship Universe")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    // Stats Cards
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(stats, id: \.0) { stat in
                            ScholarshipStatCard(title: stat.0, value: stat.1)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Success Rate Gauge
                    ScholarshipSuccessGauge(rate: successRate)
                        .frame(height: 200)
                        .padding()
                    
                    // Scholarship Universe Visualization
                    ScholarshipUniverseVisualization()
                        .frame(height: 300)
                        .padding()
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

struct ScholarshipStatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Text(value)
                .font(.title2.bold())
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.cardBackground.opacity(0.3))
        .cornerRadius(15)
    }
}

struct ScholarshipSuccessGauge: View {
    let rate: Double
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Success Rate")
                .font(.headline)
                .foregroundColor(.white)
            
            ZStack {
                // Background circle
                Circle()
                    .stroke(Theme.cardBackground, lineWidth: 20)
                
                // Progress circle
                Circle()
                    .trim(from: 0, to: rate / 100)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [Theme.accentColor, Theme.accentColor.opacity(0.5)]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                
                // Percentage text
                VStack {
                    Text("\(Int(rate))%")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Text("Success")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
        }
        .padding()
        .background(Theme.cardBackground.opacity(0.3))
        .cornerRadius(15)
    }
}

struct ScholarshipUniverseVisualization: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Background
            Theme.cardBackground.opacity(0.3)
                .cornerRadius(15)
            
            // Stars
            ForEach(0..<20) { index in
                Circle()
                    .fill(Color.white)
                    .frame(width: CGFloat.random(in: 2...4))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width - 40),
                        y: CGFloat.random(in: 0...280)
                    )
                    .opacity(isAnimating ? 0.3 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 1...2))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...1)),
                        value: isAnimating
                    )
            }
            
            // Scholarship planets
            ForEach(0..<3) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Theme.accentColor, Theme.accentColor.opacity(0.5)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)
                    .position(
                        x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 90),
                        y: CGFloat.random(in: 50...230)
                    )
                    .shadow(color: Theme.accentColor.opacity(0.5), radius: 10)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.3),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    ScholarshipStatsView()
        .environmentObject(AppViewModel())
} 
import SwiftUI

struct MoreTabView: View {
    var body: some View {
        ZStack {
            Theme.primaryGradient.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 32))
                        .foregroundColor(Theme.accentColor)
                    Text("More Features")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                .padding(.bottom, 24)
                
                VStack(spacing: 24) {
                    NavigationLink(destination: FinancialPlanningView()) {
                        MoreCardView(title: "Financial Planning", icon: "dollarsign.circle.fill", color: .green)
                    }
                    NavigationLink(destination: ApplicationTrackingView()) {
                        MoreCardView(title: "Application Trackingsss", icon: "chart.bar.fill", color: .blue)
                    }
                    NavigationLink(destination: AchievementsView()) {
                        MoreCardView(title: "Achievements", icon: "trophy.fill", color: .yellow)
                    }
                    NavigationLink(destination: StrategyAnalyticsView()) {
                        MoreCardView(title: "Strategic Insights", icon: "chart.pie.fill", color: .purple)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                Spacer()
            }
        }
    }
}

struct MoreCardView: View {
    let title: String
    let icon: String
    let color: Color
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 36))
                .foregroundColor(.white)
                .padding(18)
                .background(
                    LinearGradient(gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Circle())
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Theme.cardBackground.opacity(0.7))
        .cornerRadius(20)
        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 6)
    }
}

#Preview {
    MoreTabView()
} 
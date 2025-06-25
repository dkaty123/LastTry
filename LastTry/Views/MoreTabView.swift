import SwiftUI

struct MoreTabView: View {
    @StateObject private var motion = SplashMotionManager()
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 28))
                        .foregroundColor(Theme.accentColor)
                    Text("More Features")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                .padding(.top, 30)
                .padding(.bottom, 16)
                
                VStack(spacing: 10) {
                    NavigationLink(destination: FinancialPlanningView()) {
                        MoreCardView(title: "Financial Planning", icon: "dollarsign.circle.fill", color: .green)
                    }
                    NavigationLink(destination: ApplicationTrackingView()) {
                        MoreCardView(title: "Application Trackingsss", icon: "chart.bar.fill", color: .blue)
                    }
                    NavigationLink(destination: SmartFiltersView()) {
                        MoreCardView(title: "Smart Filters", icon: "slider.horizontal.3", color: .orange)
                    }
                    NavigationLink(destination: AIEssayAssistantView()) {
                        MoreCardView(title: "AI Essay Assistant", icon: "brain.head.profile", color: .purple)
                    }
                    NavigationLink(destination: ScholarshipAlertRadarView()) {
                        MoreCardView(title: "Alert Radar", icon: "radar", color: .red)
                    }
                    NavigationLink(destination: AchievementsView()) {
                        MoreCardView(title: "Achievements", icon: "trophy.fill", color: .yellow)
                    }
                    NavigationLink(destination: StrategyAnalyticsView()) {
                        MoreCardView(title: "Strategic Insights", icon: "chart.pie.fill", color: .purple)
                    }
                    NavigationLink(destination: MentorshipMarketplaceView()) {
                        MoreCardView(title: "Mentorship Marketplace", icon: "person.2.wave.2.fill", color: .purple)
                    }
                    
                    // AI Assistant Section
                    VStack(spacing: 8) {
                        Text("AI Assistant")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ChatbotAvatarCard()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
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
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .padding(10)
                .background(
                    LinearGradient(gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Circle())
            Text(title)
                .font(.subheadline.bold())
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Theme.cardBackground.opacity(0.7))
        .cornerRadius(12)
        .shadow(color: color.opacity(0.3), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    MoreTabView()
} 
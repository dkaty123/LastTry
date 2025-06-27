import SwiftUI

struct LiveActivityFeedView: View {
    @State private var feed: [ActivityFeedItem] = ActivityFeedItem.sampleFeed
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: SplashMotionManager())
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "bolt.heart.fill")
                        .foregroundColor(.pink)
                        .font(.system(size: 28))
                    Text("Live Activity Feed")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                
                Text("See what ScholarSwipe users are doing around the world in real time!")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.bottom, 12)
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(feed) { item in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: item.icon)
                                    .foregroundColor(item.color)
                                    .font(.system(size: 24))
                                    .padding(8)
                                    .background(item.color.opacity(0.18))
                                    .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.message)
                                        .foregroundColor(.white)
                                        .font(.body)
                                    Text(item.timeAgo)
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                Spacer()
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                Spacer()
            }
            if showToast {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(toastMessage)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 12)
                            .background(Color.pink.opacity(0.92))
                            .cornerRadius(18)
                            .shadow(radius: 8)
                        Spacer()
                    }
                    .padding(.bottom, 60)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: showToast)
            }
        }
        .onAppear {
            // Simulate new activity toasts every few seconds
            Timer.scheduledTimer(withTimeInterval: 4.5, repeats: true) { _ in
                if let random = ActivityFeedItem.sampleFeed.randomElement() {
                    toastMessage = random.message
                    withAnimation { showToast = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation { showToast = false }
                    }
                }
            }
        }
    }
}

struct ActivityFeedItem: Identifiable {
    let id = UUID()
    let message: String
    let icon: String
    let color: Color
    let timeAgo: String
    
    static let sampleFeed: [ActivityFeedItem] = [
        ActivityFeedItem(message: "A user in Brazil just saved a scholarship!", icon: "bookmark.fill", color: .green, timeAgo: "Just now"),
        ActivityFeedItem(message: "Someone in India applied to 'STEM Stars'!", icon: "paperplane.fill", color: .blue, timeAgo: "1 min ago"),
        ActivityFeedItem(message: "A user in France joined ScholarSwipe!", icon: "person.crop.circle.fill.badge.plus", color: .purple, timeAgo: "2 min ago"),
        ActivityFeedItem(message: "A user in USA set a scholarship reminder!", icon: "bell.fill", color: .yellow, timeAgo: "3 min ago"),
        ActivityFeedItem(message: "Someone in Japan aced the AI Interview Simulator!", icon: "star.fill", color: .orange, timeAgo: "5 min ago"),
        ActivityFeedItem(message: "A user in Nigeria shared a scholarship!", icon: "square.and.arrow.up.fill", color: .pink, timeAgo: "7 min ago"),
        ActivityFeedItem(message: "A user in Canada completed their profile!", icon: "checkmark.seal.fill", color: .mint, timeAgo: "10 min ago"),
        ActivityFeedItem(message: "Someone in Australia unlocked an achievement!", icon: "trophy.fill", color: .yellow, timeAgo: "12 min ago"),
        ActivityFeedItem(message: "A user in Germany started a new application!", icon: "doc.fill", color: .blue, timeAgo: "15 min ago"),
        ActivityFeedItem(message: "A user in Singapore saved a scholarship!", icon: "bookmark.fill", color: .green, timeAgo: "18 min ago")
    ]
}

#Preview {
    LiveActivityFeedView()
} 
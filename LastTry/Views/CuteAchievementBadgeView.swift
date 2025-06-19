import SwiftUI

struct CuteAchievementBadgeView: View {
    let title: String
    let icon: String
    let color: Color
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(color)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
            }
            
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    HStack {
        CuteAchievementBadgeView(
            title: "First Search",
            icon: "magnifyingglass",
            color: Theme.accentColor
        )
        CuteAchievementBadgeView(
            title: "Saved 5",
            icon: "bookmark.fill",
            color: Theme.successColor
        )
    }
} 
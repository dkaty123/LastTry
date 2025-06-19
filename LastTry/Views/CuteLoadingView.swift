import SwiftUI

struct CuteLoadingView: View {
    @State private var isAnimating = false
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            // Cute loading animation
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Theme.accentColor)
                        .frame(width: 12, height: 12)
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .opacity(isAnimating ? 1.0 : 0.3)
                        .animation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(0.2 * Double(index)),
                            value: isAnimating
                        )
                }
            }
            
            Text(message)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.secondary)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    CuteLoadingView(message: "Finding scholarships...")
} 
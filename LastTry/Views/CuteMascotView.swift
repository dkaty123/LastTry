import SwiftUI

struct CuteMascotView: View {
    @State private var isAnimating = false
    @State private var showMessage = false
    let message: String
    
    var body: some View {
        VStack {
            // Cute owl mascot
            Image(systemName: "owl.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(Theme.accentColor)
                .rotationEffect(.degrees(isAnimating ? 5 : -5))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
            
            if showMessage {
                Text(message)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Theme.accentColor.opacity(0.9))
                    .cornerRadius(12)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear {
            isAnimating = true
            withAnimation(.easeIn(duration: 0.5).delay(0.5)) {
                showMessage = true
            }
        }
    }
}

#Preview {
    CuteMascotView(message: "Let's find some scholarships! 🎓")
} 
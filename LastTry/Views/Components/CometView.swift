import SwiftUI

struct TaperedTrailShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // The shape's start (right) is as wide as the frame's height,
        // and it tapers to a point at the end (left).
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

struct CometView: View {
    @State private var isAnimating = false
    let delay: Double
    let duration: Double = 2.5 // Faster speed

    var body: some View {
        ZStack {
            // Fiery Trail - Outer Glow (wider, more transparent, tapered)
            TaperedTrailShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.7), Color.clear]),
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                )
                .frame(width: 350, height: 40)
                .blur(radius: 18)

            // Fiery Trail - Inner Core (hotter, more defined, tapered)
            TaperedTrailShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.yellow.opacity(0.9)]),
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                )
                .frame(width: 330, height: 20)
                .blur(radius: 10)
            
            // Particle System for Embers
            CometParticleEmitter(isAnimating: $isAnimating)
                .frame(width: 250, height: 60)
                .offset(x: 50)

            // Comet Head (Rocky center, glowing edge)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [Color.gray.opacity(0.85), Color.gray.opacity(0.7), Color.yellow.opacity(0.7), Color.orange.opacity(0.5), Color.white.opacity(0.18)]),
                        center: .center,
                        startRadius: 2,
                        endRadius: 20
                    )
                )
                .frame(width: 40, height: 40)
                .shadow(color: .yellow.opacity(0.18), radius: 30, x: 0, y: 0)
                .shadow(color: .orange.opacity(0.22), radius: 50, x: 0, y: 0)
                .offset(x: 175) // Positioned at the front of the trail
        }
        .rotationEffect(.degrees(-45)) // bottom-left to top-right
        .offset(x: isAnimating ? 400 : -400, y: isAnimating ? -400 : 400)
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            withAnimation(.linear(duration: duration).delay(delay).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
    }
}

struct CometParticleEmitter: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<20) { _ in
                CometParticle(isAnimating: $isAnimating)
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: CGFloat.random(in: 0...geometry.size.height)
                    )
            }
        }
    }
}

struct CometParticle: View {
    @Binding var isAnimating: Bool
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    private let randomDelay = Double.random(in: 0...2)
    private let randomDuration = Double.random(in: 1...3)
    
    var body: some View {
        Circle()
            .fill(Color.orange.opacity(0.8))
            .frame(width: CGFloat.random(in: 2...6), height: CGFloat.random(in: 2...6))
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(
                    .easeOut(duration: randomDuration)
                    .delay(randomDelay)
                    .repeatForever(autoreverses: false)
                ) {
                    self.scale = 0
                    self.opacity = 0
                }
            }
    }
}

#Preview {
    ZStack {
        Theme.primaryGradient.ignoresSafeArea()
        CometView(delay: 0)
    }
} 
import SwiftUI
import Combine
import UIKit

// MARK: - Particle System
struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var opacity: Double
}

struct ParticleSystem: View {
    let particles: [Particle]
    
    var body: some View {
        ForEach(particles) { particle in
            Circle()
                .fill(particle.color)
                .frame(width: particle.size, height: particle.size)
                .position(particle.position)
                .opacity(particle.opacity)
        }
    }
}

class ParticleManager: ObservableObject {
    @Published var particles: [Particle] = []
    private var timer: Timer?
    
    func startParticleSystem(color: Color) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.particles.count > 30 {
                self.particles.removeFirst()
            }
            
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            let particle = Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: CGFloat.random(in: 0...screenHeight)
                ),
                size: CGFloat.random(in: 2...6),
                color: color.opacity(Double.random(in: 0.3...0.8)),
                opacity: 1.0
            )
            
            self.particles.append(particle)
            
            withAnimation(.easeOut(duration: 1.0)) {
                if let index = self.particles.firstIndex(where: { $0.id == particle.id }) {
                    self.particles[index].opacity = 0
                    self.particles[index].position.y += 50
                }
            }
        }
    }
    
    func stopParticleSystem() {
        timer?.invalidate()
        timer = nil
        particles.removeAll()
    }
}

// MARK: - Splash View
struct SplashView: View {
    @State private var isAnimating = false
    @State private var showOnboarding = false
    @State private var rocketOffset: CGFloat = 0
    @StateObject private var particleManager = ParticleManager()
    @EnvironmentObject private var viewModel: AppViewModel
    
    var body: some View {
        ZStack {
            // Animated background
            Theme.primaryGradient
                .ignoresSafeArea()
                .overlay(
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .scaleEffect(isAnimating ? 1.5 : 0.5)
                        .blur(radius: 50)
                        .animation(
                            Animation.easeInOut(duration: 2)
                                .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                )
            
            // Dynamic star field
            ForEach(0..<30) { index in
                StarView(size: CGFloat.random(in: 0.5...2.0),
                        color: Color.white.opacity(Double.random(in: 0.3...0.8)))
                    .offset(x: CGFloat.random(in: -200...200),
                           y: CGFloat.random(in: -400...400))
                    .opacity(isAnimating ? 1 : 0)
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever()
                            .delay(Double.random(in: 0...2)),
                        value: isAnimating
                    )
            }
            
            // Particle system
            ParticleSystem(particles: particleManager.particles)
            
            VStack(spacing: 20) {
                // Rocket with trail
                ZStack {
                    // Graduation cap
                    ZStack {
                        // Main graduation cap
                        Image(systemName: "graduationcap.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .offset(y: rocketOffset)
                        .animation(
                                Animation.easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                    }
                }
                
                // Title with glow effect
                Text("ScholarSwiper")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .white.opacity(0.5), radius: 10, x: 0, y: 0)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0.8)
                    .animation(.spring(response: 0.6, dampingFraction: 0.6), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
            animateRocket()
            particleManager.startParticleSystem(color: .white)
            
            // Transition to onboarding after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showOnboarding = true
                }
            }
        }
        .onDisappear {
            particleManager.stopParticleSystem()
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
    }
    
    private func animateRocket() {
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            rocketOffset = -20
        }
    }
}

// MARK: - Star View
struct StarView: View {
    let size: CGFloat
    let color: Color
    @State private var isAnimating = false
    
    var body: some View {
        Image(systemName: "star.fill")
            .foregroundColor(color)
            .font(.system(size: size * 10))
            .scaleEffect(isAnimating ? 1.2 : 0.8)
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

#Preview {
    SplashView()
        .environmentObject(AppViewModel())
} 
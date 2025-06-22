import SwiftUI
import CoreMotion

// MARK: - Particle System
struct OnboardingParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var opacity: Double
}

struct OnboardingParticleSystem: View {
    let particles: [OnboardingParticle]
    
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

class OnboardingParticleManager: ObservableObject {
    @Published var particles: [OnboardingParticle] = []
    private var timer: Timer?
    
    func startParticleSystem(color: Color) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.particles.count > 30 {
                self.particles.removeFirst()
            }
            
            let particle = OnboardingParticle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...400),
                    y: CGFloat.random(in: 0...800)
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

// MARK: - Onboarding View
struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showProfileSetup = false
    @State private var cardPulse = false
    @State private var showConfetti = false
    @ObservedObject private var motion = SplashMotionManager()
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var animateBackground = false
    
    private let pages = [
        OnboardingPage(
            title: "Explore the Galaxy of Scholarships",
            description: "Discover amazing opportunities that match your cosmic journey",
            imageName: "star.circle.fill",
            accentColor: .yellow
        ),
        OnboardingPage(
            title: "Save the Ones That Match Your Orbit",
            description: "Keep track of scholarships that align with your goals",
            imageName: "bookmark.circle.fill",
            accentColor: .blue
        ),
        OnboardingPage(
            title: "Launch Your Education Journey!",
            description: "Take the first step towards your stellar future",
            imageName: "graduationcap.circle.fill",
            accentColor: .orange
        )
    ]
    
    var body: some View {
        ZStack {
            // Animated, parallax background
            ScholarSplashBackgroundView(motion: motion)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            animateBackground ? Color.purple : Color.blue,
                            animateBackground ? Color.pink : Color.purple.opacity(0.7)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.18)
                    .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true), value: animateBackground)
                )
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index], cardPulse: $cardPulse, animate: true)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                // Next/Get Started button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                            currentPage += 1
                        }
                    } else {
                        // Confetti burst, then show profile setup
                        showConfetti = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            showProfileSetup = true
                            showConfetti = false
                        }
                    }
                }) {
                    ZStack {
                        if showConfetti {
                            ConfettiView()
                                .allowsHitTesting(false)
                        }
                        Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                            .font(Font.custom("SF Pro Rounded", size: 20).weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.blue, Color.pink]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color.purple.opacity(0.18), radius: 12, x: 0, y: 6)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(Color.white.opacity(0.13), lineWidth: 1.5)
                            )
                            .scaleEffect(showConfetti ? 1.1 : 1.0)
                            .opacity(0.98)
                            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showConfetti)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 24)
                .padding(.bottom, 18)
                .opacity(0.98)
            }
        }
        .onAppear {
            animateBackground = true
        }
        .fullScreenCover(isPresented: $showProfileSetup) {
            ProfileSetupView(isOnboarding: true)
        }
    }
}

// MARK: - Onboarding Page
struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let accentColor: Color
}

// MARK: - Onboarding Page View (Premium)
struct OnboardingPageView: View {
    let page: OnboardingPage
    @Binding var cardPulse: Bool
    var animate: Bool = false
    @State private var showContent = false
    @State private var iconBounce = false
    @State private var shimmerPhase: CGFloat = 0
    var body: some View {
        VStack(spacing: 36) {
            // Animated, glassmorphic card for icon
            ZStack {
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                cardPulse ? Color.purple : Color.blue,
                                cardPulse ? Color.pink : Color.purple.opacity(0.7)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 140, height: 140)
                    .shadow(color: Color.purple.opacity(0.18), radius: 18, x: 0, y: 8)
                    .overlay(
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.18), .clear]), center: .center, startRadius: 10, endRadius: 60))
                            .frame(width: 90, height: 90)
                    )
                    .overlay(
                        Image(systemName: page.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                            .scaleEffect(iconBounce ? 1.15 : 1.0)
                            .animation(.interpolatingSpring(stiffness: 180, damping: 8).delay(0.1), value: iconBounce)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.32), lineWidth: 7)
                                    .blur(radius: 6)
                            )
                            .overlay(
                                ScholarShimmerView(phase: shimmerPhase)
                                    .frame(width: 70, height: 70)
                                    .opacity(0.5)
                            )
                    )
                    .glassEffect()
                    .scaleEffect(showContent ? 1 : 0.8)
                    .opacity(showContent ? 1 : 0)
                    .animation(.spring(response: 0.7, dampingFraction: 0.7), value: showContent)
            }
            // Title
            Text(page.title)
                .font(Font.custom("SF Pro Rounded", size: 30).weight(.bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .shadow(color: Color.purple.opacity(0.18), radius: 6, x: 0, y: 2)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.6).delay(0.1), value: showContent)
            // Description
            Text(page.description)
                .font(Font.custom("Avenir Next", size: 18).weight(.medium))
                .foregroundColor(.white.opacity(0.88))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.7).delay(0.18), value: showContent)
        }
        .padding(.top, 40)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.7)) {
                showContent = true
            }
            withAnimation(.interpolatingSpring(stiffness: 180, damping: 8).delay(0.1)) {
                iconBounce = true
            }
            withAnimation(Animation.linear(duration: 1.8).repeatForever(autoreverses: false)) {
                shimmerPhase = 1
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppViewModel())
} 
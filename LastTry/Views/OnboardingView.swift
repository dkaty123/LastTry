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
    @State private var showGetStarted = false
    @State private var cardPulse = false
    @ObservedObject private var motion = SplashMotionManager()
    @State private var animateBackground = false

    // State for shuttle animation
    @State private var shuttlePosition: CGPoint = .zero
    @State private var shuttleTarget: CGPoint = .zero
    @State private var shuttleAngle: Double = 0.0
    @State private var rockingAngle: Double = 0.0 // For gentle rocking
    
    // Add floating astronaut state
    @State private var onboardingAstronauts: [FloatingSplashAstronaut] = [
        FloatingSplashAstronaut(imageName: "clearIcon", position: CGPoint(x: 80, y: 120), velocity: CGVector(dx: 0.6, dy: 0.4), angle: 0, angleSpeed: 0.004, size: 70),
        FloatingSplashAstronaut(imageName: "clearIcon1", position: CGPoint(x: 200, y: 180), velocity: CGVector(dx: -0.5, dy: 0.55), angle: 0, angleSpeed: -0.005, size: 68),
        FloatingSplashAstronaut(imageName: "clearIcon2", position: CGPoint(x: 300, y: 100), velocity: CGVector(dx: 0.35, dy: -0.65), angle: 0, angleSpeed: 0.003, size: 74),
        FloatingSplashAstronaut(imageName: "clearIcon3", position: CGPoint(x: 120, y: 300), velocity: CGVector(dx: -0.55, dy: -0.35), angle: 0, angleSpeed: 0.006, size: 72)
    ]
    @State private var astronautOscillationPhase: Double = 0
    
    private let pages = [
        OnboardingPage(
            title: "Explore the Galaxy of Scholarships",
            description: "Discover amazing opportunities that match your cosmic journey",
            avatarType: .cosmicCat,
            accentColor: .yellow
        ),
        OnboardingPage(
            title: "Save the Ones That Match Your Orbit",
            description: "Keep track of scholarships that align with your goals",
            avatarType: .spaceDog,
            accentColor: .blue
        ),
        OnboardingPage(
            title: "Launch Your Education Journey!",
            description: "Take the first step towards your stellar future",
            avatarType: .starFox,
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

            // Add the shuttle with animals, moving randomly
            GeometryReader { geo in
                OnboardingShuttleView()
                    .position(shuttlePosition)
                    .rotationEffect(.radians(shuttleAngle + rockingAngle))
                    .onAppear {
                        // Start the animation
                        shuttlePosition = randomPoint(in: geo.size)
                        shuttleTarget = randomPoint(in: geo.size)
                        moveShuttle(in: geo.size)
                        animateRocking()
                    }
            }
            .zIndex(3)

            // Floating astronaut cats (restricted to upper half)
            GeometryReader { geo in
                let screenHeight = geo.size.height
                ForEach(onboardingAstronauts.indices, id: \ .self) { i in
                    let astro = onboardingAstronauts[i]
                    Image(astro.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: astro.size, height: astro.size)
                        .rotationEffect(.radians(astro.angle + sin(astronautOscillationPhase + Double(i)) * 0.18))
                        .position(x: astro.position.x, y: min(astro.position.y, screenHeight * 0.20))
                        .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                        .animation(.easeInOut(duration: 0.7), value: astro.position)
                }
            }
            .zIndex(2)

            VStack {
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
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
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showGetStarted = true
                        }
                    }
                }) {
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
                        .opacity(0.98)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 24)
                .padding(.bottom, 18)
                .opacity(0.98)
            }
        }
        .onAppear {
            animateBackground = true
            // Start floating astronaut animation
            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                let screen = UIScreen.main.bounds
                let upperLimit = screen.height * 0.20
                for i in onboardingAstronauts.indices {
                    var astro = onboardingAstronauts[i]
                    // Move
                    astro.position.x += astro.velocity.dx
                    astro.position.y += astro.velocity.dy
                    // Bounce off left/right edges
                    if astro.position.x < astro.size/2 || astro.position.x > screen.width - astro.size/2 {
                        astro.velocity.dx *= -1
                        astro.position.x = min(max(astro.size/2, astro.position.x), screen.width - astro.size/2)
                    }
                    // Bounce off top/upper half only
                    if astro.position.y < astro.size/2 {
                        astro.velocity.dy *= -1
                        astro.position.y = astro.size/2
                    } else if astro.position.y > upperLimit - astro.size/2 {
                        astro.velocity.dy *= -1
                        astro.position.y = upperLimit - astro.size/2
                    }
                    // Gentle angle rotation, but keep mostly upright
                    astro.angle += astro.angleSpeed
                    astro.angle = min(max(astro.angle, -0.2), 0.2)
                    // Occasional random direction change
                    if Int.random(in: 0...400) == 0 {
                        astro.velocity.dx += Double.random(in: -0.2...0.2)
                        astro.velocity.dy += Double.random(in: -0.2...0.2)
                    }
                    onboardingAstronauts[i] = astro
                }
                astronautOscillationPhase += 0.025
            }
        }
        .fullScreenCover(isPresented: $showGetStarted) {
            ProfileSetupView(isOnboarding: true)
        }
    }

    // Functions to animate the shuttle
    private func randomPoint(in size: CGSize) -> CGPoint {
        let padding: CGFloat = 80
        let minY: CGFloat = 40
        let maxY: CGFloat = 140 // Just above the logo/avatar
        return CGPoint(
            x: CGFloat.random(in: padding...(size.width - padding)),
            y: CGFloat.random(in: minY...maxY)
        )
    }

    private func moveShuttle(in size: CGSize) {
        let dx = shuttleTarget.x - shuttlePosition.x
        let dy = shuttleTarget.y - shuttlePosition.y
        // let targetAngle = atan2(dy, dx)
        let randomDuration = Double.random(in: 6.0...9.0)

        withAnimation(.easeInOut(duration: randomDuration)) {
            shuttlePosition = shuttleTarget
            shuttleAngle = 0.0 // Always upright
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + randomDuration) {
            shuttleTarget = randomPoint(in: size)
            moveShuttle(in: size)
        }
    }

    private func animateRocking() {
        withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
            rockingAngle = .pi / 18 // ~10 degrees
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                rockingAngle = -.pi / 18
            }
        }
    }
}

// MARK: - Onboarding Page
struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let avatarType: AvatarType
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
    @State private var imagePulse = false
    var body: some View {
        VStack(spacing: 36) {
            // Animated, glassmorphic card for icon
            ZStack {
                if page.avatarType == .cosmicCat {
                    // Copy splash formatting for testerCat
                    let logoCardSize: CGFloat = 160
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
                        .frame(width: logoCardSize, height: logoCardSize)
                        .overlay(
                            ZStack {
                                // Soft spotlight/glow
                                Circle()
                                    .fill(RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.25), .clear]), center: .center, startRadius: 10, endRadius: 80))
                                    .frame(width: 120, height: 120)
                                // testerCat icon in the center
                                Image("testerCat")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: logoCardSize, height: logoCardSize)
                                    .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                                    .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                                            .stroke(Color.white.opacity(0.45), lineWidth: 10)
                                            .blur(radius: 8)
                                    )
                                    .scaleEffect(imagePulse ? 1.02 : 0.98)
                                    .animation(Animation.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: imagePulse)
                                    .onAppear { imagePulse = true }
                            }
                        )
                        .shadow(color: Color.purple.opacity(0.18), radius: 24, x: 0, y: 12)
                        .padding(.bottom, 8)
                        .glassEffect()
                        .scaleEffect(showContent ? 1 : 0.8)
                        .opacity(showContent ? 1 : 0)
                        .animation(.spring(response: 0.7, dampingFraction: 0.7), value: showContent)
                } else if page.avatarType == .spaceDog {
                    // Copy splash formatting for NewOne
                    let logoCardSize: CGFloat = 160
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
                        .frame(width: logoCardSize, height: logoCardSize)
                        .overlay(
                            ZStack {
                                // Soft spotlight/glow
                                Circle()
                                    .fill(RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.25), .clear]), center: .center, startRadius: 10, endRadius: 80))
                                    .frame(width: 120, height: 120)
                                // NewOne icon in the center
                                Image("NewOne")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: logoCardSize, height: logoCardSize)
                                    .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                                    .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                                            .stroke(Color.white.opacity(0.45), lineWidth: 10)
                                            .blur(radius: 8)
                                    )
                                    .scaleEffect(imagePulse ? 1.02 : 0.98)
                                    .animation(Animation.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: imagePulse)
                                    .onAppear { imagePulse = true }
                            }
                        )
                        .shadow(color: Color.purple.opacity(0.18), radius: 24, x: 0, y: 12)
                        .padding(.bottom, 8)
                        .glassEffect()
                        .scaleEffect(showContent ? 1 : 0.8)
                        .opacity(showContent ? 1 : 0)
                        .animation(.spring(response: 0.7, dampingFraction: 0.7), value: showContent)
                } else if page.avatarType == .starFox {
                    // Copy splash formatting for surfCat
                    let logoCardSize: CGFloat = 160
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
                        .frame(width: logoCardSize, height: logoCardSize)
                        .overlay(
                            ZStack {
                                // Soft spotlight/glow
                                Circle()
                                    .fill(RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.25), .clear]), center: .center, startRadius: 10, endRadius: 80))
                                    .frame(width: 120, height: 120)
                                // surfCat icon in the center
                                Image("surfCat")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: logoCardSize, height: logoCardSize)
                                    .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                                    .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 36, style: .continuous)
                                            .stroke(Color.white.opacity(0.45), lineWidth: 10)
                                            .blur(radius: 8)
                                    )
                                    .scaleEffect(imagePulse ? 1.02 : 0.98)
                                    .animation(Animation.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: imagePulse)
                                    .onAppear { imagePulse = true }
                            }
                        )
                        .shadow(color: Color.purple.opacity(0.18), radius: 24, x: 0, y: 12)
                        .padding(.bottom, 8)
                        .glassEffect()
                        .scaleEffect(showContent ? 1 : 0.8)
                        .opacity(showContent ? 1 : 0)
                        .animation(.spring(response: 0.7, dampingFraction: 0.7), value: showContent)
                } else {
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
                            AvatarFactory.createAvatar(type: page.avatarType, size: 100, isInteractive: true)
                                .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                                .scaleEffect(iconBounce ? 1.15 : 1.0)
                                .animation(.interpolatingSpring(stiffness: 180, damping: 8).delay(0.1), value: iconBounce)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.32), lineWidth: 7)
                                        .blur(radius: 6)
                                )
                        )
                        .glassEffect()
                        .scaleEffect(showContent ? 1 : 0.8)
                        .opacity(showContent ? 1 : 0)
                        .animation(.spring(response: 0.7, dampingFraction: 0.7), value: showContent)
                }
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
}

// Add struct for floating astronaut at the bottom
struct FloatingSplashAstronaut {
    var imageName: String
    var position: CGPoint
    var velocity: CGVector
    var angle: Double
    var angleSpeed: Double
    var size: CGFloat
} 
import SwiftUI
import CoreMotion

struct ScholarSwiperSplashView: View {
    var onLaunch: (() -> Void)? = nil
    @State private var capOffset: CGFloat = 0
    @State private var capBounce = false
    @State private var shimmerPhase: CGFloat = 0
    @State private var taglineOpacity: Double = 0
    @State private var typingText: String = ""
    @State private var showMain = false
    @State private var showOnboarding = false
    @State private var showButtonPulse = false
    @State private var showButtonPulse2 = false
    @State private var iconPop = false
    @State private var diamondLaunched = false
    @State private var cardLaunched = false
    @State private var cardPulse = false
    @State private var showShuttle = false
    @State private var shuttleOffset: CGFloat = -300
    @State private var boarding = false
    @State private var shuttleTakeoff = false
    @State private var liningUp = false
    @State private var animalsInShuttle = false
    @State private var shuttleArrived = false
    @State private var shuttleAnimalOpacity: Double = 0.0
    @State private var animalFalling: [Bool] = [false, false, false]
    @State private var animalSeated: [Bool] = [false, false, false]
    @State private var takeoffY: CGFloat = 0.0
    @State private var takeoffX: CGFloat = 0.0
    @State private var isTakingOff: Bool = false
    @ObservedObject private var motion = SplashMotionManager()
    
    private let fullTypingText = "Powered by AI · Launching Scholarships..."
    private let capBounceHeight: CGFloat = -60
    private let capSize: CGFloat = 90
    private let logoCardSize: CGFloat = 160
    private let shimmerDuration: Double = 1.8
    private let typingSpeed: Double = 0.04
    
    @State private var animals: [FloatingAstronautAnimal] = [
        FloatingAstronautAnimal(type: .cat, position: CGPoint(x: 80, y: 120), target: .zero, angle: 0, bob: 0, size: CGSize(width: 64, height: 64)),
        FloatingAstronautAnimal(type: .dog, position: CGPoint(x: 180, y: 140), target: .zero, angle: 0, bob: 0, size: CGSize(width: 68, height: 68)),
        FloatingAstronautAnimal(type: .bunny, position: CGPoint(x: 280, y: 100), target: .zero, angle: 0, bob: 0, size: CGSize(width: 66, height: 72))
    ]
    
    // Avatar motion states
    @State private var avatarAngles: [Double] = [0, 0, 0]
    @State private var avatarBobs: [CGFloat] = [0, 0, 0]
    @State private var avatarFloating: [CGFloat] = [0, 0, 0]
    
    var body: some View {
        ZStack {
            // Background
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
                .zIndex(0)
            
            // Add moving star field
            ScholarSplashDriftingStarFieldView()
                .zIndex(1)
            
            // Add new animated objects
            ShootingStarView(delay: 1.0)
                .zIndex(2)
            ShootingStarView(delay: 2.5)
                .zIndex(2)
            CometView(delay: 1.5)
                .zIndex(1)

            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    // Glassmorphic/Neumorphic Card and overlays
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
                                // Grad cap icon in the center
                                Image("SplashCateLogo")
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
                                    .scaleEffect(cardPulse ? 1.02 : 0.98)
                                    .animation(Animation.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: cardPulse)
                                    .onAppear {
                                        cardPulse = true
                                    }
                            }
                        )
                       
                        .shadow(color: Color.purple.opacity(0.18), radius: 24, x: 0, y: 12)
                        .padding(.bottom, 8)
                        .glassEffect()
                        .animation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: cardPulse)
                        .onAppear {
                            cardPulse.toggle()
                            withAnimation(Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                                cardPulse.toggle()
                            }
                        }
                    // Top diamond (kept)
                 
                    // Connecting line from diamond to cap
                //    ScholarSplashDiamondLineView(cardSize: logoCardSize)
                    // Cap Logo (replaces lower/loading diamond)
                 //  ScholarCapLogoView(size: capSize, offset: capOffset, bounce: capBounce, shimmerPhase: shimmerPhase)
                }
                .offset(y: cardLaunched ? -UIScreen.main.bounds.height * 0.5 : 0)
                .animation(.easeInOut(duration: 3.0), value: cardLaunched)
                // App Name
                Text("ScholarSwiper")
                    .font(Font.custom("SF Pro Rounded", size: 36).weight(.bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.18), radius: 6, x: 0, y: 2)
                    .padding(.top, 2)
                // Tagline
                Text("Swipe. Match. Fund Your Future.")
                    .font(Font.custom("Avenir Next", size: 18).weight(.medium))
                    .foregroundColor(.white.opacity(0.92))
                    .opacity(taglineOpacity)
                    .padding(.top, 4)
                Spacer()
                // Rocket Launch Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        iconPop = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            iconPop = false
                        }
                    }
                    // After 1 second, proceed to onboarding
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        onLaunch?()
                    }
                }) {
                    Image("startButton2")
                            .resizable()
                            .scaledToFit()
                        .frame(width: 170, height: 170)
                        .scaleEffect(iconPop ? 1.12 : 1.0)
                            .animation(.spring(response: 0.28, dampingFraction: 0.45), value: iconPop)
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel("Launch ScholarSwiper")
                .offset(y: -16)
                .padding(.bottom, 18)
                .opacity(showOnboarding ? 0 : 1)
                .disabled(showOnboarding)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onAppear {
            // Animate cap bounce
            withAnimation(.interpolatingSpring(stiffness: 110, damping: 8).delay(0.2)) {
                capOffset = capBounceHeight
                capBounce = true
            }
            // Animate shimmer
            withAnimation(Animation.linear(duration: shimmerDuration).repeatForever(autoreverses: false)) {
                shimmerPhase = 1
            }
            // Tagline fade-in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeIn(duration: 1.0)) {
                    taglineOpacity = 1
                }
            }
            // Typing effect
            typingText = ""
            for (i, char) in fullTypingText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2 + Double(i) * typingSpeed) {
                    typingText.append(char)
                }
            }
            // Optional: Play chime and haptic
            // ScholarSplashSoundHaptics.playChimeAndHaptic()
            // Initialize random positions and targets
            let geoSize = UIScreen.main.bounds.size
            for i in animals.indices {
                animals[i].position = randomPoint(in: geoSize, size: animals[i].size)
                animals[i].target = randomPoint(in: geoSize, size: animals[i].size)
                animals[i].angle = 0
                animals[i].bob = 0
            }
            // Animation timer
            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                updateAnimals(in: geoSize)
            }
        }
        // .onTapGesture {
        //     // Hero animation: cap flies up and transitions
        //     withAnimation(.easeInOut(duration: 0.7)) {
        //         capOffset = -320
        //         showMain = true
        //     }
        //     // Add navigation/transition logic here
        // }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView().environmentObject(AppViewModel())
        }
    }

    func randomPoint(in size: CGSize, size animalSize: CGSize) -> CGPoint {
        let padding: CGFloat = 40
        let topBandHeight: CGFloat = 120
        let x = CGFloat.random(in: padding...(size.width - padding))
        let y = CGFloat.random(in: padding...(padding + topBandHeight))
        return CGPoint(x: x, y: y)
    }

    func updateAnimals(in geoSize: CGSize) {
        let speed: CGFloat = 0.45 // much slower
        let bobSpeed: CGFloat = 0.045
        let bobRange: CGFloat = 6
        let angleLerp: Double = 0.12 // smooth turning
        let maxTilt: Double = 0.35 // ~20 degrees in radians
        let minTargetDist: CGFloat = 60 // pets must always move at least this far
        for i in animals.indices {
            var animal = animals[i]
            // Move toward target
            let dx = animal.target.x - animal.position.x
            let dy = animal.target.y - animal.position.y
            let dist = sqrt(dx*dx + dy*dy)
            if dist < minTargetDist {
                // Pick a new target that's far enough away
                var newTarget: CGPoint
                repeat {
                    newTarget = randomPoint(in: geoSize, size: animal.size)
                } while sqrt(pow(newTarget.x - animal.position.x, 2) + pow(newTarget.y - animal.position.y, 2)) < minTargetDist
                animal.target = newTarget;
            } else {
                let step = min(speed, dist)
                let targetAngle = atan2(dy, dx)
                animal.position.x += cos(targetAngle) * step
                animal.position.y += sin(targetAngle) * step
                // Clamp angle to gentle tilt
                let clampedAngle = max(-maxTilt, min(maxTilt, targetAngle))
                let delta = clampedAngle - animal.angle
                animal.angle += delta * angleLerp
            }
            // Animate bobbing
            animal.bob = sin(CGFloat(Date().timeIntervalSinceReferenceDate) * bobSpeed * 60 + CGFloat(i) * 2) * bobRange
            animals[i] = animal
        }
        // Collision/bounce
        for i in 0..<animals.count {
            for j in (i+1)..<animals.count {
                let a = animals[i]
                let b = animals[j]
                let minDist = (a.size.width + b.size.width) * 0.45
                let dx = b.position.x - a.position.x
                let dy = b.position.y - a.position.y
                let dist = sqrt(dx*dx + dy*dy)
                if dist < minDist {
                    // Gentle bounce: small push per frame, no abrupt target change
                    let push = (minDist - dist) * 0.08
                    let angle = atan2(dy, dx)
                    animals[i].position.x -= cos(angle) * push
                    animals[i].position.y -= sin(angle) * push
                    animals[j].position.x += cos(angle) * push
                    animals[j].position.y += sin(angle) * push
                }
            }
        }
    }

    private func startAvatarAnimations() {
        // Start floating animation for each avatar immediately
        for i in 0..<3 {
            // Start floating immediately without delay
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                avatarFloating[i] = -8.0
            }
            
            // Start bob animation with different timing
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    avatarBobs[i] = 3.0
                }
            }
            
            // Start gentle rotation
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.4) {
                withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
                    avatarAngles[i] = 0.3
                }
            }
        }
    }
}

// MARK: - Background with Parallax & Constellations
struct ScholarSplashBackgroundView: View {
    @ObservedObject var motion: SplashMotionManager
    var body: some View {
        ZStack {
            // Gradient background with vignetting
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red:0.32, green:0.13, blue:0.56, alpha:1)), Color(#colorLiteral(red:0.07, green:0.09, blue:0.23, alpha:1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .overlay(
                    RadialGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.45)]), center: .center, startRadius: 120, endRadius: 500)
                )
                .ignoresSafeArea()
            // Glowing constellations
            ScholarConstellationsView(parallax: motion.parallax)
        }
    }
}

// MARK: - Parallax Motion Manager
class SplashMotionManager: ObservableObject {
    @Published var parallax: CGSize = .zero
    private var manager: CMMotionManager? = nil
    // Default: live motion
    init() {
        manager = CMMotionManager()
        manager?.deviceMotionUpdateInterval = 1/30
        manager?.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let motion = motion else { return }
            let x = CGFloat(motion.attitude.roll) * 18
            let y = CGFloat(motion.attitude.pitch) * 18
            self?.parallax = CGSize(width: x, height: y)
        }
    }
    // Convenience: fixed parallax (no motion updates)
    init(parallax: CGSize) {
        self.parallax = parallax
        self.manager = nil
    }
    deinit { manager?.stopDeviceMotionUpdates() }
}

// MARK: - Constellations
struct ScholarConstellationsView: View {
    let parallax: CGSize
    let stars: [ScholarStar] = ScholarStar.generateStars()
    let lines: [ScholarConstellationLine] = ScholarConstellationLine.generateLines()
    var body: some View {
        ZStack {
            // Lines
            ForEach(lines) { line in
                Path { path in
                    path.move(to: line.start)
                    path.addLine(to: line.end)
                }
                .stroke(Color.white.opacity(0.18), style: StrokeStyle(lineWidth: 1.2, lineCap: .round, dash: [2, 6]))
                .blur(radius: 0.5)
                .offset(parallax)
            }
            // Stars
            ForEach(stars) { star in
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.95), Color.purple.opacity(0.3)]), center: .center, startRadius: 0, endRadius: star.radius))
                    .frame(width: star.radius * 2, height: star.radius * 2)
                    .shadow(color: Color.purple.opacity(0.18), radius: 8, x: 0, y: 0)
                    .opacity(star.glow ? 1 : 0.7)
                    .offset(x: star.x + parallax.width * 0.5, y: star.y + parallax.height * 0.5)
                    .animation(Animation.easeInOut(duration: 2.5).repeatForever().delay(Double(star.id % 5) * 0.2), value: star.glow)
            }
        }
    }
}

struct ScholarStar: Identifiable {
    let id: Int
    let x: CGFloat
    let y: CGFloat
    let radius: CGFloat
    let glow: Bool
    static func generateStars() -> [ScholarStar] {
        (0..<18).map { i in
            ScholarStar(
                id: i,
                x: CGFloat.random(in: -160...160),
                y: CGFloat.random(in: -320...320),
                radius: CGFloat.random(in: 2.5...5.5),
                glow: Bool.random()
            )
        }
    }
}
struct ScholarConstellationLine: Identifiable {
    let id: Int
    let start: CGPoint
    let end: CGPoint
    static func generateLines() -> [ScholarConstellationLine] {
        [
            ScholarConstellationLine(id: 0, start: CGPoint(x: -120, y: -80), end: CGPoint(x: 40, y: -120)),
            ScholarConstellationLine(id: 1, start: CGPoint(x: 40, y: -120), end: CGPoint(x: 120, y: 60)),
            ScholarConstellationLine(id: 2, start: CGPoint(x: -60, y: 100), end: CGPoint(x: 120, y: 60)),
            ScholarConstellationLine(id: 3, start: CGPoint(x: -120, y: -80), end: CGPoint(x: -60, y: 100)),
            ScholarConstellationLine(id: 4, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 40, y: -120)),
        ]
    }
}

// MARK: - Cap Logo with Bounce, Glow, Shimmer
struct ScholarCapLogoView: View {
    let size: CGFloat
    let offset: CGFloat
    let bounce: Bool
    let shimmerPhase: CGFloat
    @State private var starburstPhase: Bool = false
    @State private var twinklePhases: [Bool] = Array(repeating: false, count: 7)
    var body: some View {
        ZStack {
            // Subtle constellation of twinkling stars
            ForEach(0..<7) { i in
                let angle = Double(i) * (360.0 / 7.0)
                let radius = size * 1.1 + (i % 2 == 0 ? 8 : -6)
                Circle()
                    .fill(Color.white.opacity(0.85))
                    .frame(width: twinklePhases[i] ? 7 : 3.5, height: twinklePhases[i] ? 7 : 3.5)
                    .blur(radius: twinklePhases[i] ? 0.5 : 1.2)
                    .opacity(twinklePhases[i] ? 1 : 0.6)
                    .offset(x: CGFloat(cos(angle * .pi / 180)) * radius, y: CGFloat(sin(angle * .pi / 180)) * radius)
                    .animation(Animation.easeInOut(duration: 1.2 + Double(i) * 0.13).repeatForever(autoreverses: true), value: twinklePhases[i])
            }
            // Cap
            ScholarCapShape()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                .frame(width: size, height: size)
                .shadow(color: Color.purple.opacity(0.35), radius: 16, x: 0, y: 8)
                .overlay(
                    ScholarCapShape()
                        .stroke(Color.white.opacity(0.8), lineWidth: 2.2)
                )
                .offset(y: offset)
            // Light trail/particle (placeholder)
            if bounce {
                ScholarCapTrailView(size: size)
            }
        }
        .onAppear {
            starburstPhase = true
            for i in 0..<twinklePhases.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.18) {
                    twinklePhases[i] = true
                }
            }
        }
    }
}

struct ScholarCapShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Mortarboard
        path.move(to: CGPoint(x: rect.midX - rect.width * 0.45, y: rect.midY - rect.height * 0.18))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - rect.height * 0.38))
        path.addLine(to: CGPoint(x: rect.midX + rect.width * 0.45, y: rect.midY - rect.height * 0.18))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height * 0.02))
        path.closeSubpath()
        // Tassel
        path.move(to: CGPoint(x: rect.midX, y: rect.midY - rect.height * 0.38))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height * 0.32))
        return path
    }
}

struct ScholarCapTrailView: View {
    let size: CGFloat
    @State private var animate = false
    var body: some View {
        Circle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom))
            .frame(width: size * 0.18, height: size * 0.18)
            .offset(y: animate ? 40 : 0)
            .opacity(animate ? 0 : 0.7)
            .onAppear {
                withAnimation(Animation.easeOut(duration: 0.7)) {
                    animate = true
                }
            }
    }
}

struct ScholarShimmerView: View {
    let phase: CGFloat
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.7), Color.white.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .opacity(0.7)
            .mask(
                Rectangle()
                    .fill(Color.white)
                    .rotationEffect(.degrees(20))
                    .offset(x: phase * 120 - 60)
            )
            .animation(.linear(duration: 1.8).repeatForever(autoreverses: false), value: phase)
    }
}

// MARK: - Glass Effect Modifier
extension View {
    func glassEffect() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(Color.white.opacity(0.08))
                    .blur(radius: 6)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .stroke(Color.white.opacity(0.13), lineWidth: 1.5)
            )
    }
}

// MARK: - (Optional) Sound & Haptics
// struct ScholarSplashSoundHaptics {
//     static func playChimeAndHaptic() {
//         // Use AVFoundation for sound and CoreHaptics/UIImpactFeedbackGenerator for haptic
//     }
// }

// MARK: - Drifting Star Field (smooth, constant motion)
struct ScholarSplashDriftingStarFieldView: View {
    // Use static shared state for stars and timer
    private static var sharedStars: [DriftingStar] = DriftingStar.generateStars()
    private static var sharedTimer: Timer? = nil
    @State private var stars: [DriftingStar] = sharedStars
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let duration: Double = 10.0
    var body: some View {
        ZStack {
            ForEach(stars) { star in
                Circle()
                    .fill(star.color)
                    .frame(width: star.size, height: star.size)
                    .position(x: star.position.x, y: star.position.y)
                    .opacity(star.opacity)
            }
        }
        .onAppear {
            if ScholarSplashDriftingStarFieldView.sharedTimer == nil {
                ScholarSplashDriftingStarFieldView.sharedTimer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
                    DispatchQueue.main.async {
                        ScholarSplashDriftingStarFieldView.sharedStars = ScholarSplashDriftingStarFieldView.sharedStars.map { star in
                            var newStar = star
                            newStar.position.x += newStar.dx
                            newStar.position.y += newStar.dy
                            // Loop star to opposite side if off-screen
                            if newStar.position.x < -20 { newStar.position.x = screenWidth + 20 }
                            if newStar.position.x > screenWidth + 20 { newStar.position.x = -20 }
                            if newStar.position.y < -20 { newStar.position.y = screenHeight + 20 }
                            if newStar.position.y > screenHeight + 20 { newStar.position.y = -20 }
                            return newStar
                        }
                    }
                }
            }
            // Sync local state to shared state
            Timer.scheduledTimer(withTimeInterval: 1/30, repeats: true) { _ in
                self.stars = ScholarSplashDriftingStarFieldView.sharedStars
            }
        }
    }
}

struct DriftingStar: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var opacity: Double
    var dx: CGFloat
    var dy: CGFloat
    static func generateStars() -> [DriftingStar] {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return (0..<30).map { _ in
            let angle = Double.random(in: 0...(2 * .pi))
            let speed: CGFloat = CGFloat.random(in: 0.15...0.35) // slow
            return DriftingStar(
                position: CGPoint(x: CGFloat.random(in: 0...screenWidth), y: CGFloat.random(in: 0...screenHeight)),
                size: CGFloat.random(in: 2...6),
                color: Color.white.opacity(Double.random(in: 0.3...0.8)),
                opacity: 1.0,
                dx: cos(angle) * speed,
                dy: sin(angle) * speed
            )
        }
    }
}

// Add new diamond and line components
struct ScholarSplashDiamondView: View {
    var body: some View {
        DiamondShape()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
            .frame(width: 32, height: 32)
            .shadow(color: Color.purple.opacity(0.25), radius: 8, x: 0, y: 4)
            .overlay(
                DiamondShape().stroke(Color.white.opacity(0.7), lineWidth: 2)
            )
    }
}

struct ScholarSplashDiamondLineView: View {
    let cardSize: CGFloat
    var body: some View {
        Path { path in
            let start = CGPoint(x: cardSize / 2, y: cardSize * 0.12)
            let end = CGPoint(x: cardSize / 2, y: cardSize * 0.5 - 10)
            path.move(to: start)
            path.addLine(to: end)
        }
        .stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 3, lineCap: .round))
        .frame(width: cardSize, height: cardSize)
        .offset(y: -cardSize * 0.18)
    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// Add this new shape for the fingerprint design
struct FingerprintShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let minDimension = min(rect.width, rect.height)
        let radii: [CGFloat] = [0.22, 0.32, 0.42, 0.52, 0.62] // smaller, so all circles fit
        for r in radii {
            let radius = minDimension * r
            path.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        }
        // Add a few vertical lines for fingerprint ridges, also inset
        for i in 0..<3 {
            let x = center.x + CGFloat(i - 1) * minDimension * 0.11
            path.move(to: CGPoint(x: x, y: center.y - minDimension * 0.18))
            path.addCurve(to: CGPoint(x: x, y: center.y + minDimension * 0.18), control1: CGPoint(x: x - 8, y: center.y), control2: CGPoint(x: x + 8, y: center.y))
        }
        return path
    }
}

// Add this new view for animated rockets
struct AnimatedRocketView: View {
    @State private var yOffset: CGFloat = 0
    @State private var opacity: Double = 1
    let startX: CGFloat = CGFloat.random(in: -30...30)
    let rocketSize: CGFloat = CGFloat.random(in: 18...28)
    var body: some View {
        ZStack {
            // Shuttle body
            Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                .frame(width: rocketSize * 8, height: rocketSize * 2.2)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 2, y: 2)
            // Shuttle nose
            Circle()
                .fill(Color.gray)
                .frame(width: rocketSize * 1.7, height: rocketSize * 1.7)
                .offset(x: rocketSize * 4)
            // Shuttle wings
            TriangleWing()
                .fill(Color.gray.opacity(0.7))
                .frame(width: rocketSize * 1.7, height: rocketSize * 1.0)
                .offset(x: -rocketSize * 2.2, y: rocketSize * 0.7)
            TriangleWing()
                .fill(Color.gray.opacity(0.7))
                .frame(width: rocketSize * 1.7, height: rocketSize * 1.0)
                .scaleEffect(x: -1, y: 1)
                .offset(x: -rocketSize * 2.2, y: -rocketSize * 0.7)
            // Shuttle tail fin
            TriangleWing()
                .fill(Color.gray)
                .frame(width: rocketSize * 0.8, height: rocketSize * 1.4)
                .rotationEffect(.degrees(90))
                .offset(x: -rocketSize * 3.5)
            // No flame/trail
        }
        .frame(width: rocketSize * 8, height: rocketSize * 2.2)
        .offset(x: startX, y: yOffset)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.7)) {
                yOffset = -220
                opacity = 0
            }
        }
    }
}

// Shared model for floating astronaut animals
struct FloatingAstronautAnimal: Identifiable {
    enum AnimalType { case cat, dog, bunny }
    let id = UUID()
    let type: AnimalType
    var position: CGPoint
    var target: CGPoint
    var angle: Double
    var bob: CGFloat
    var size: CGSize
}

#Preview {
    ScholarSwiperSplashView(onLaunch: nil)
        .environmentObject(AppViewModel())
} 
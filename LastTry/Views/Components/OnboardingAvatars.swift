import SwiftUI

// MARK: - Avatar Types
enum AvatarType: String, CaseIterable {
    case cosmicCat = "Cosmic Cat"
    case spaceDog = "Space Dog"
    case starFox = "Star Fox"
    case nebulaOwl = "Nebula Owl"
    case quantumPenguin = "Quantum Penguin"
    case galaxyDragon = "Galaxy Dragon"
    
    var description: String {
        switch self {
        case .cosmicCat:
            return "A curious explorer who loves discovering new scholarships"
        case .spaceDog:
            return "Your loyal companion on the academic journey"
        case .starFox:
            return "A wise mentor who guides you through applications"
        case .nebulaOwl:
            return "The night owl who helps you meet deadlines"
        case .quantumPenguin:
            return "A cool-headed strategist for your success"
        case .galaxyDragon:
            return "A powerful ally who protects your dreams"
        }
    }
    
    var emoji: String {
        switch self {
        case .cosmicCat: return "🐱"
        case .spaceDog: return "🐕"
        case .starFox: return "🦊"
        case .nebulaOwl: return "🦉"
        case .quantumPenguin: return "🐧"
        case .galaxyDragon: return "🐉"
        }
    }
}

// MARK: - Base Avatar Protocol
protocol AnimatedAvatar {
    var type: AvatarType { get }
    var size: CGFloat { get }
    var isInteractive: Bool { get }
    
    func createView() -> AnyView
}

// MARK: - Cosmic Cat Avatar
struct CosmicCatAvatar: View {
    @State private var isAnimating = false
    @State private var earTwitch = false
    @State private var purring = false
    @State private var floatingOffset: CGFloat = 0
    @State private var eyeBlink = false
    
    let size: CGFloat
    let isInteractive: Bool
    
    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = isInteractive
    }
    
    var body: some View {
        ZStack {
            CatFaceBody(size: size, blink: eyeBlink)
        }
        .offset(y: floatingOffset)
        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: floatingOffset)
        .onAppear {
            startAnimations()
        }
        .onTapGesture {
            if isInteractive {
                triggerInteraction()
            }
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        floatingOffset = -5
        earTwitch = true
        purring = true
        
        // Blinking
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                eyeBlink = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    eyeBlink = false
                }
            }
        }
    }
    
    private func triggerInteraction() {
        // Meow effect
        withAnimation(.easeInOut(duration: 0.3)) {
            purring = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.3)) {
                purring = true
            }
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

struct CatFaceBody: View {
    let size: CGFloat
    let blink: Bool
    var body: some View {
        ZStack {
            // Cat body
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.8), Color.orange.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.8, height: size * 0.6)
                .offset(y: size * 0.1)
            // Cat head
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.9), Color.yellow.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.7, height: size * 0.7)
                .shadow(color: Color.orange.opacity(0.3), radius: 8, x: 0, y: 4)
            // Ears
            HStack(spacing: size * 0.3) {
                CatEar(isTwitching: false, size: size * 0.15)
                CatEar(isTwitching: false, size: size * 0.15)
            }
            .offset(y: -size * 0.35)
            // Eyes
            HStack(spacing: size * 0.2) {
                CatEye(isBlinking: blink, size: size * 0.1)
                CatEye(isBlinking: blink, size: size * 0.1)
            }
            .offset(y: -size * 0.05)
            // Nose
            Triangle()
                .fill(Color.pink)
                .frame(width: size * 0.08, height: size * 0.06)
                .offset(y: size * 0.05)
            // Whiskers
            HStack(spacing: size * 0.45) {
                VStack(spacing: size * 0.06) {
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(15))
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1)
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(-15))
                }
                VStack(spacing: size * 0.06) {
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(-15))
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1)
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(15))
                }
            }
            .offset(y: size * 0.05)
        }
    }
}

struct CatEar: View {
    let isTwitching: Bool
    let size: CGFloat
    
    var body: some View {
        Triangle()
            .fill(Color.orange.opacity(0.8))
            .frame(width: size, height: size * 1.2)
            .rotationEffect(.degrees(isTwitching ? 5 : 0))
            .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isTwitching)
    }
}

struct CatEye: View {
    let isBlinking: Bool
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .frame(width: size, height: size)
                .scaleEffect(y: isBlinking ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isBlinking)
            
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.6, height: size * 0.6)
                .scaleEffect(y: isBlinking ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isBlinking)
            
            Circle()
                .fill(Color.white)
                .frame(width: size * 0.3, height: size * 0.3)
                .offset(x: -size * 0.1, y: -size * 0.1)
        }
    }
}

// MARK: - Space Dog Avatar
struct SpaceDogAvatar: View {
    @State private var isAnimating = false
    @State private var panting = false
    @State private var floatingOffset: CGFloat = 0
    @State private var eyeBlink = false
    
    let size: CGFloat
    let isInteractive: Bool
    
    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = isInteractive
    }
    
    var body: some View {
        ZStack {
            DogFaceBody(size: size, blink: eyeBlink)
        }
        .offset(y: floatingOffset)
        .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: floatingOffset)
        .onAppear {
            startAnimations()
        }
        .onTapGesture {
            if isInteractive {
                triggerInteraction()
            }
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        floatingOffset = -6
        panting = true
        
        // Blinking
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                eyeBlink = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    eyeBlink = false
                }
            }
        }
    }
    
    private func triggerInteraction() {
        // Bark effect
        withAnimation(.easeInOut(duration: 0.2)) {
            panting = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                panting = true
            }
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
}

struct DogFaceBody: View {
    let size: CGFloat
    let blink: Bool
    var body: some View {
        ZStack {
            // Dog body
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.brown.opacity(0.8), Color.orange.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.9, height: size * 0.6)
                .offset(y: size * 0.15)
            // Dog head
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.brown.opacity(0.9), Color.orange.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.8, height: size * 0.8)
                .shadow(color: Color.brown.opacity(0.3), radius: 8, x: 0, y: 4)
            // Ears
            HStack(spacing: size * 0.4) {
                DogEar(size: size * 0.2)
                DogEar(size: size * 0.2)
            }
            .offset(y: -size * 0.3)
            // Eyes
            HStack(spacing: size * 0.25) {
                DogEye(isBlinking: blink, size: size * 0.12)
                DogEye(isBlinking: blink, size: size * 0.12)
            }
            .offset(y: -size * 0.05)
            // Nose
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.1, height: size * 0.08)
                .offset(y: size * 0.08)
        }
    }
}

struct DogEar: View {
    let size: CGFloat
    @State private var earFlop = false
    
    var body: some View {
        Ellipse()
            .fill(Color.brown.opacity(0.7))
            .frame(width: size, height: size * 1.5)
            .rotationEffect(.degrees(earFlop ? 15 : -15))
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: earFlop)
            .onAppear {
                earFlop = true
            }
    }
}

struct DogEye: View {
    let isBlinking: Bool
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.brown)
                .frame(width: size, height: size)
                .scaleEffect(y: isBlinking ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isBlinking)
            
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.7, height: size * 0.7)
                .scaleEffect(y: isBlinking ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isBlinking)
        }
    }
}

// MARK: - Star Fox Avatar
struct StarFoxAvatar: View {
    @State private var isAnimating = false
    @State private var floatingOffset: CGFloat = 0
    @State private var eyeBlink = false
    @State private var wisdomGlow = false
    
    let size: CGFloat
    let isInteractive: Bool
    
    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = isInteractive
    }
    
    var body: some View {
        ZStack {
            // Fox body
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.8, height: size * 0.5)
                .offset(y: size * 0.2)
            
            // Fox head
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.9), Color.red.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.7, height: size * 0.7)
                .shadow(color: Color.orange.opacity(0.3), radius: 8, x: 0, y: 4)
            
            // Ears
            HStack(spacing: size * 0.25) {
                FoxEar(size: size * 0.18)
                FoxEar(size: size * 0.18)
            }
            .offset(y: -size * 0.35)
            
            // Eyes
            HStack(spacing: size * 0.2) {
                FoxEye(isBlinking: eyeBlink, size: size * 0.1)
                FoxEye(isBlinking: eyeBlink, size: size * 0.1)
            }
            .offset(y: -size * 0.05)
            
            // Nose
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.08, height: size * 0.06)
                .offset(y: size * 0.08)
            
        }
        .offset(y: floatingOffset)
        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: floatingOffset)
        .onAppear {
            startAnimations()
        }
        .onTapGesture {
            if isInteractive {
                triggerInteraction()
            }
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        floatingOffset = -7
        wisdomGlow = true
        
        // Blinking
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                eyeBlink = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    eyeBlink = false
                }
            }
        }
    }
    
    private func triggerInteraction() {
        // Wisdom sparkle effect
        withAnimation(.easeInOut(duration: 0.5)) {
            wisdomGlow = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                wisdomGlow = true
            }
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

struct FoxEar: View {
    let size: CGFloat
    @State private var earTwitch = false
    
    var body: some View {
        Triangle()
            .fill(Color.orange.opacity(0.8))
            .frame(width: size, height: size * 1.3)
            .rotationEffect(.degrees(earTwitch ? 8 : -8))
            .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: earTwitch)
            .onAppear {
                earTwitch = true
            }
    }
}

struct FoxEye: View {
    let isBlinking: Bool
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Theme.amberColor)
                .frame(width: size, height: size)
                .scaleEffect(y: isBlinking ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isBlinking)
            
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.6, height: size * 0.6)
                .scaleEffect(y: isBlinking ? 0.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isBlinking)
        }
    }
}

// MARK: - Nebula Owl Avatar
struct NebulaOwlAvatar: View {
    @State private var isAnimating = false
    @State private var headTiltAngle: Double = 0
    @State private var wingFlap: Bool = false
    @State private var floatingOffset: CGFloat = 0
    @State private var eyeBlink = false
    @State private var glowPulse: Bool = false

    let size: CGFloat
    let isInteractive: Bool

    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = isInteractive
    }

    var body: some View {
        ZStack {
            // Body
            Ellipse()
                .fill(LinearGradient(colors: [Color(hex: "4B0082"), Color(hex: "2A0D45")], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.8, height: size)
            
            // Wings
            HStack(spacing: size * 0.6) {
                WingShape().fill(Color(hex: "4B0082")).frame(width: size * 0.4, height: size * 0.6).rotationEffect(.degrees(wingFlap ? -15 : 0), anchor: .topTrailing)
                WingShape().fill(Color(hex: "4B0082")).frame(width: size * 0.4, height: size * 0.6).rotationEffect(.degrees(wingFlap ? 15 : 0), anchor: .topLeading)
            }
            .offset(y: size * 0.1)
            
            // Head
            Circle()
                .fill(LinearGradient(colors: [Color(hex: "6A0DAD"), Color(hex: "4B0082")], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.25)
                .rotationEffect(.degrees(headTiltAngle))

            // Face
            VStack(spacing: size * 0.05) {
                HStack(spacing: size * 0.2) {
                    OwlEye(isBlinking: eyeBlink, size: size * 0.15, isGlowing: glowPulse)
                    OwlEye(isBlinking: eyeBlink, size: size * 0.15, isGlowing: glowPulse)
                }
                Triangle() // Beak
                    .fill(Color.yellow)
                    .frame(width: size * 0.1, height: size * 0.1)
                    .rotationEffect(.degrees(180))
            }
            .offset(y: -size * 0.25)
            .rotationEffect(.degrees(headTiltAngle))
        }
        .offset(y: floatingOffset)
        .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: floatingOffset)
        .onAppear(perform: startAnimations)
        .onTapGesture(perform: triggerInteraction)
    }
    
    private func startAnimations() {
        isAnimating = true
        floatingOffset = -10
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) { headTiltAngle = 10 }
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) { wingFlap.toggle() }
        withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) { glowPulse.toggle() }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) { eyeBlink = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { eyeBlink = false }
        }
    }
    
    private func triggerInteraction() {
        withAnimation(.spring()) {
            headTiltAngle = headTiltAngle > 0 ? -15 : 15
        }
    }
}

struct OwlEye: View {
    let isBlinking: Bool
    let size: CGFloat
    let isGlowing: Bool

    var body: some View {
        ZStack {
            Circle().fill(Color.yellow).frame(width: size, height: size)
                .scaleEffect(isGlowing ? 1.1 : 1.0)
                .shadow(color: .yellow, radius: isGlowing ? 8 : 4)
            Circle().fill(Color.black).frame(width: size * 0.7, height: size * 0.7)
            Circle().fill(Color.white.opacity(0.8)).frame(width: size * 0.3, height: size * 0.3).offset(x: -size * 0.1, y: -size * 0.1)
        }.scaleEffect(y: isBlinking ? 0.1 : 1.0)
    }
}

struct WingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Quantum Penguin Avatar
struct QuantumPenguinAvatar: View {
    @State private var isAnimating = false
    @State private var waddleAngle: Double = 0
    @State private var floatingOffset: CGFloat = 0
    @State private var quantumShimmer: Bool = false
    @State private var eyeBlink: Bool = false
    
    let size: CGFloat
    let isInteractive: Bool

    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = isInteractive
    }

    var body: some View {
        ZStack {
            // Body
            Ellipse()
                .fill(Color.black)
                .frame(width: size * 0.7, height: size)
            
            // Belly
            Ellipse()
                .fill(Color.white)
                .frame(width: size * 0.5, height: size * 0.8)
                .offset(y: size * 0.05)
            
            // Quantum Shimmer Overlay
            Ellipse()
                .fill(LinearGradient(colors: [Theme.accentColor.opacity(0.5), Color.cyan.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.7, height: size)
                .opacity(quantumShimmer ? 0.8 : 0)
                .scaleEffect(quantumShimmer ? 1.1 : 1.0)
                .blur(radius: quantumShimmer ? 5 : 0)

            // Flippers
            HStack(spacing: size * 0.8) {
                Ellipse().fill(Color.black).frame(width: size * 0.15, height: size * 0.4)
                Ellipse().fill(Color.black).frame(width: size * 0.15, height: size * 0.4)
            }
            .offset(y: size * 0.05)

            // Face
            VStack(spacing: size * 0.1) {
                HStack(spacing: size * 0.2) {
                    PenguinEye(isBlinking: eyeBlink, size: size * 0.1)
                    PenguinEye(isBlinking: eyeBlink, size: size * 0.1)
                }
                Triangle() // Beak
                    .fill(Color.orange)
                    .frame(width: size * 0.15, height: size * 0.1)
                    .rotationEffect(.degrees(180))
            }.offset(y: -size * 0.15)
        }
        .rotationEffect(.degrees(waddleAngle))
        .offset(y: floatingOffset)
        .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: floatingOffset)
        .onAppear(perform: startAnimations)
        .onTapGesture(perform: triggerInteraction)
    }

    private func startAnimations() {
        isAnimating = true
        floatingOffset = -8
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) { waddleAngle = 5 }
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) { quantumShimmer = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { withAnimation { quantumShimmer = false } }
        }
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) { eyeBlink = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { eyeBlink = false }
        }
    }
    
    private func triggerInteraction() {
        withAnimation(.spring()) {
            waddleAngle = waddleAngle > 0 ? -20 : 20
        }
    }
}

struct PenguinEye: View {
    let isBlinking: Bool
    let size: CGFloat

    var body: some View {
        Circle().fill(Color.white).frame(width: size, height: size)
            .overlay(Circle().fill(Color.black).frame(width: size * 0.6, height: size * 0.6))
            .scaleEffect(y: isBlinking ? 0.1 : 1.0)
    }
}

// MARK: - Galaxy Dragon Avatar
struct GalaxyDragonAvatar: View {
    @State private var isAnimating = false
    @State private var floatingOffset: CGFloat = 0
    @State private var eyeBlink: Bool = false
    @State private var smokePuff: Bool = false
    
    let size: CGFloat
    let isInteractive: Bool

    init(size: CGFloat = 120, isInteractive: Bool = true) {
        self.size = size
        self.isInteractive = isInteractive
    }

    var body: some View {
        ZStack {
            // Head
            DragonHeadShape()
                .fill(LinearGradient(colors: [Color(hex: "00008B"), Color(hex: "4B0082")], startPoint: .top, endPoint: .bottom))
                .frame(width: size, height: size)
                .overlay(GalaxyGlitter(isAnimating: isAnimating).frame(width: size, height: size).mask(DragonHeadShape()))

            // Eyes, Horns, etc.
            VStack(spacing: size * 0.1) {
                HStack(spacing: size * 0.3) {
                    DragonEye(isBlinking: eyeBlink, size: size * 0.15)
                    DragonEye(isBlinking: eyeBlink, size: size * 0.15)
                }
                HStack(spacing: size * 0.1) {
                    // Nostrils
                    Circle().fill(Color.black.opacity(0.5)).frame(width: size * 0.05, height: size * 0.05)
                    Circle().fill(Color.black.opacity(0.5)).frame(width: size * 0.05, height: size * 0.05)
                }
            }.offset(y: -size * 0.1)
            
            if smokePuff {
                StarPuff(size: size * 0.3).offset(y: -size * 0.3)
            }
        }
        .offset(y: floatingOffset)
        .animation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: floatingOffset)
        .onAppear(perform: startAnimations)
        .onTapGesture(perform: triggerInteraction)
    }
    
    private func startAnimations() {
        isAnimating = true
        floatingOffset = -12
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) { eyeBlink = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { eyeBlink = false }
        }
    }
    
    private func triggerInteraction() {
        withAnimation { smokePuff = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { withAnimation { smokePuff = false } }
    }
}

struct DragonHeadShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY), control: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

struct DragonEye: View {
    let isBlinking: Bool
    let size: CGFloat

    var body: some View {
        ZStack {
            Ellipse().fill(Color.red).frame(width: size, height: size * 0.7)
            Rectangle().fill(Color.black).frame(width: size * 0.2, height: size * 0.7)
        }.scaleEffect(y: isBlinking ? 0.1 : 1.0)
    }
}

struct GalaxyGlitter: View {
    let isAnimating: Bool
    var body: some View {
        GeometryReader { geo in
            ForEach(0..<20) { _ in
                Circle()
                    .fill(Color.white.opacity(Double.random(in: 0.5...1.0)))
                    .frame(width: CGFloat.random(in: 1...3), height: CGFloat.random(in: 1...3))
                    .position(x: CGFloat.random(in: 0...geo.size.width), y: CGFloat.random(in: 0...geo.size.height))
                    .opacity(isAnimating ? 1 : 0)
                    .animation(Animation.easeInOut(duration: Double.random(in: 1...3)).repeatForever(autoreverses: true), value: isAnimating)
            }
        }
    }
}

struct StarPuff: View {
    let size: CGFloat
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            ForEach(0..<10) { _ in
                Image(systemName: "sparkle")
                    .font(.system(size: CGFloat.random(in: 5...15)))
                    .foregroundColor(Theme.accentColor)
                    .offset(x: CGFloat.random(in: -size...size), y: CGFloat.random(in: -size...size))
                    .opacity(isAnimating ? 0 : 1)
                    .animation(Animation.easeOut(duration: 1.0).delay(Double.random(in: 0...0.2)), value: isAnimating)
            }
        }.onAppear { withAnimation { isAnimating = true } }
    }
}

// MARK: - Other Animated Objects
struct ShootingStarView: View {
    @State private var isAnimating = false
    let delay: Double
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(LinearGradient(colors: [.white, .yellow.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
                .frame(width: 50, height: 4)
            
            Rectangle()
                .fill(LinearGradient(colors: [.yellow.opacity(0.5), .clear], startPoint: .leading, endPoint: .trailing))
                .frame(width: 100, height: 2)
                .offset(x: -75)
        }
        .rotationEffect(.degrees(-30))
        .offset(x: isAnimating ? 300 : -300, y: isAnimating ? -300 : 300)
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).delay(delay).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
    }
}

struct SpinningPlanetView: View {
    @State private var isRotating = false
    let size: CGFloat
    let color1: Color
    let color2: Color

    var body: some View {
        ZStack {
            // Planet
            Circle()
                .fill(LinearGradient(colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size, height: size)
                .shadow(radius: 5)
            
            // Rings
            Ellipse()
                .stroke(Color.white.opacity(0.8), lineWidth: 2)
                .frame(width: size * 1.5, height: size * 0.5)
                .rotation3DEffect(.degrees(70), axis: (x: 1, y: 0, z: 0))
            
        }
        .rotation3DEffect(.degrees(isRotating ? 360 : 0), axis: (x: 0, y: 1, z: 0))
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                isRotating = true
            }
        }
    }
}

// MARK: - Floating Winking Star View
struct FloatingWinkingStarView: View {
    @State private var isWinking = false
    @State private var twinkle = false
    @State private var floatingOffset: CGFloat = 0
    let size: CGFloat
    
    init(size: CGFloat = 60) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Star body
            StarShape(points: 5)
                .fill(LinearGradient(colors: [Color.yellow, Color.orange.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                .frame(width: size, height: size)
                .shadow(color: Color.yellow.opacity(0.4), radius: 12, x: 0, y: 4)
                .scaleEffect(twinkle ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: twinkle)
            // Twinkling rays
            ForEach(0..<8) { i in
                Capsule()
                    .fill(Color.yellow.opacity(0.7))
                    .frame(width: size * 0.12, height: size * 0.38)
                    .offset(y: -size * 0.7 / 2)
                    .rotationEffect(.degrees(Double(i) * 45))
                    .opacity(twinkle ? 0.5 : 1.0)
                    .animation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: twinkle)
            }
            // Cute face
            VStack(spacing: 0) {
                HStack(spacing: size * 0.13) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: size * 0.13, height: size * 0.13)
                        .scaleEffect(isWinking ? CGSize(width: 1.0, height: 0.2) : CGSize(width: 1.0, height: 1.0), anchor: .center)
                        .animation(.easeInOut(duration: 0.3), value: isWinking)
                    Circle()
                        .fill(Color.black)
                        .frame(width: size * 0.13, height: size * 0.13)
                }
                .padding(.top, size * 0.13)
                RoundedRectangle(cornerRadius: size * 0.04)
                    .fill(Color.black)
                    .frame(width: size * 0.18, height: size * 0.06)
                    .padding(.top, size * 0.04)
            }
        }
        .offset(y: floatingOffset)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                floatingOffset = -10
            }
            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                twinkle.toggle()
            }
            Timer.scheduledTimer(withTimeInterval: 2.2, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    isWinking.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isWinking.toggle()
                    }
                }
            }
        }
    }
}

struct StarShape: Shape {
    let points: Int
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        let angle = .pi * 2 / Double(points * 2)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.45
        var currentAngle = -CGFloat.pi / 2
        var firstPoint = true
        for i in 0..<(points * 2) {
            let r = i % 2 == 0 ? radius : innerRadius
            let x = center.x + CGFloat(cos(currentAngle)) * r
            let y = center.y + CGFloat(sin(currentAngle)) * r
            if firstPoint {
                path.move(to: CGPoint(x: x, y: y))
                firstPoint = false
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            currentAngle += angle
        }
        path.closeSubpath()
        return path
    }
}

// MARK: - Avatar Factory
struct AvatarFactory {
    static func createAvatar(type: AvatarType, size: CGFloat = 120, isInteractive: Bool = true) -> AnyView {
        switch type {
        case .cosmicCat:
            return AnyView(CosmicCatAvatar(size: size, isInteractive: isInteractive))
        case .spaceDog:
            return AnyView(SpaceDogAvatar(size: size, isInteractive: isInteractive))
        case .starFox:
            return AnyView(StarFoxAvatar(size: size, isInteractive: isInteractive))
        case .nebulaOwl:
            return AnyView(NebulaOwlAvatar(size: size, isInteractive: isInteractive))
        case .quantumPenguin:
            return AnyView(QuantumPenguinAvatar(size: size, isInteractive: isInteractive))
        case .galaxyDragon:
            return AnyView(GalaxyDragonAvatar(size: size, isInteractive: isInteractive))
        }
    }
}

// MARK: - Avatar Selection View
struct AvatarSelectionView: View {
    @Binding var selectedAvatar: AvatarType
    @Environment(\.dismiss) private var dismiss
    @StateObject private var motion = SplashMotionManager()
    var body: some View {
        NavigationStack {
            ZStack {
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                ScrollView {
                    VStack(spacing: 24) {
                        headerView
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                            ForEach(AvatarType.allCases, id: \.self) { avatarType in
                                AvatarCard(
                                    type: avatarType,
                                    isSelected: selectedAvatar == avatarType,
                                    action: { selectedAvatar = avatarType }
                                )
                            }
                        }
                        .padding(.horizontal)
                        confirmButton
                    }
                    .padding()
                }
            }
            .navigationTitle("Choose Your Companion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Skip") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    private var headerView: some View {
        VStack(spacing: 16) {
            Text("Choose Your Cosmic Companion")
                .font(Font.custom("SF Pro Rounded", size: 24).weight(.bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Text("Select a friendly avatar to guide you through your scholarship journey")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
    }
    private var confirmButton: some View {
        Button(action: { dismiss() }) {
            Text("Continue with \(selectedAvatar.rawValue)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.accentColor.opacity(0.3))
                .cornerRadius(12)
        }
    }
}

struct AvatarCard: View {
    let type: AvatarType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                AvatarFactory.createAvatar(type: type, size: 80, isInteractive: false)
                VStack(spacing: 8) {
                    Text(type.rawValue)
                        .font(Font.custom("SF Pro Rounded", size: 18).weight(.bold))
                        .foregroundColor(.white)
                    Text(type.description)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Theme.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Helper Views
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct AnimatedPlanetView: View {
    @State private var isRotating = false
    @State private var sparklePhases: [Bool] = Array(repeating: false, count: 8)
    let size: CGFloat
    let planetColor: Color
    let ringColor: Color
    
    init(size: CGFloat = 70, planetColor: Color = Color.blue, ringColor: Color = Color.purple) {
        self.size = size
        self.planetColor = planetColor
        self.ringColor = ringColor
    }
    
    var body: some View {
        ZStack {
            // Planet
            Circle()
                .fill(LinearGradient(colors: [planetColor, planetColor.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size, height: size)
                .shadow(color: planetColor.opacity(0.3), radius: 10, x: 0, y: 4)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.linear(duration: 8).repeatForever(autoreverses: false), value: isRotating)
            // Rings
            Ellipse()
                .stroke(ringColor.opacity(0.7), lineWidth: 6)
                .frame(width: size * 1.4, height: size * 0.45)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .blur(radius: 0.7)
                .animation(.linear(duration: 8).repeatForever(autoreverses: false), value: isRotating)
            // Sparkles
            ForEach(0..<8) { i in
                Circle()
                    .fill(Color.white.opacity(sparklePhases[i] ? 1.0 : 0.3))
                    .frame(width: CGFloat.random(in: 4...7), height: CGFloat.random(in: 4...7))
                    .offset(x: cos(Double(i) * .pi / 4) * size * 0.7, y: sin(Double(i) * .pi / 4) * size * 0.4)
                    .scaleEffect(sparklePhases[i] ? 1.2 : 0.7)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(Double(i) * 0.18), value: sparklePhases[i])
            }
        }
        .onAppear {
            isRotating = true
            for i in sparklePhases.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.18) {
                    sparklePhases[i] = true
                }
            }
        }
    }
}

struct AstronautCatView: View {
    @State private var floating = false
    @State private var waving = false
    @State private var blink = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body with colored panels and seams
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.blue.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.blue.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Arms with gloves (copying leg design exactly)
            ZStack {
                // Left arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(x: -size * 0.22, y: size * 0.25)
                .rotationEffect(.degrees(15), anchor: .bottom)
                // Right arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(x: size * 0.22, y: size * 0.25)
                .rotationEffect(.degrees(-15), anchor: .bottom)
            }
            // Legs with boots
            HStack(spacing: size * 0.18) {
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(y: size * 0.5)
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(y: size * 0.5)
            }
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.blue.opacity(0.18), radius: 8, x: 0, y: 2)
            // Cat face/body inside helmet
            CatFaceBody(size: size * 0.7, blink: blink)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.4)) { waving.toggle() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.4)) { waving.toggle() }
                }
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

struct AstronautDogView: View {
    @State private var floating = false
    @State private var tailWag = false
    @State private var blink = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body with colored panels and seams
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.orange.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.orange.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Arms with gloves (copying leg design exactly)
            ZStack {
                // Left arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(x: -size * 0.22, y: size * 0.25)
                .rotationEffect(.degrees(15), anchor: .bottom)
                // Right arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(x: size * 0.22, y: size * 0.25)
                .rotationEffect(.degrees(-15), anchor: .bottom)
            }
            // Legs with boots
            HStack(spacing: size * 0.18) {
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(y: size * 0.5)
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(y: size * 0.5)
            }
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.orange.opacity(0.18), radius: 8, x: 0, y: 2)
            // Dog face/body inside helmet
            DogFaceBody(size: size * 0.7, blink: blink)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            tailWag = true
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

struct AstronautBunnyView: View {
    @State private var floating = false
    @State private var blink = false
    @State private var earWiggle = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.pink.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.pink.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.pink.opacity(0.18), radius: 8, x: 0, y: 2)
            // Bunny face/body inside helmet
            BunnyFaceBody(size: size * 0.7, blink: blink, earWiggle: earWiggle)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            earWiggle = true
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.3)) { earWiggle.toggle() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.3)) { earWiggle.toggle() }
                }
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

struct BunnyFaceBody: View {
    let size: CGFloat
    let blink: Bool
    let earWiggle: Bool
    var body: some View {
        ZStack {
            // Bunny body
            Ellipse()
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size * 0.8, height: size * 0.6)
                .offset(y: size * 0.1)
            // Bunny head
            Circle()
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size * 0.7, height: size * 0.7)
                .shadow(color: Color.pink.opacity(0.2), radius: 8, x: 0, y: 4)
            // Ears
            HStack(spacing: size * 0.3) {
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(Color.white)
                    .frame(width: size * 0.13, height: size * 0.32)
                    .offset(y: -size * 0.32)
                    .rotationEffect(.degrees(earWiggle ? 5 : -5))
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(Color.white)
                    .frame(width: size * 0.13, height: size * 0.32)
                    .offset(y: -size * 0.32)
                    .rotationEffect(.degrees(earWiggle ? -5 : 5))
            }
            // Eyes
            HStack(spacing: size * 0.2) {
                Circle().fill(Color.pink).frame(width: size * 0.1, height: size * 0.1).scaleEffect(y: blink ? 0.1 : 1.0)
                Circle().fill(Color.pink).frame(width: size * 0.1, height: size * 0.1).scaleEffect(y: blink ? 0.1 : 1.0)
            }
            // Nose
            Circle().fill(Color.pink).frame(width: size * 0.06, height: size * 0.06).offset(y: size * 0.06)
        }
    }
}

struct FoxFaceBody: View {
    let size: CGFloat
    let blink: Bool
    var body: some View {
        ZStack {
            // Fox body
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.9), Color.red.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.8, height: size * 0.5)
                .offset(y: size * 0.2)
            // Fox head
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.9), Color.red.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.7, height: size * 0.7)
                .shadow(color: Color.orange.opacity(0.3), radius: 8, x: 0, y: 4)
            // Ears
            HStack(spacing: size * 0.25) {
                FoxEar(size: size * 0.18)
                FoxEar(size: size * 0.18)
            }
            .offset(y: -size * 0.35)
            // Eyes
            HStack(spacing: size * 0.2) {
                FoxEye(isBlinking: blink, size: size * 0.1)
                FoxEye(isBlinking: blink, size: size * 0.1)
            }
            .offset(y: -size * 0.05)
            // Nose
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.08, height: size * 0.06)
                .offset(y: size * 0.08)
        }
    }
}

struct AstronautFoxView: View {
    @State private var floating = false
    @State private var blink = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body with colored panels and seams
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.orange.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.orange.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Arms with gloves (copying leg design exactly)
            ZStack {
                // Left arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(x: -size * 0.22, y: size * 0.25)
                .rotationEffect(.degrees(15), anchor: .bottom)
                // Right arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(x: size * 0.22, y: size * 0.25)
                .rotationEffect(.degrees(-15), anchor: .bottom)
            }
            // Legs with boots
            HStack(spacing: size * 0.18) {
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(y: size * 0.5)
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: size * 0.11, height: size * 0.16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange)
                        .frame(width: size * 0.11, height: size * 0.08)
                }
                .offset(y: size * 0.5)
            }
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.orange.opacity(0.18), radius: 8, x: 0, y: 2)
            // Fox face/body inside helmet
            FoxFaceBody(size: size * 0.7, blink: blink)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

// MARK: - Astronaut Owl
struct AstronautOwlView: View {
    @State private var floating = false
    @State private var blink = false
    @State private var headTilt = false
    @State private var wingFlap = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.purple.opacity(0.8), Color.indigo.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.purple.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.purple.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Wings (animated)
            HStack(spacing: size * 0.32) {
                Ellipse().fill(Color.purple).frame(width: size * 0.13, height: size * 0.28)
                    .rotationEffect(.degrees(wingFlap ? -18 : 8), anchor: .topTrailing)
                Ellipse().fill(Color.purple).frame(width: size * 0.13, height: size * 0.28)
                    .rotationEffect(.degrees(wingFlap ? 18 : -8), anchor: .topLeading)
            }
            .offset(y: size * 0.18)
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.purple.opacity(0.18), radius: 8, x: 0, y: 2)
            // Owl face/body inside helmet
            OwlFaceBody(size: size * 0.7, blink: blink, headTilt: headTilt)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) { headTilt = true }
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) { wingFlap.toggle() }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}
struct OwlFaceBody: View {
    let size: CGFloat
    let blink: Bool
    let headTilt: Bool
    var body: some View {
        ZStack {
            Ellipse().fill(LinearGradient(colors: [Color.purple, Color.indigo], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.8, height: size)
            // Head
            Circle().fill(LinearGradient(colors: [Color.purple, Color.indigo], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.7, height: size * 0.7).offset(y: -size * 0.25).rotationEffect(.degrees(headTilt ? 10 : -10))
            // Eyes
            HStack(spacing: size * 0.18) {
                ZStack {
                    Circle().fill(Color.yellow).frame(width: size * 0.15, height: size * 0.15).shadow(color: .yellow, radius: 6)
                    Circle().fill(Color.black).frame(width: size * 0.09, height: size * 0.09)
                }.scaleEffect(y: blink ? 0.1 : 1.0)
                ZStack {
                    Circle().fill(Color.yellow).frame(width: size * 0.15, height: size * 0.15).shadow(color: .yellow, radius: 6)
                    Circle().fill(Color.black).frame(width: size * 0.09, height: size * 0.09)
                }.scaleEffect(y: blink ? 0.1 : 1.0)
            }.offset(y: -size * 0.25).rotationEffect(.degrees(headTilt ? 10 : -10))
            // Beak
            Triangle().fill(Color.orange).frame(width: size * 0.08, height: size * 0.08).rotationEffect(.degrees(180)).offset(y: -size * 0.13)
        }
    }
}

// MARK: - Astronaut Penguin
struct AstronautPenguinView: View {
    @State private var floating = false
    @State private var blink = false
    @State private var shimmer = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.blue.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.blue.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Flippers (animated)
            HStack(spacing: size * 0.32) {
                Ellipse().fill(Color.black).frame(width: size * 0.09, height: size * 0.22).rotationEffect(.degrees(shimmer ? -18 : 8), anchor: .topTrailing)
                Ellipse().fill(Color.black).frame(width: size * 0.09, height: size * 0.22).rotationEffect(.degrees(shimmer ? 18 : -8), anchor: .topLeading)
            }
            .offset(y: size * 0.18)
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.blue.opacity(0.18), radius: 8, x: 0, y: 2)
            // Penguin face/body inside helmet
            PenguinFaceBody(size: size * 0.7, blink: blink, shimmer: shimmer)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) { shimmer.toggle() }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}
struct PenguinFaceBody: View {
    let size: CGFloat
    let blink: Bool
    let shimmer: Bool
    var body: some View {
        ZStack {
            Ellipse().fill(Color.black).frame(width: size * 0.7, height: size)
            Ellipse().fill(Color.white).frame(width: size * 0.5, height: size * 0.8).offset(y: size * 0.05)
            Ellipse().fill(LinearGradient(colors: [Color.blue.opacity(0.5), Color.cyan.opacity(0.5)], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.7, height: size).opacity(shimmer ? 0.8 : 0).scaleEffect(shimmer ? 1.1 : 1.0).blur(radius: shimmer ? 5 : 0)
            // Eyes
            HStack(spacing: size * 0.13) {
                Circle().fill(Color.white).frame(width: size * 0.08, height: size * 0.08).overlay(Circle().fill(Color.black).frame(width: size * 0.05, height: size * 0.05)).scaleEffect(y: blink ? 0.1 : 1.0)
                Circle().fill(Color.white).frame(width: size * 0.08, height: size * 0.08).overlay(Circle().fill(Color.black).frame(width: size * 0.05, height: size * 0.05)).scaleEffect(y: blink ? 0.1 : 1.0)
            }.offset(y: -size * 0.15)
            // Beak
            Triangle().fill(Color.orange).frame(width: size * 0.09, height: size * 0.06).rotationEffect(.degrees(180)).offset(y: size * 0.04)
        }
    }
}

// MARK: - Astronaut Dragon
struct AstronautDragonView: View {
    @State private var floating = false
    @State private var blink = false
    @State private var smoke = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.purple.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.purple.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Tail (animated)
            Capsule().fill(Color.purple).frame(width: size * 0.09, height: size * 0.32).rotationEffect(.degrees(floating ? 30 : -30), anchor: .bottom).offset(x: size * 0.22, y: size * 0.38).animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: floating)
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.purple.opacity(0.18), radius: 8, x: 0, y: 2)
            // Dragon face/body inside helmet
            DragonFaceBody(size: size * 0.7, blink: blink, smoke: smoke)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.5)) { smoke = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { withAnimation { smoke = false } }
            }
        }
    }
}
struct DragonFaceBody: View {
    let size: CGFloat
    let blink: Bool
    let smoke: Bool
    var body: some View {
        ZStack {
            // Head
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.7, height: size * 0.7)
            // Eyes
            HStack(spacing: size * 0.18) {
                Circle().fill(Color.cyan).frame(width: size * 0.13, height: size * 0.13).overlay(Circle().fill(Color.black).frame(width: size * 0.07, height: size * 0.07)).scaleEffect(y: blink ? 0.1 : 1.0)
                Circle().fill(Color.cyan).frame(width: size * 0.13, height: size * 0.13).overlay(Circle().fill(Color.black).frame(width: size * 0.07, height: size * 0.07)).scaleEffect(y: blink ? 0.1 : 1.0)
            }.offset(y: -size * 0.1)
            // Nostrils
            HStack(spacing: size * 0.08) {
                Circle().fill(Color.black.opacity(0.5)).frame(width: size * 0.05, height: size * 0.05)
                Circle().fill(Color.black.opacity(0.5)).frame(width: size * 0.05, height: size * 0.05)
            }.offset(y: size * 0.08)
            // Horns
            HStack(spacing: size * 0.22) {
                Capsule().fill(Color.purple).frame(width: size * 0.05, height: size * 0.18).rotationEffect(.degrees(-18)).offset(y: -size * 0.32)
                Capsule().fill(Color.purple).frame(width: size * 0.05, height: size * 0.18).rotationEffect(.degrees(18)).offset(y: -size * 0.32)
            }
            // Smoke puff
            if smoke {
                Circle().fill(Color.white.opacity(0.7)).frame(width: size * 0.18, height: size * 0.18).offset(y: -size * 0.22)
            }
        }
    }
}

// MARK: - Astronaut Bear (Stellar Bear)
struct AstronautBearView: View {
    @State private var floating = false
    @State private var blink = false
    @State private var pawWave = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.brown.opacity(0.7), Color.yellow.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.yellow.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.yellow.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Paw (animated wave)
            VStack(spacing: 0) {
                Capsule().fill(Color.brown).frame(width: size * 0.13, height: size * 0.18)
                Circle().fill(Color.yellow).frame(width: size * 0.13, height: size * 0.13)
            }
            .offset(x: -size * 0.22, y: size * 0.25)
            .rotationEffect(.degrees(pawWave ? 30 : 0), anchor: .bottom)
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.yellow.opacity(0.18), radius: 8, x: 0, y: 2)
            // Bear face/body inside helmet
            BearFaceBody(size: size * 0.7, blink: blink)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.4)) { pawWave.toggle() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.4)) { pawWave.toggle() }
                }
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}
struct BearFaceBody: View {
    let size: CGFloat
    let blink: Bool
    var body: some View {
        ZStack {
            Ellipse().fill(LinearGradient(colors: [Color.brown, Color.yellow.opacity(0.5)], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.8, height: size * 0.6).offset(y: size * 0.1)
            Circle().fill(LinearGradient(colors: [Color.brown, Color.yellow.opacity(0.5)], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.7, height: size * 0.7).shadow(color: Color.yellow.opacity(0.2), radius: 8, x: 0, y: 4)
            // Ears
            HStack(spacing: size * 0.3) {
                Circle().fill(Color.brown).frame(width: size * 0.18, height: size * 0.18).offset(y: -size * 0.18)
                Circle().fill(Color.brown).frame(width: size * 0.18, height: size * 0.18).offset(y: -size * 0.18)
            }
            // Eyes
            HStack(spacing: size * 0.13) {
                Circle().fill(Color.black).frame(width: size * 0.08, height: size * 0.08).scaleEffect(y: blink ? 0.1 : 1.0)
                Circle().fill(Color.black).frame(width: size * 0.08, height: size * 0.08).scaleEffect(y: blink ? 0.1 : 1.0)
            }
            // Nose
            Ellipse().fill(Color.black).frame(width: size * 0.09, height: size * 0.06).offset(y: size * 0.04)
            // Mouth
            RoundedRectangle(cornerRadius: size * 0.02).fill(Color.black).frame(width: size * 0.13, height: size * 0.03).offset(y: size * 0.09)
        }
    }
}

// MARK: - Astronaut Raccoon (Rocket Raccoon)
struct AstronautRaccoonView: View {
    @State private var floating = false
    @State private var blink = false
    @State private var tailSwish = false
    let size: CGFloat
    init(size: CGFloat = 110) { self.size = size }
    var body: some View {
        ZStack {
            // Suit body
            RoundedRectangle(cornerRadius: size * 0.18)
                .fill(LinearGradient(colors: [Color.gray.opacity(0.7), Color.black.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.38, height: size * 0.55)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.18)
                        .stroke(Color.gray.opacity(0.18), lineWidth: 2)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.gray.opacity(0.18)).frame(width: size * 0.32, height: size * 0.08).cornerRadius(6).offset(y: size * 0.13)
                        Spacer()
                    }
                )
                .offset(y: size * 0.22)
            // Tail (animated swish)
            Capsule().fill(LinearGradient(colors: [Color.gray, Color.black], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.09, height: size * 0.32).rotationEffect(.degrees(tailSwish ? 30 : -30), anchor: .bottom).offset(x: size * 0.22, y: size * 0.38).animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: tailSwish)
            // Chest control panel
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white.opacity(0.8))
                .frame(width: size * 0.16, height: size * 0.07)
                .overlay(
                    HStack(spacing: 2) {
                        Circle().fill(Color.red).frame(width: size * 0.025)
                        Circle().fill(Color.green).frame(width: size * 0.025)
                        Circle().fill(Color.yellow).frame(width: size * 0.025)
                    }
                )
                .offset(y: size * 0.28)
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: size * 0.11)
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(y: -size * 0.08)
                .shadow(color: Color.gray.opacity(0.18), radius: 8, x: 0, y: 2)
            // Raccoon face/body inside helmet
            RaccoonFaceBody(size: size * 0.7, blink: blink, tailSwish: tailSwish)
                .offset(y: -size * 0.08)
        }
        .offset(y: floating ? -12 : 8)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: floating)
        .onAppear {
            floating = true
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) { tailSwish.toggle() }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}
struct RaccoonFaceBody: View {
    let size: CGFloat
    let blink: Bool
    let tailSwish: Bool
    var body: some View {
        ZStack {
            Ellipse().fill(LinearGradient(colors: [Color.gray, Color.black], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.8, height: size * 0.6).offset(y: size * 0.1)
            Circle().fill(LinearGradient(colors: [Color.gray, Color.black], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.7, height: size * 0.7).shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            // Ears
            HStack(spacing: size * 0.3) {
                Circle().fill(Color.gray).frame(width: size * 0.18, height: size * 0.18).offset(y: -size * 0.18)
                Circle().fill(Color.gray).frame(width: size * 0.18, height: size * 0.18).offset(y: -size * 0.18)
            }
            // Eyes (with mask)
            HStack(spacing: size * 0.13) {
                ZStack {
                    Ellipse().fill(Color.black).frame(width: size * 0.13, height: size * 0.08)
                    Circle().fill(Color.white).frame(width: size * 0.08, height: size * 0.08).overlay(Circle().fill(Color.black).frame(width: size * 0.05, height: size * 0.05)).scaleEffect(y: blink ? 0.1 : 1.0)
                }
                ZStack {
                    Ellipse().fill(Color.black).frame(width: size * 0.13, height: size * 0.08)
                    Circle().fill(Color.white).frame(width: size * 0.08, height: size * 0.08).overlay(Circle().fill(Color.black).frame(width: size * 0.05, height: size * 0.05)).scaleEffect(y: blink ? 0.1 : 1.0)
                }
            }
            // Nose
            Ellipse().fill(Color.black).frame(width: size * 0.09, height: size * 0.06).offset(y: size * 0.04)
            // Mouth
            RoundedRectangle(cornerRadius: size * 0.02).fill(Color.black).frame(width: size * 0.13, height: size * 0.03).offset(y: size * 0.09)
            // Tail (swishing)
            Capsule().fill(LinearGradient(colors: [Color.gray, Color.black], startPoint: .top, endPoint: .bottom)).frame(width: size * 0.09, height: size * 0.32).rotationEffect(.degrees(tailSwish ? 30 : -30), anchor: .bottom).offset(x: size * 0.22, y: size * 0.38)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        FloatingWinkingStarView(size: 80).position(x: 100, y: 120)
        AnimatedPlanetView(size: 90, planetColor: .blue, ringColor: .purple).position(x: 220, y: 200)
        AnimatedPlanetView(size: 60, planetColor: .green, ringColor: .yellow).position(x: 60, y: 300)
    }
    .frame(width: 350, height: 400)
} 
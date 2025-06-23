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
            // Cat body
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.orange.opacity(0.8), Color.purple.opacity(0.6)],
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
                CatEar(isTwitching: earTwitch, size: size * 0.15)
                CatEar(isTwitching: earTwitch, size: size * 0.15)
            }
            .offset(y: -size * 0.35)
            
            // Eyes
            HStack(spacing: size * 0.2) {
                CatEye(isBlinking: eyeBlink, size: size * 0.1)
                CatEye(isBlinking: eyeBlink, size: size * 0.1)
            }
            .offset(y: -size * 0.05)
            
            // Nose
            Triangle()
                .fill(Color.pink)
                .frame(width: size * 0.08, height: size * 0.06)
                .offset(y: size * 0.05)
            
            // Whiskers
            HStack(spacing: size * 0.45) {
                // Left Whiskers
                VStack(spacing: size * 0.06) {
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(15))
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1)
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(-15))
                }
                
                // Right Whiskers
                VStack(spacing: size * 0.06) {
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(-15))
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1)
                    Rectangle().fill(Color.white.opacity(0.8)).frame(width: size * 0.2, height: 1).rotationEffect(.degrees(15))
                }
            }
            .offset(y: size * 0.05)
            
            // Purring effect
            if purring {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(Color.orange.opacity(0.3))
                        .frame(width: size * 0.1, height: size * 0.1)
                        .offset(x: CGFloat(index - 1) * size * 0.15, y: size * 0.3)
                        .scaleEffect(purring ? 1.5 : 0.5)
                        .opacity(purring ? 0 : 1)
                        .animation(
                            .easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                            value: purring
                        )
                }
            }
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
                DogEye(isBlinking: eyeBlink, size: size * 0.12)
                DogEye(isBlinking: eyeBlink, size: size * 0.12)
            }
            .offset(y: -size * 0.05)
            
            // Nose
            Circle()
                .fill(Color.black)
                .frame(width: size * 0.1, height: size * 0.08)
                .offset(y: size * 0.08)
            
            // Tongue (when panting)
            if panting {
                Ellipse()
                    .fill(Color.pink)
                    .frame(width: size * 0.15, height: size * 0.08)
                    .offset(y: size * 0.2)
                    .scaleEffect(panting ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: panting)
            }
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
            // Wisdom aura
            Circle()
                .fill(Theme.accentColor.opacity(0.2))
                .frame(width: size * 1.4, height: size * 1.4)
                .scaleEffect(wisdomGlow ? 1.2 : 1.0)
                .opacity(wisdomGlow ? 0.8 : 0.4)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: wisdomGlow)
            
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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
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
                .font(.title2.bold())
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
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(type.description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Theme.accentColor.opacity(0.3) : Color.white.opacity(0.1))
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

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            CosmicCatAvatar(size: 100)
            SpaceDogAvatar(size: 100)
            StarFoxAvatar(size: 100)
        }
        HStack(spacing: 20) {
            NebulaOwlAvatar(size: 100)
            QuantumPenguinAvatar(size: 100)
            GalaxyDragonAvatar(size: 100)
        }
        HStack {
            ShootingStarView(delay: 0)
            SpinningPlanetView(size: 80, color1: .blue, color2: .green)
        }
    }
    .padding()
    .background(Theme.primaryGradient)
} 
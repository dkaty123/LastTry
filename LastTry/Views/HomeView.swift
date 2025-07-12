import SwiftUI
import AVFoundation
import Foundation
import Darwin

struct HomeView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @EnvironmentObject private var achievementViewModel: AchievementViewModel
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    @State private var showSearch = false
    @State private var showFilters = false
    @State private var isAnimating = false
    // Avatar floating animation state
    @State private var catPosition: CGPoint = CGPoint(x: 100, y: 200)
    @State private var dogPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 100, y: 140)
    @State private var foxPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 220)
    @State private var catTarget: CGPoint = CGPoint(x: 100, y: 200)
    @State private var dogTarget: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 100, y: 140)
    @State private var foxTarget: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 220)
    @State private var catAngle: Double = 0
    @State private var dogAngle: Double = 0
    @State private var foxAngle: Double = 0
    @State private var catBob: CGFloat = 0
    @State private var dogBob: CGFloat = 0
    @State private var foxBob: CGFloat = 0
    let avatarSize: CGFloat = 110
    let avatarFloatArea = UIScreen.main.bounds
    // Timer for floating animation
    @State private var avatarTimer: Timer? = nil
    @StateObject private var staticMotion = SplashMotionManager(parallax: .zero)
    @State private var floatingCat = HomeFloatingAstronaut(
        imageName: "clearIcon",
        position: CGPoint(x: 120, y: 120),
        velocity: CGVector(dx: 0.7, dy: 0.5),
        angle: 0,
        angleSpeed: 0.004,
        size: 80
    )
    @State private var floatingCatOscillation: Double = 0
    @State private var catSpeech: String? = nil
    @State private var showCatSpeech: Bool = false
    @State private var catAudioPlayer: AVAudioPlayer? = nil
    let catTips: [String] = [
        "Tip: Swipe right to save a scholarship!",
        "Fun Fact: Cats have been to space!",
        "Keep going, you're doing great!",
        "Need help? Tap the search icon.",
        "Remember to check deadlines!",
        "Your cat believes in you!",
        "Did you know? You can customize your cat avatar!",
        "Every swipe is a step closer to your dreams!",
        "You're a star in this scholarship galaxy!",
        "Stay pawsitive and keep exploring!",
        "Big opportunities start with small steps.",
        "Your future is as bright as the cosmos!",
        "Believe in yourself—your cat does!",
        "Scholarships are out there waiting for you!",
        "You've got this! One swipe at a time.",
        "Curiosity leads to discovery. Keep swiping!",
        "The universe rewards persistence.",
        "You're not alone—your cat is cheering for you!",
        "Let's make today a productive day!",
        "Meow-tivation: You can do it!"
    ]
    @State private var currentSwipeDirection: SwipeDirection? = nil
    
    // Level definitions for gamified progress tracker
    private let levels: [(min: Int, max: Int, name: String, emoji: String)] = [
        (0, 1, "Rookie Explorer", "🛰️"),         // 2 needed
        (2, 6, "Stellar Seeker", "🚀"),         // 5 needed
        (7, 16, "Rising Scholar", "🌟"),        // 10 needed
        (17, 34, "Comet Chaser", "☄️"),        // 18 needed
        (35, 59, "Orbit Achiever", "🪐"),      // 25 needed
        (60, 89, "Nebula Navigator", "🌌"),    // 30 needed
        (90, 129, "Galaxy Guru", "🌠"),        // 40 needed
        (130, 184, "Supernova Star", "💫"),    // 55 needed
        (185, 254, "Cosmic Captain", "👩‍🚀"),  // 70 needed
        (255, 339, "Legendary Voyager", "🏆"),  // 85 needed
        (340, 340, "Ultimate Scholar", "👑")    // All scholarships
    ]
    
    private func currentLevel(for count: Int) -> (level: Int, name: String, emoji: String, min: Int, max: Int) {
        for (i, level) in levels.enumerated() {
            if count >= level.min && count <= level.max {
                return (i+1, level.name, level.emoji, level.min, level.max)
            }
        }
        return (1, levels[0].name, levels[0].emoji, levels[0].min, levels[0].max)
    }
    
    @State private var showGalaxyMap: Bool = false
    
    @State private var showLevelConfetti: Bool = false
    @State private var justCompletedLevel: Bool = false
    
    @State private var displayedLevelInfo: (level: Int, name: String, emoji: String, min: Int, max: Int)? = nil
    @State private var displayedAppliedInLevel: Int? = nil
    
    init() {
        // Set the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Theme.backgroundColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        let appliedCount = viewModel.savedOpportunities.count
        let levelInfo = currentLevel(for: appliedCount)
        let scholarshipsForLevel = max(1, levelInfo.max - levelInfo.min + 1)
        let appliedInLevel = max(0, min(appliedCount - levelInfo.min, scholarshipsForLevel))
        let progress = Double(appliedInLevel) / Double(scholarshipsForLevel)
        let barWidth: CGFloat = 240
        // Use displayed values during level-up animation, else use current
        let showFrozen = justCompletedLevel && displayedLevelInfo != nil && displayedAppliedInLevel != nil
        let showLevel = showFrozen ? displayedLevelInfo!.level : levelInfo.level
        let showLevelName = showFrozen ? displayedLevelInfo!.name : levelInfo.name
        let showApplied = showFrozen ? displayedAppliedInLevel! : appliedInLevel
        let showProgress = showFrozen ? 1.0 : progress
        let showScholarshipsForLevel = showFrozen ? (displayedLevelInfo!.max - displayedLevelInfo!.min + 1) : scholarshipsForLevel
        ZStack {
            ScholarSplashBackgroundView(motion: staticMotion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .id("starfield")
            
            // Floating astronaut cat (user's pick)
            GeometryReader { geo in
                let screenHeight = geo.size.height
                let imageName: String = {
                    switch viewModel.userProfile?.avatarType {
                    case .luna: return "clearIcon"
                    case .nova: return "clearIcon2"
                    case .chill: return "clearIcon3"
                    default: return "clearIcon"
                    }
                }()
                ZStack {
                    // UFO base with NO flame
                    Image("ufo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: floatingCat.size * 2.0, height: floatingCat.size * 1.4)
                        .position(x: floatingCat.position.x, y: min(floatingCat.position.y, screenHeight * 0.22))
                        .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                        .rotationEffect(.radians(showCatSpeech ? 0 : sin(floatingCatOscillation) * 0.18))
                        .animation(.easeInOut(duration: 0.7), value: floatingCat.position)
                    // Cat avatar inside UFO, rotates with UFO
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: floatingCat.size * 0.68, height: floatingCat.size * 0.68)
                        .position(x: floatingCat.position.x, y: min(floatingCat.position.y, screenHeight * 0.22) - floatingCat.size * 0.36)
                        .rotationEffect(.radians(showCatSpeech ? 0 : sin(floatingCatOscillation) * 0.18))
                        .shadow(color: Color.white.opacity(0.18), radius: 8, x: 0, y: 2)
                        .animation(.easeInOut(duration: 0.7), value: floatingCat.position)
                    if let speech = catSpeech, showCatSpeech {
                        VStack(spacing: 0) {
                            Text(speech)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .fill(Color.white.opacity(0.92))
                                        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 2)
                                )
                                .overlay(
                                    CatSpeechBubbleTail()
                                        .fill(Color.white.opacity(0.92))
                                        .frame(width: 18, height: 10)
                                        .rotationEffect(.degrees(180))
                                        .offset(y: 8), alignment: .bottom
                                )
                                .opacity(showCatSpeech ? 1 : 0)
                                .transition(.opacity)
                        }
                        // Revert speech bubble to previous position
                        .position(x: floatingCat.position.x, y: min(floatingCat.position.y, screenHeight * 0.22) - floatingCat.size * 0.85)
                        .zIndex(2)
                    }
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                        let screen = UIScreen.main.bounds
                        let upperLimit = screen.height * 0.22
                        var cat = floatingCat
                        // Move
                        cat.position.x += cat.velocity.dx
                        cat.position.y += cat.velocity.dy
                        // Bounce off left/right edges
                        if cat.position.x < cat.size/2 || cat.position.x > screen.width - cat.size/2 {
                            cat.velocity.dx *= -1
                            cat.position.x = min(max(cat.size/2, cat.position.x), screen.width - cat.size/2)
                        }
                        // Bounce off top/upper half only
                        if cat.position.y < cat.size/2 {
                            cat.velocity.dy *= -1
                            cat.position.y = cat.size/2
                        } else if cat.position.y > upperLimit - cat.size/2 {
                            cat.velocity.dy *= -1
                            cat.position.y = upperLimit - cat.size/2
                        }
                        // Clamp cat's Y position if speech bubble is visible
                        if showCatSpeech {
                            let bubbleClearance = cat.size * 1.1 // adjust as needed
                            let minY = cat.size/2 + bubbleClearance
                            if cat.position.y < minY {
                                cat.position.y = minY
                            }
                        }
                        // Gentle angle rotation, but keep mostly upright
                        cat.angle += cat.angleSpeed
                        cat.angle = min(max(cat.angle, -0.2), 0.2)
                        // Always keep a slow, constant speed
                        let speed: Double = 0.28
                        let currentSpeed = sqrt(cat.velocity.dx * cat.velocity.dx + cat.velocity.dy * cat.velocity.dy)
                        if abs(currentSpeed - speed) > 0.01 {
                            // Normalize and set to fixed speed
                            let angle = atan2(cat.velocity.dy, cat.velocity.dx)
                            cat.velocity.dx = cos(Double(angle)) * speed
                            cat.velocity.dy = sin(Double(angle)) * speed
                        }
                        floatingCat = cat
                        floatingCatOscillation += 0.025
                    }
                    Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
                        catSpeech = catTips.randomElement()
                        withAnimation(.easeInOut(duration: 0.5)) { showCatSpeech = true }
                        playCatSoundAndHaptic()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                            withAnimation(.easeInOut(duration: 0.5)) { showCatSpeech = false }
                        }
                    }
                }
            }
            .zIndex(1)
            VStack {
                let allOpportunities = viewModel.createMixedOpportunityList()
                if currentIndex < allOpportunities.count {
                    OpportunityCardView(opportunity: allOpportunities[currentIndex], swipeDirection: currentSwipeDirection)
                        .frame(height: 420)
                        .offset(x: offset.width, y: 0)
                        .rotationEffect(.degrees(Double(offset.width / 20)))
                        .opacity(isAnimating ? 1 : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation
                                    if gesture.translation.width > 20 {
                                        currentSwipeDirection = .right
                                    } else if gesture.translation.width < -20 {
                                        currentSwipeDirection = .left
                                    } else {
                                        currentSwipeDirection = nil
                                    }
                                }
                                .onEnded { gesture in
                                    withAnimation(.spring()) {
                                        handleSwipe(gesture)
                                    }
                                    currentSwipeDirection = nil // Reset after swipe
                                }
                        )
                } else {
                    Image(systemName: "rocket.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(45))
                        .offset(y: -50)
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: true
                        )
                    Text("No more opportunities in your orbit!")
                        .font(Font.custom("SF Pro Rounded", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text("Try adjusting your filters or check back later")
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .zIndex(10)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: { showFilters = true }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                    // Notification bell button should remain here if present
                }
            }
            ToolbarItem(placement: .principal) {
                Button(action: { showGalaxyMap = true }) {
                    VStack(spacing: 2) {
                        // Disable animation on level change
                        Text("Level \(showLevel): \(showLevelName)")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.yellow)
                            .shadow(color: .purple.opacity(0.4), radius: 4, x: 0, y: 2)
                            .frame(height: 16)
                            .animation(nil, value: showLevel)
                        // Progress bar for current level with label centered
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color.white.opacity(0.12))
                                .frame(width: barWidth, height: 8)
                            RoundedRectangle(cornerRadius: 7)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: max(0, CGFloat(showProgress)) * barWidth, height: 8)
                                .animation(.easeInOut(duration: 0.5), value: appliedCount)
                            Text("Applied \(showApplied) / \(showScholarshipsForLevel) Opportunities")
                                .font(.system(size: 8.5, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.18), radius: 2, x: 0, y: 1)
                                .frame(width: barWidth, alignment: .center)
                        }
                        .overlay(
                            ZStack {
                                if showLevelConfetti {
                                    ConfettiView()
                                        .frame(width: barWidth, height: 40)
                                        .offset(y: -20)
                                        .transition(.opacity)
                                }
                            }, alignment: .top
                        )
                    }
                    .animation(nil, value: showLevel)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .sheet(isPresented: $showSearch) {
            SmartSearchView()
        }
        .sheet(isPresented: $showFilters) {
            OpportunityFilterView(isPresented: $showFilters)
        }
        .sheet(isPresented: $showGalaxyMap) {
            GalaxyMapView(levels: levels, currentLevel: levelInfo.level)
        }
        .onAppear {
            viewModel.updateDailyLoginStreak()
            viewModel.unlockStreakAchievementsIfNeeded(achievementViewModel: achievementViewModel)
            viewModel.updateMatchedOpportunities()
            withAnimation(.easeIn(duration: 0.3)) {
                isAnimating = true
            }
            // Start avatar floating animation
            startAvatarFloating()
        }
        .onDisappear {
            avatarTimer?.invalidate()
        }
        .onChange(of: appliedCount) { newValue in
            // Level completion animation logic
            let scholarshipsForLevel = max(1, levelInfo.max - levelInfo.min + 1)
            let appliedInLevel = max(0, min(newValue - levelInfo.min, scholarshipsForLevel))
            if appliedInLevel == scholarshipsForLevel && !justCompletedLevel {
                // Freeze display at full bar and current level
                displayedLevelInfo = levelInfo
                displayedAppliedInLevel = scholarshipsForLevel
                justCompletedLevel = true
                showLevelConfetti = true
                // Hide confetti and reset after 1 second, then update to next level
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showLevelConfetti = false
                    justCompletedLevel = false
                    displayedLevelInfo = nil
                    displayedAppliedInLevel = nil
                }
            }
        }
    }
    
    private func handleSwipe(_ gesture: DragGesture.Value) {
        let threshold: CGFloat = 50
        if abs(gesture.translation.width) > threshold {
            if gesture.translation.width > 0 {
                saveScholarship()
            } else {
                skipScholarship()
            }
        } else {
            withAnimation(.spring()) {
            offset = .zero
            }
        }
    }
    
    private func saveScholarship() {
        let allOpportunities = viewModel.createMixedOpportunityList()
        guard currentIndex < allOpportunities.count else { return }
        let opportunity = allOpportunities[currentIndex]
        viewModel.saveOpportunity(opportunity)
        isAnimating = false
        withAnimation(.spring()) {
            offset = CGSize(width: 500, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentIndex += 1
            offset = .zero
            isAnimating = true
        }
    }
    
    private func skipScholarship() {
        let allOpportunities = viewModel.createMixedOpportunityList()
        guard currentIndex < allOpportunities.count else { return }
        isAnimating = false
        withAnimation(.spring()) {
            offset = CGSize(width: -500, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentIndex += 1
            offset = .zero
            isAnimating = true
        }
    }
    
    private func startAvatarFloating() {
        // Set initial random targets
        catTarget = randomTarget()
        dogTarget = randomTarget()
        foxTarget = randomTarget()
        // Create a timer that updates the positions periodically
        avatarTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updateAvatarPositions()
        }
    }
    
    private func updateAvatarPositions() {
        // Helper: lerp
        func lerp(_ a: CGFloat, _ b: CGFloat, t: CGFloat) -> CGFloat {
            return a + (b - a) * t
        }
        func lerpPoint(_ a: CGPoint, _ b: CGPoint, t: CGFloat) -> CGPoint {
            CGPoint(x: lerp(a.x, b.x, t: t), y: lerp(a.y, b.y, t: t))
        }
        let lerpSpeed: CGFloat = 0.018
        let closeDist: CGFloat = 30
        let offscreenMargin: CGFloat = 80
        let area = avatarFloatArea
        // Cat
        catPosition = lerpPoint(catPosition, catTarget, t: lerpSpeed)
        catAngle += Double.random(in: -0.5...0.5)
        catBob = CGFloat(sin(Date().timeIntervalSince1970 * 0.8)) * 10
        if distance(catPosition, catTarget) < closeDist {
            catTarget = randomTarget()
        }
        if isFullyOffscreen(catPosition, margin: offscreenMargin) {
            catPosition = wrapToOpposite(catPosition)
            catTarget = randomTarget()
        }
        // Dog
        dogPosition = lerpPoint(dogPosition, dogTarget, t: lerpSpeed)
        dogAngle += Double.random(in: -0.5...0.5)
        dogBob = CGFloat(sin(Date().timeIntervalSince1970 * 0.9)) * 10
        if distance(dogPosition, dogTarget) < closeDist {
            dogTarget = randomTarget()
        }
        if isFullyOffscreen(dogPosition, margin: offscreenMargin) {
            dogPosition = wrapToOpposite(dogPosition)
            dogTarget = randomTarget()
        }
        // Fox
        foxPosition = lerpPoint(foxPosition, foxTarget, t: lerpSpeed)
        foxAngle += Double.random(in: -0.5...0.5)
        foxBob = CGFloat(sin(Date().timeIntervalSince1970 * 1.0)) * 10
        if distance(foxPosition, foxTarget) < closeDist {
            foxTarget = randomTarget()
        }
        if isFullyOffscreen(foxPosition, margin: offscreenMargin) {
            foxPosition = wrapToOpposite(foxPosition)
            foxTarget = randomTarget()
        }
    }
    
    private func randomTarget() -> CGPoint {
        // Sometimes pick a point offscreen
        let area = avatarFloatArea
        let margin: CGFloat = 80
        let offscreenChance = 0.25
        let isOffscreen = Double.random(in: 0...1) < offscreenChance
        let x: CGFloat
        let y: CGFloat
        if isOffscreen {
            // Pick a random edge
            switch Int.random(in: 0...3) {
            case 0: // left
                x = -margin
                y = CGFloat.random(in: 0...(area.height))
            case 1: // right
                x = area.width + margin
                y = CGFloat.random(in: 0...(area.height))
            case 2: // top
                x = CGFloat.random(in: 0...(area.width))
                y = -margin
            default: // bottom
                x = CGFloat.random(in: 0...(area.width))
                y = area.height + margin
            }
        } else {
            x = CGFloat.random(in: margin...(area.width - margin))
            y = CGFloat.random(in: margin...(area.height - margin))
        }
        return CGPoint(x: x, y: y)
    }
    
    private func isFullyOffscreen(_ point: CGPoint, margin: CGFloat) -> Bool {
        let area = avatarFloatArea
        return point.x < -margin || point.x > area.width + margin || point.y < -margin || point.y > area.height + margin
    }
    
    private func wrapToOpposite(_ point: CGPoint) -> CGPoint {
        let area = avatarFloatArea
        var x = point.x
        var y = point.y
        if x < 0 { x = area.width }
        else if x > area.width { x = 0 }
        if y < 0 { y = area.height }
        else if y > area.height { y = 0 }
        return CGPoint(x: x, y: y)
    }
    
    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx*dx + dy*dy)
    }
    
    private func playCatSoundAndHaptic() {
        let sounds = ["meow1", "purr1", "jingle1"]
        if let soundName = sounds.randomElement(), let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                catAudioPlayer = try AVAudioPlayer(contentsOf: url)
                catAudioPlayer?.volume = 0.8
                catAudioPlayer?.play()
            } catch {
                print("Failed to play cat sound: \(error)")
            }
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// Add struct for floating astronaut at the bottom
struct HomeFloatingAstronaut {
    var imageName: String
    var position: CGPoint
    var velocity: CGVector
    var angle: Double
    var angleSpeed: Double
    var size: CGFloat
}

// Add a simple triangle shape for the speech bubble tail
struct CatSpeechBubbleTail: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// Add enum for swipe result at the top (outside HomeView)
enum SwipeResult {
    case right, left
}

#Preview {
    HomeView()
        .environmentObject(AppViewModel())
        .environmentObject(AchievementViewModel())
} 
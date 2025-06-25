import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @EnvironmentObject private var achievementViewModel: AchievementViewModel
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    @State private var showSearch = false
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
        ZStack {
            ScholarSplashBackgroundView(motion: staticMotion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .id("starfield")
            // Animated astronaut avatars (floating)
            AstronautCatView(size: avatarSize)
                .position(catPosition)
                .rotationEffect(.degrees(catAngle))
                .offset(y: catBob)
                .animation(.easeInOut(duration: 2.2), value: catPosition)
                .animation(.easeInOut(duration: 2.2), value: catAngle)
                .animation(.easeInOut(duration: 2.2), value: catBob)
            AstronautDogView(size: avatarSize)
                .position(dogPosition)
                .rotationEffect(.degrees(dogAngle))
                .offset(y: dogBob)
                .animation(.easeInOut(duration: 2.5), value: dogPosition)
                .animation(.easeInOut(duration: 2.5), value: dogAngle)
                .animation(.easeInOut(duration: 2.5), value: dogBob)
            AstronautFoxView(size: avatarSize)
                .position(foxPosition)
                .rotationEffect(.degrees(foxAngle))
                .offset(y: foxBob)
                .animation(.easeInOut(duration: 2.8), value: foxPosition)
                .animation(.easeInOut(duration: 2.8), value: foxAngle)
                .animation(.easeInOut(duration: 2.8), value: foxBob)
            VStack {
                if currentIndex < viewModel.scholarships.count {
                    ScholarshipCardView(scholarship: viewModel.scholarships[currentIndex])
                        .frame(height: 420)
                        .offset(x: offset.width, y: 0)
                        .rotationEffect(.degrees(Double(offset.width / 20)))
                        .opacity(isAnimating ? 1 : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation
                                }
                                .onEnded { gesture in
                                    withAnimation(.spring()) {
                                        handleSwipe(gesture)
                                    }
                                }
                        )
                } else {
                    VStack(spacing: 20) {
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
                        Text("No more scholarships in your orbit!")
                            .font(Font.custom("SF Pro Rounded", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("Check back later for new opportunities")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding()
                }
            }
            
            // Action buttons
            VStack {
                Spacer()
                HStack(spacing: 40) {
                    Button(action: { 
                        withAnimation(.spring()) {
                            skipScholarship()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Theme.errorColor)
                    }
                    
                    Button(action: { 
                        withAnimation(.spring()) {
                            saveScholarship()
                        }
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Theme.successColor)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Notifications")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                HStack(spacing: 20) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: { showSearch = true }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: SmartFiltersView()) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    NavigationLink(destination: FinancialPlanningView()) {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: ScholarshipStatsView()) {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: SavedScholarshipsView()) {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: AchievementsView()) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: NotificationsView()) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 20))
                        .foregroundColor(.white)
                    }
                    
                    NavigationLink(destination: AvatarGridPageView()) {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showSearch) {
            SmartSearchView()
        }
        .onAppear {
            viewModel.updateDailyLoginStreak()
            viewModel.unlockStreakAchievementsIfNeeded(achievementViewModel: achievementViewModel)
            withAnimation(.easeIn(duration: 0.3)) {
                isAnimating = true
            }
            // Start avatar floating animation
            startAvatarFloating()
        }
        .onDisappear {
            avatarTimer?.invalidate()
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
        guard currentIndex < viewModel.scholarships.count else { return }
        viewModel.saveScholarship(viewModel.scholarships[currentIndex])
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
        guard currentIndex < viewModel.scholarships.count else { return }
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
}

#Preview {
    HomeView()
        .environmentObject(AppViewModel())
        .environmentObject(AchievementViewModel())
} 
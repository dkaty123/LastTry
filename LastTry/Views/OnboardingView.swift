import SwiftUI

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
    @EnvironmentObject private var viewModel: AppViewModel
    
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
            // Background
            Theme.primaryGradient
                .ignoresSafeArea()
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Next/Get Started button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                            showProfileSetup = true
                    }
                }) {
                    Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(pages[currentPage].accentColor)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .fullScreenCover(isPresented: $showProfileSetup) {
            ProfileSetupView()
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

// MARK: - Onboarding Page View
struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 30) {
            // Icon
                Image(systemName: page.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
            
            VStack(spacing: 15) {
                // Title
                Text(page.title)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Description
                Text(page.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppViewModel())
} 
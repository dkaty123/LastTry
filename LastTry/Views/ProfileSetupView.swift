import SwiftUI
import UIKit

// MARK: - Profile Particle System
struct ProfileParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var opacity: Double
    var rotation: Double
}

struct ProfileParticleSystem: View {
    let particles: [ProfileParticle]
    
    var body: some View {
        ForEach(particles) { particle in
            Circle()
                .fill(particle.color)
                .frame(width: particle.size, height: particle.size)
                .position(particle.position)
                .opacity(particle.opacity)
                .rotationEffect(.degrees(particle.rotation))
        }
    }
}

class ProfileParticleManager: ObservableObject {
    @Published var particles: [ProfileParticle] = []
    private var timer: Timer?
    
    func startParticleSystem(color: Color) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.particles.count > 30 {
                self.particles.removeFirst()
            }
            
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            let particle = ProfileParticle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: CGFloat.random(in: 0...screenHeight)
                ),
                size: CGFloat.random(in: 2...6),
                color: color.opacity(Double.random(in: 0.3...0.8)),
                opacity: 1.0,
                rotation: Double.random(in: 0...360)
            )
            
            self.particles.append(particle)
            
            withAnimation(.easeOut(duration: 1.0)) {
                if let index = self.particles.firstIndex(where: { $0.id == particle.id }) {
                    self.particles[index].opacity = 0
                    self.particles[index].position.y += 50
                    self.particles[index].rotation += 180
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

struct ProfileSetupView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var gender = ""
    @State private var ethnicity = ""
    @State private var fieldOfStudy = ""
    @State private var gradeLevel = ""
    @State private var gpa = ""
    @State private var selectedAvatar: String = "clearIcon"
    @State private var showHome = false
    @State private var currentStep = 0
    @State private var showConfetti = false
    @State private var showAchievement = false
    let isOnboarding: Bool
    @StateObject private var motion = SplashMotionManager()
    
    init(isOnboarding: Bool = false) {
        self.isOnboarding = isOnboarding
    }
    
    private let gradeLevels = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate"]
    private let steps = ["Avatar", "Basic Info", "Education"]
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            // (Rocketship and star removed)
            VStack(spacing: 45) {
                // Progress indicator
                HStack(spacing: 20) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        ZStack {
                            Circle()
                                .fill(currentStep >= index ? Theme.accentColor : Theme.cardBackground)
                                .frame(width: 40, height: 40)
                            
                            Image(systemName: iconForStep(index))
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                }
                .padding(.top)
                
                // Step title
                Text(stepTitle(for: currentStep))
                    .font(Font.custom("SF Pro Rounded", size: 24).weight(.bold))
                    .foregroundColor(.white)
                // Onboarding-style image card below title, per step
                OnboardingProfileImageCard(step: currentStep)
                
                TabView(selection: $currentStep) {
                    avatarSelectionView
                        .tag(0)
                    basicInfoView
                        .tag(1)
                    educationView
                        .tag(2)
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // (No nextButton image on the last page; navigation is via swipe)
            }
        }
        .fullScreenCover(isPresented: $showHome) {
            if isOnboarding {
                HomeView()
            }
        }
        .overlay(
            ProfileConfettiView()
                .opacity(showConfetti ? 1 : 0)
        )
        .overlay(
            Group {
                if showAchievement {
                    CuteAchievementBadgeView(
                        title: "Profile Complete!",
                        icon: "checkmark.circle.fill",
                        color: Theme.successColor
                    )
                }
            }
        )
    }
    
    private var avatarSelectionView: some View {
        let avatarNames = [
            "clearIcon": "Luna",
            "clearIcon2": "Nova",
            "clearIcon3": "Chill"
        ]
        let avatarFacts = [
            "clearIcon": "Loves to explore new scholarships!",
            "clearIcon2": "Has visited every planet in the galaxy!",
            "clearIcon3": "Can nap in zero gravity."
        ]
        return Group {
            VStack(spacing: 10) {
                Text("Meet Your Crew")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                    .shadow(color: .purple.opacity(0.3), radius: 5, x: 0, y: 2)
                Text("Pick your favorite space cat!")
                    .font(.body.weight(.bold))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                HStack(spacing: 14) {
                    ForEach(["clearIcon", "clearIcon2", "clearIcon3"], id: \.self) { avatar in
                        ZStack {
                            // 3D, shiny, glassy card
                            RoundedRectangle(cornerRadius: 22)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pink.opacity(0.32), Color.purple.opacity(0.32)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                // Bright white border
                                .overlay(
                                    RoundedRectangle(cornerRadius: 22)
                                        .stroke(Color.white.opacity(0.95), lineWidth: 3.5)
                                )
                                // Thin black border just inside
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black.opacity(0.18), lineWidth: 1.2)
                                        .padding(2)
                                )
                                // Subtle dark drop shadow for 3D pop
                                .shadow(color: .black.opacity(0.25), radius: 18, x: 0, y: 8)
                                .frame(width: 98, height: 120)
                            VStack(spacing: 0) {
                                Spacer(minLength: 0)
                                Image(avatar)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: avatar == "clearIcon2" ? 94 : 76, height: avatar == "clearIcon2" ? 94 : 76)
                                    .scaleEffect(selectedAvatar == avatar ? 1.15 : 1.0)
                                    .shadow(color: selectedAvatar == avatar ? .yellow : .clear, radius: 10)
                                    .animation(.spring(), value: selectedAvatar)
                                Spacer(minLength: 0)
                                Text(avatarNames[avatar] ?? "")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 8)
                        }
                            .frame(height: 120, alignment: .top)
                    }
                    .onTapGesture {
                            withAnimation(.spring()) { selectedAvatar = avatar }
                    }
                }
            }
                .padding(.horizontal, 8)
        }
            .padding(.bottom, 110)
        }
    }
    
    private var basicInfoView: some View {
        VStack(spacing: 20) {
            VStack(spacing: 15) {
                FormField(title: "Name", text: $name)
                // Gender Picker
                VStack(alignment: .leading, spacing: 6) {
                    Text("Gender")
                        .foregroundColor(.white)
                        .font(.body)
                    Picker("Gender", selection: $gender) {
                        ForEach(["", "Male", "Female", "Non-binary", "Prefer not to say"], id: \.self) { option in
                            Text(option.isEmpty ? "Select Gender" : option).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(12)
                }
                // Ethnicity Picker
                VStack(alignment: .leading, spacing: 6) {
                    Text("Ethnicity")
                        .foregroundColor(.white)
                        .font(.body)
                    Picker("Ethnicity", selection: $ethnicity) {
                        ForEach(["", "Asian", "Black or African American", "Hispanic or Latino", "Native American", "White", "Other", "Prefer not to say"], id: \.self) { option in
                            Text(option.isEmpty ? "Select Ethnicity" : option).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Theme.cardBackground.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Theme.accentColor.opacity(0.3), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 100)
    }
    
    private var educationView: some View {
        ZStack(alignment: .bottom) {
        VStack(spacing: 20) {
                VStack(spacing: 15) {
                    // Field of Study Picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Field of Study")
                .foregroundColor(.white)
                            .font(.body)
                        Picker("Field of Study", selection: $fieldOfStudy) {
                            ForEach(["", "Engineering", "Business", "Arts", "Science", "Education", "Health", "Law", "Other"], id: \.self) { option in
                                Text(option.isEmpty ? "Select Field of Study" : option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(12)
                    }
                    // Grade Level Picker
                    VStack(alignment: .leading, spacing: 6) {
                    Text("Grade Level")
                        .foregroundColor(.white)
                            .font(.body)
                    Picker("Grade Level", selection: $gradeLevel) {
                            ForEach(["", "Freshman", "Sophomore", "Junior", "Senior", "Graduate"], id: \.self) { option in
                                Text(option.isEmpty ? "Select Grade Level" : option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(12)
                    }
                    // GPA Picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text("GPA (Optional)")
                            .foregroundColor(.white)
                            .font(.body)
                        Picker("GPA", selection: $gpa) {
                            ForEach(["", "4.0", "3.5-3.9", "3.0-3.4", "2.5-2.9", "Below 2.5"], id: \.self) { option in
                                Text(option.isEmpty ? "Select GPA" : option).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Theme.cardBackground.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Theme.accentColor.opacity(0.3), lineWidth: 1)
                    )
            )
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 100)
            // Show nextButton image only on the third page
            if currentStep == 2 {
                Button(action: handleNext) {
                    Image("nextButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 72)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 20)
                        .opacity(0.98)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private func handleNext() {
        if currentStep < steps.count - 1 {
            withAnimation {
                currentStep += 1
            }
        } else {
            saveProfile()
        }
    }
    
    private func saveProfile() {
        let avatarType: UserProfile.AvatarType
        switch selectedAvatar {
        case "clearIcon": avatarType = .luna
        case "clearIcon2": avatarType = .nova
        case "clearIcon3": avatarType = .chill
        default: avatarType = .luna
        }
        let profile = UserProfile(
            name: name,
            gender: gender,
            ethnicity: ethnicity,
            fieldOfStudy: fieldOfStudy,
            gradeLevel: gradeLevel,
            gpa: Double(gpa),
            avatarType: avatarType
        )
        UserProfile.save(profile)
        viewModel.userProfile = profile
        viewModel.completeOnboarding()
        viewModel.updateMatchedScholarships()
        showConfetti = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if isOnboarding {
                showHome = true
            } else {
                dismiss()
            }
        }
    }
    
    private func stepTitle(for step: Int) -> String {
        switch step {
        case 0: return "Avatar"
        case 1: return "Basic Info"
        case 2: return "Education"
        default: return ""
        }
    }
    
    private func iconForStep(_ step: Int) -> String {
        switch step {
        case 0:
            return "person.circle.fill"
        case 1:
            return "info.circle.fill"
        case 2:
            return "graduationcap.circle.fill"
        default:
            return "circle.fill"
        }
    }
}

struct FormField: View {
    let title: String
    @Binding var text: String
    @State private var isFocused = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .foregroundColor(.white)
                .font(.body)
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.08))
                    .frame(height: 38)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFocused ? Theme.accentColor : Color.white.opacity(0.18), lineWidth: isFocused ? 2 : 1)
                    )
                TextField("", text: $text, onEditingChanged: { editing in
                    isFocused = editing
                })
                .frame(height: 38)
                .padding(.horizontal, 10)
                .foregroundColor(.white)
                .font(.body)
                .accentColor(Theme.accentColor)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            }
        }
    }
}

// Confetti animation view
struct ProfileConfettiView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<50) { index in
                Circle()
                    .fill([
                        Theme.accentColor,
                        Theme.successColor,
                        .white,
                        .blue,
                        .purple
                    ][index % 5])
                    .frame(width: 8, height: 8)
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isAnimating ? geometry.size.height + 100 : -100
                    )
                    .opacity(isAnimating ? 0 : 1)
                    .animation(
                        Animation.linear(duration: Double.random(in: 1...2))
                            .repeatCount(1)
                            .delay(Double.random(in: 0...0.5)),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// Add this helper for glassmorphic blur
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Onboarding-style Profile Image Card
struct OnboardingProfileImageCard: View {
    let step: Int
    @State private var imagePulse = false
    @State private var showContent = false
    var imageName: String {
        switch step {
        case 0: return "profile1"
        case 1: return "profile2"
        case 2: return "profile3"
        default: return "profile1"
        }
    }
    var body: some View {
        let logoCardSize: CGFloat = 160
        ZStack {
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.purple,
                            Color.pink
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
                        // Main image in the center
                        Image(imageName)
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
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.7)) {
                showContent = true
            }
        }
    }
}

#Preview {
    ProfileSetupView()
        .environmentObject(AppViewModel())
} 
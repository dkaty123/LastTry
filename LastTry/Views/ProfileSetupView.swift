import SwiftUI

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
    @State private var name = ""
    @State private var gender = ""
    @State private var ethnicity = ""
    @State private var fieldOfStudy = ""
    @State private var gradeLevel = ""
    @State private var gpa = ""
    @State private var selectedAvatar: UserProfile.AvatarType = .cat
    @State private var showHome = false
    @State private var currentStep = 0
    @State private var showConfetti = false
    @State private var showAchievement = false
    
    private let gradeLevels = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate"]
    private let steps = ["Avatar", "Basic Info", "Education"]
    
    var body: some View {
        ZStack {
            // Background
            Theme.primaryGradient
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
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
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                TabView(selection: $currentStep) {
                    // Avatar Selection
                                avatarSelectionView
                        .tag(0)
                    
                    // Basic Information
                                basicInfoView
                        .tag(1)
                    
                    // Education Details
                                educationView
                        .tag(2)
                        }
                .tabViewStyle(.page(indexDisplayMode: .never))
                        
                        // Navigation Buttons
                        HStack(spacing: 20) {
                            if currentStep > 0 {
                                Button(action: { withAnimation { currentStep -= 1 } }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    Text("Back")
                            }
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Theme.cardBackground)
                            )
                                }
                            }
                            
                            Button(action: handleNext) {
                        HStack {
                                Text(currentStep < steps.count - 1 ? "Next" : "Launch Profile")
                            if currentStep < steps.count - 1 {
                                Image(systemName: "chevron.right")
                            } else {
                                Image(systemName: "rocket.fill")
                            }
                        }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Theme.accentColor)
                        )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
        }
        .fullScreenCover(isPresented: $showHome) {
            HomeView()
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
        VStack(spacing: 20) {
            Text("Choose Your Space Explorer")
                .font(.title2.bold())
                .foregroundColor(.white)
                .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
            
            HStack(spacing: 20) {
                ForEach([UserProfile.AvatarType.cat, .dog, .bunny], id: \.self) { avatar in
                    AvatarButton(
                        avatar: avatar,
                        isSelected: selectedAvatar == avatar,
                        action: { withAnimation { selectedAvatar = avatar } }
                    )
                    .scaleEffect(selectedAvatar == avatar ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3), value: selectedAvatar)
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
        }
    }
    
    private var basicInfoView: some View {
        VStack(spacing: 20) {
            Text("Basic Information")
                .font(.title2.bold())
                .foregroundColor(.white)
                .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
            
            VStack(spacing: 15) {
                FormField(title: "Name", text: $name)
                FormField(title: "Gender", text: $gender)
                FormField(title: "Ethnicity", text: $ethnicity)
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
        }
    }
    
    private var educationView: some View {
        VStack(spacing: 20) {
            Text("Education Details")
                .font(.title2.bold())
                .foregroundColor(.white)
                .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
            
            VStack(spacing: 15) {
                FormField(title: "Field of Study", text: $fieldOfStudy)
                
                VStack(alignment: .leading) {
                    Text("Grade Level")
                        .foregroundColor(.white)
                    Picker("Grade Level", selection: $gradeLevel) {
                        ForEach(gradeLevels, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }
                    .pickerStyle(.menu)
                    .background(Theme.cardBackground)
                    .cornerRadius(10)
                }
                
                FormField(title: "GPA (Optional)", text: $gpa)
                    .keyboardType(.decimalPad)
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
        let profile = UserProfile(
            name: name,
            gender: gender,
            ethnicity: ethnicity,
            fieldOfStudy: fieldOfStudy,
            gradeLevel: gradeLevel,
            gpa: Double(gpa),
            avatarType: selectedAvatar
        )
        
        UserProfile.save(profile)
        viewModel.userProfile = profile
        viewModel.completeOnboarding()
        showConfetti = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        showHome = true
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
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
            
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Theme.cardBackground)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? Theme.accentColor : Color.clear, lineWidth: 1)
                )
                .onTapGesture {
                    isFocused = true
                }
        }
    }
}

struct AvatarButton: View {
    let avatar: UserProfile.AvatarType
    let isSelected: Bool
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            VStack {
            Image(systemName: avatarIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .padding()
                    .background(
                        ZStack {
                            Theme.cardBackground
                            
                            if isSelected {
                                Circle()
                                    .fill(Theme.accentColor.opacity(0.3))
                                    .scaleEffect(isHovered ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3), value: isHovered)
                            }
                        }
                    )
                    .clipShape(Circle())
                .overlay(
                        Circle()
                        .stroke(isSelected ? Theme.accentColor : Color.clear, lineWidth: 2)
                )
                .shadow(color: isSelected ? Theme.accentColor.opacity(0.5) : Color.clear,
                       radius: 10, x: 0, y: 5)
            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
    
    private var avatarIcon: String {
        switch avatar {
        case .cat: return "cat.fill"
        case .bear: return "bear.fill"
        case .bunny: return "hare.fill"
        case .dog: return "dog.fill"
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

#Preview {
    ProfileSetupView()
        .environmentObject(AppViewModel())
} 
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var showEditProfile = false
    @State private var showSettings = false
    @StateObject private var motion = SplashMotionManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Starry background
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Hero Section with Avatar
                        VStack(spacing: 25) {
                            // Floating Avatar without Animation
                            ZStack {
                                // Glowing background circle
                                Circle()
                                    .fill(
                                        RadialGradient(
                                            colors: [
                                                Theme.accentColor.opacity(0.4),
                                                Theme.accentColor.opacity(0.1),
                                                Color.clear
                                            ],
                                            center: .center,
                                            startRadius: 20,
                                            endRadius: 80
                                        )
                                    )
                                    .frame(width: 180, height: 180)
                                
                                // Main avatar circle
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Theme.cardBackground,
                                                Theme.cardBackground.opacity(0.8)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 160, height: 160)
                                    .overlay(
                                        Circle()
                                            .stroke(
                                                LinearGradient(
                                                    colors: [Theme.accentColor, Theme.accentColor.opacity(0.5)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 3
                                            )
                                    )
                                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 20, x: 0, y: 10)
                                
                                // Avatar Image
                                Group {
                                    if let avatarType = viewModel.userProfile?.avatarType {
                                        Group {
                                            if avatarType == .luna {
                                                Image("clearIcon")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                            } else if avatarType == .nova {
                                                Image("clearIcon2")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                            } else if avatarType == .chill {
                                                Image("clearIcon3")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                            }
                                        }
                                    } else {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(Theme.accentColor)
                                    }
                                }
                            }
                            
                            // Name with cosmic styling
                            VStack(spacing: 8) {
                                Text(viewModel.userProfile?.name ?? "Space Explorer")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                                
                                Text("Scholarship Navigator")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 30)
                        
                        // Enhanced Stats Cards
                        HStack(spacing: 20) {
                            EnhancedProfileStatCard(
                                title: "Saved",
                                value: "\(viewModel.savedScholarships.count)",
                                icon: "bookmark.fill",
                                color: Theme.accentColor
                            )
                            
                            EnhancedProfileStatCard(
                                title: "Applied",
                                value: "0",
                                icon: "paperplane.fill",
                                color: Theme.successColor
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Profile Info Card
                        VStack(spacing: 0) {
                            // Card Header
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(Theme.accentColor)
                                    .font(.title2)
                                
                                Text("Profile Information")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Theme.accentColor.opacity(0.2),
                                        Theme.accentColor.opacity(0.1)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            
                            // Profile Details
                            VStack(spacing: 0) {
                                EnhancedProfileInfoRow(
                                    title: "Field of Study",
                                    value: viewModel.userProfile?.fieldOfStudy ?? "Not set",
                                    icon: "graduationcap.fill"
                                )
                                
                                Divider()
                                    .background(Color.white.opacity(0.2))
                                
                                EnhancedProfileInfoRow(
                                    title: "Grade Level",
                                    value: viewModel.userProfile?.gradeLevel ?? "Not set",
                                    icon: "star.fill"
                                )
                                
                                if let gpa = viewModel.userProfile?.gpa {
                                    Divider()
                                        .background(Color.white.opacity(0.2))
                                    
                                    EnhancedProfileInfoRow(
                                        title: "GPA",
                                        value: String(format: "%.2f", gpa),
                                        icon: "chart.line.uptrend.xyaxis"
                                    )
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Theme.cardBackground.opacity(0.8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .shadow(color: Theme.accentColor.opacity(0.2), radius: 15, x: 0, y: 8)
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        
                        // Action Buttons
                        VStack(spacing: 15) {
                            // Edit Profile Button
                            Button(action: { showEditProfile = true }) {
                                HStack {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.title2)
                                    Text("Edit Profile")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        colors: [Theme.accentColor, Theme.accentColor.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Theme.accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
                            }
                            
                            // Soundtrack Toggle
                            HStack {
                                Image(systemName: "music.note")
                                    .foregroundColor(Theme.accentColor)
                                    .font(.title3)
                                
                                Text("Cosmic Soundtrack")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Toggle("", isOn: $viewModel.soundtrackEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: Theme.accentColor))
                                    .scaleEffect(0.9)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Theme.cardBackground.opacity(0.6))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Theme.cardBorder.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Theme.cardBackground.opacity(0.6))
                                    .overlay(
                                        Circle()
                                            .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                }
            }
            .sheet(isPresented: $showEditProfile) {
                ProfileSetupView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

struct EnhancedProfileStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            // Icon without animation
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(color)
            
            // Value
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            // Title
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(color.opacity(0.3), lineWidth: 2)
                )
        )
        .shadow(color: color.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct EnhancedProfileInfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Theme.accentColor)
                .frame(width: 20)
            
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
} 
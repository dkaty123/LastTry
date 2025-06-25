import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var showEditProfile = false
    @State private var showSettings = false
    @StateObject private var motion = SplashMotionManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                ScrollView {
                    VStack(spacing: 30) {
                        // Avatar and Name
                        VStack(spacing: 15) {
                            ZStack {
                                Circle()
                                    .fill(Theme.accentColor.opacity(0.3))
                                    .frame(width: 140, height: 140)
                                
                                Group {
                                    if let avatarType = viewModel.userProfile?.avatarType {
                                        Group {
                                            if avatarType == .cat {
                                                AstronautCatView(size: 120)
                                            } else if avatarType == .fox {
                                                AstronautFoxView(size: 120)
                                            } else if avatarType == .dog {
                                                AstronautDogView(size: 120)
                                            }
                                        }
                                    } else {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(Color(white: 1.0))
                                    }
                                }
                            }
                            
                            Text(viewModel.userProfile?.name ?? "Space Explorer")
                                .font(Font.custom("SF Pro Rounded", size: 28).weight(.bold))
                                .foregroundColor(Color(white: 1.0))
                        }
                        .padding(.top)
                        
                        // Stats Cards
                        HStack(spacing: 20) {
                            ProfileStatCard(title: "Saved", value: "\(viewModel.savedScholarships.count)")
                            
                            ProfileStatCard(title: "Applied", value: "0")
                        }
                        .padding(.horizontal)
                        
                        // Profile Info
                        VStack(spacing: 20) {
                            ProfileInfoRow(title: "Field of Study", value: viewModel.userProfile?.fieldOfStudy ?? "Not set")
                            ProfileInfoRow(title: "Grade Level", value: viewModel.userProfile?.gradeLevel ?? "Not set")
                            if let gpa = viewModel.userProfile?.gpa {
                                ProfileInfoRow(title: "GPA", value: String(format: "%.2f", gpa))
                            }
                        }
                        .padding()
                        .background(Theme.cardBackground)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        
                        // Edit Profile Button
                        Button(action: { showEditProfile = true }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .foregroundColor(Color(white: 1.0))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.accentColor)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(Text("Profile")
                .font(Font.custom("SF Pro Rounded", size: 24).weight(.bold)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color(white: 1.0))
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

struct ProfileStatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color(white: 1.0, opacity: 0.8))
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(white: 1.0))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.cardBackground.opacity(0.3))
        .cornerRadius(15)
    }
}

struct ProfileInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(white: 1.0, opacity: 0.8))
            Spacer()
            Text(value)
                .foregroundColor(Color(white: 1.0))
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
} 
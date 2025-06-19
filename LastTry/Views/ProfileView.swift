import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var showEditProfile = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Avatar and Name
                        VStack(spacing: 15) {
                            Image(systemName: avatarIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .padding()
                                .background(Theme.accentColor.opacity(0.3))
                                .clipShape(Circle())
                            
                            Text(viewModel.userProfile?.name ?? "Space Explorer")
                                .font(.title2.bold())
                                .foregroundColor(.white)
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
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.accentColor)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
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
    
    private var avatarIcon: String {
        switch viewModel.userProfile?.avatarType {
        case .cat: return "cat.fill"
        case .bear: return "bear.fill"
        case .bunny: return "hare.fill"
        case .dog: return "dog.fill"
        case .none: return "person.fill"
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
                .foregroundColor(.white.opacity(0.8))
            
            Text(value)
                .font(.title2.bold())
                .foregroundColor(.white)
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
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            Text(value)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppViewModel())
} 
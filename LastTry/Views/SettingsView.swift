import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showResetAlert = false
    @State private var showClearAlert = false
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
                    VStack(spacing: 20) {
                        // Profile Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Profile")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            NavigationLink(destination: ProfileSetupView()) {
                                SettingsRow(
                                    icon: "person.fill",
                                    title: "Edit Profile",
                                    subtitle: "Update your personal information",
                                    color: Theme.accentColor
                                )
                            }
                        }
                        
                        // App Management Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("App Management")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            Button(action: { showResetAlert = true }) {
                                SettingsRow(
                                    icon: "arrow.counterclockwise",
                                    title: "Reset Onboarding",
                                    subtitle: "Restart the onboarding experience",
                                    color: Theme.errorColor
                                )
                            }
                            
                            Button(action: { showClearAlert = true }) {
                                SettingsRow(
                                    icon: "trash.fill",
                                    title: "Clear Saved Scholarships",
                                    subtitle: "Remove all saved scholarships",
                                    color: Theme.errorColor
                                )
                            }
                        }
                        
                        // Legal Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Legal")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            Link(destination: URL(string: "https://example.com/privacy")!) {
                                SettingsRow(
                                    icon: "lock.fill",
                                    title: "Privacy Policy",
                                    subtitle: "How we protect your data",
                                    color: Theme.accentColor
                                )
                            }
                            
                            Link(destination: URL(string: "https://example.com/terms")!) {
                                SettingsRow(
                                    icon: "doc.text.fill",
                                    title: "Terms of Service",
                                    subtitle: "App usage terms and conditions",
                                    color: Theme.accentColor
                                )
                            }
                        }
                        
                        // Version Info
                        VStack(spacing: 8) {
                            Text("Version 1.0.0")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text("Cosmic Scholarship Navigator")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
            }
            .alert("Reset Onboarding", isPresented: $showResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    viewModel.resetOnboarding()
                    dismiss()
                }
            } message: {
                Text("This will reset the onboarding experience. Your profile and saved scholarships will remain unchanged.")
            }
            .alert("Clear Saved Scholarships", isPresented: $showClearAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    viewModel.clearSavedScholarships()
                }
            } message: {
                Text("Are you sure you want to clear all saved scholarships? This action cannot be undone.")
            }
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon with background
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(color)
            }
            
            // Text content
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            
            // Chevron for navigation
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.4))
                .frame(width: 20)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.2), lineWidth: 1)
                )
        )
        .shadow(color: color.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppViewModel())
} 
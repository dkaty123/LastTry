import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showResetAlert = false
    @State private var showClearAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                List {
                    Section {
                        NavigationLink(destination: ProfileSetupView()) {
                            SettingsRow(
                                icon: "person.fill",
                                title: "Edit Profile",
                                color: Theme.accentColor
                            )
                        }
                    }
                    
                    Section {
                        Button(action: { showResetAlert = true }) {
                            SettingsRow(
                                icon: "arrow.counterclockwise",
                                title: "Reset Onboarding",
                                color: Theme.errorColor
                            )
                        }
                        
                        Button(action: { showClearAlert = true }) {
                            SettingsRow(
                                icon: "trash.fill",
                                title: "Clear Saved Scholarships",
                                color: Theme.errorColor
                            )
                        }
                    }
                    
                    Section {
                        Link(destination: URL(string: "https://example.com/privacy")!) {
                            SettingsRow(
                                icon: "lock.fill",
                                title: "Privacy Policy",
                                color: Theme.accentColor
                            )
                        }
                        
                        Link(destination: URL(string: "https://example.com/terms")!) {
                            SettingsRow(
                                icon: "doc.text.fill",
                                title: "Terms of Service",
                                color: Theme.accentColor
                            )
                        }
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Text("Version 1.0.0")
                                .foregroundColor(.white.opacity(0.6))
                            Spacer()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
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
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppViewModel())
} 
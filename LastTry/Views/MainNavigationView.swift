import SwiftUI

struct MainNavigationView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var selectedTab = 0
    @State private var showSearch = false
    @State private var showNotifications = false
    @State private var showSplash = true
    
    init() {
        // Remove tab bar appearance configuration since we're using custom nav bar
    }
    
    var body: some View {
        Group {
            if showSplash {
                ScholarSwiperSplashView(onLaunch: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showSplash = false
                    }
                })
            } else if !viewModel.hasCompletedOnboarding {
                OnboardingView()
            } else {
                mainAppView
            }
        }
        .onAppear {
            viewModel.updateSoundtrackState()
        }
    }
    
    private var mainAppView: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                // Main content based on selected tab
                Group {
                    switch selectedTab {
                    case 0: HomeView()
                    case 1: ScholarshipMatchView()
                    case 2: SavedScholarshipsView()
                    case 3: AvatarGridPageView()
                    case 4: MoreTabView()
                    default: HomeView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Custom purple bottom navigation bar
                HStack(spacing: 0) {
                    navBarButton(image: "house", label: "Home", index: 0)
                    navBarButton(image: "star", label: "Match", index: 1)
                    navBarButton(image: "bookmark", label: "Saved", index: 2)
                    navBarButton(image: "someTest", label: "Avatars", index: 3)
                    navBarButton(image: "paw", label: "More", index: 4)
                }
                .padding(.top, 15)
                .padding(.bottom, 0)
                .padding(.horizontal, 16)
                .background(
                    Theme.backgroundColor
                        .ignoresSafeArea()
                )
                .padding(.bottom, 0)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Image("account")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { showSearch = true }) {
                            Image("search")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showNotifications = true }) {
                        Image("bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                SmartSearchView()
            }
            .sheet(isPresented: $showNotifications) {
                NotificationsView()
            }
        }
    }
    
    @ViewBuilder
    private func navBarButton(image: String, label: String, index: Int) -> some View {
        Button(action: { 
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = index
            }
        }) {
            VStack(spacing: 4) {
                // Check if it's a custom asset
                let customAssets = ["house", "star", "bookmark", "someTest", "paw"]
                if customAssets.contains(image) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40, alignment: .bottom)
                        .frame(maxWidth: 40, alignment: .bottom)
                        .shadow(color: Color.black.opacity(0.12), radius: 2, x: 0, y: 1)
                } else {
                    Image(systemName: image)
                        .font(.system(size: 28, weight: .medium))
                        .frame(height: 36, alignment: .bottom)
                        .frame(maxWidth: 36, alignment: .bottom)
                        .foregroundColor(selectedTab == index ? .white : .white.opacity(0.7))
                }
                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(selectedTab == index ? .white : .white.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity)
        .scaleEffect(selectedTab == index ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}

#Preview {
    MainNavigationView()
        .environmentObject(AppViewModel())
} 
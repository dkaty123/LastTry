import SwiftUI

struct MainNavigationView: View {
    @State private var selectedTab = 0
    @State private var showSearch = false
    @State private var showNotifications = false
    
    init() {
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Theme.backgroundColor)
        
        // Set the tab bar item colors
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(0)
                    
                    ScholarshipMatchView()
                        .tabItem {
                            Label("Cosmic Match", systemImage: "sparkles")
                        }
                        .tag(1)
                    
                    SavedScholarshipsView()
                        .tabItem {
                            Label("Saved", systemImage: "bookmark.fill")
                        }
                        .tag(2)
                    
                    MoreTabView()
                        .tabItem {
                            Label("More", systemImage: "ellipsis.circle")
                        }
                        .tag(3)
                }
                .tint(.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { showSearch = true }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showNotifications = true }) {
                        Image(systemName: "bell.fill")
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
}

#Preview {
    MainNavigationView()
        .environmentObject(AppViewModel())
} 
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    @State private var showSearch = false
    @State private var isAnimating = false
    
    init() {
        // Set the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Theme.backgroundColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                VStack {
                    if currentIndex < viewModel.scholarships.count {
                        ScholarshipCardView(scholarship: viewModel.scholarships[currentIndex])
                            .frame(height: 420)
                            .offset(x: offset.width, y: 0)
                            .rotationEffect(.degrees(Double(offset.width / 20)))
                            .opacity(isAnimating ? 1 : 0)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation
                                    }
                                    .onEnded { gesture in
                                        withAnimation(.spring()) {
                                            handleSwipe(gesture)
                                        }
                                    }
                            )
                    } else {
                        VStack(spacing: 20) {
                            Image(systemName: "rocket.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(45))
                                .offset(y: -50)
                                .animation(
                                    Animation.easeInOut(duration: 1)
                                        .repeatForever(autoreverses: true),
                                    value: true
                                )
                            
                            Text("No more scholarships in your orbit!")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Check back later for new opportunities")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                    }
                }
                
                // Action buttons
                VStack {
                    Spacer()
                    HStack(spacing: 40) {
                        Button(action: { 
                            withAnimation(.spring()) {
                                skipScholarship()
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Theme.errorColor)
                        }
                        
                        Button(action: { 
                            withAnimation(.spring()) {
                                saveScholarship()
                            }
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Theme.successColor)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Notifications")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { showSearch = true }) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: FinancialPlanningView()) {
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: ScholarshipStatsView()) {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: SavedScholarshipsView()) {
                            Image(systemName: "bookmark.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: AchievementsView()) {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: NotificationsView()) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                        
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                SmartSearchView()
            }
            .onAppear {
                withAnimation(.easeIn(duration: 0.3)) {
                    isAnimating = true
                }
            }
        }
    }
    
    private func handleSwipe(_ gesture: DragGesture.Value) {
        let threshold: CGFloat = 50
        if abs(gesture.translation.width) > threshold {
            if gesture.translation.width > 0 {
                saveScholarship()
            } else {
                skipScholarship()
            }
        } else {
            withAnimation(.spring()) {
            offset = .zero
            }
        }
    }
    
    private func saveScholarship() {
        guard currentIndex < viewModel.scholarships.count else { return }
        viewModel.saveScholarship(viewModel.scholarships[currentIndex])
        isAnimating = false
        withAnimation(.spring()) {
            offset = CGSize(width: 500, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        currentIndex += 1
        offset = .zero
            isAnimating = true
        }
    }
    
    private func skipScholarship() {
        guard currentIndex < viewModel.scholarships.count else { return }
        isAnimating = false
        withAnimation(.spring()) {
            offset = CGSize(width: -500, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        currentIndex += 1
        offset = .zero
            isAnimating = true
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppViewModel())
} 
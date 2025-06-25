import SwiftUI

struct AvatarGridPageView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: SplashMotionManager())
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            
            ScrollView {
                VStack {
                    Text("Our Space Explorers")
                        .font(Font.custom("SF Pro Rounded", size: 28).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        AstronautCatView(size: 100)
                        AstronautDogView(size: 100)
                        AstronautFoxView(size: 100)
                        AstronautOwlView(size: 100)
                        AstronautPenguinView(size: 100)
                        AstronautDragonView(size: 100)
                        AstronautBunnyView(size: 100)
                        AstronautBearView(size: 100)
                        AstronautRaccoonView(size: 100)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Avatar Grid")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct AvatarGridPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AvatarGridPageView()
        }
    }
}
#endif 
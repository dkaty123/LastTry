import SwiftUI

struct OnboardingShuttleView: View {
    var body: some View {
        let animalViews: [AnyView] = [
            AnyView(FloatingAstronautCatView(position: .zero, angle: 0, bob: 0)),
            AnyView(FloatingAstronautDogView(position: .zero, angle: 0, bob: 0)),
            AnyView(FloatingAstronautBunnyView(position: .zero, angle: 0, bob: 0))
        ]
        
        SpaceShuttleView(animals: animalViews, showTrail: true)
            .scaleEffect(0.8) // Make it a bit smaller for onboarding
    }
} 
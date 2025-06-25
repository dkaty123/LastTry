import SwiftUI

// Head-only astronaut avatars for onboarding screens
struct OnboardingAstronautCatHeadView: View {
    @State private var headTilt = false
    @State private var blink = false
    
    var body: some View {
        ZStack {
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 44, height: 44)
                .shadow(color: Color.blue.opacity(0.18), radius: 4, x: 0, y: 1)
            
            // Cat head inside helmet
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.orange, Color.yellow.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 30, height: 30)
                
                // Ears
                HStack(spacing: 14) {
                    Triangle().fill(Color.orange).frame(width: 8, height: 11).offset(y: -11)
                    Triangle().fill(Color.orange).frame(width: 8, height: 11).offset(y: -11)
                }
                
                // Eyes
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.green).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    .opacity(blink ? 0 : 1)
                    ZStack {
                        Circle().fill(Color.green).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    .opacity(blink ? 0 : 1)
                }
                
                // Nose
                Triangle().fill(Color.pink).frame(width: 3, height: 2.5).offset(y: 2.5)
                
                // Whiskers
                HStack(spacing: 11) {
                    VStack(spacing: 2) {
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(15))
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5)
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(-15))
                    }
                    VStack(spacing: 2) {
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(-15))
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5)
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(15))
                    }
                }.offset(y: 5)
            }
        }
        .rotationEffect(.degrees(headTilt ? 3 : -3), anchor: .center)
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                headTilt = true
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

struct OnboardingAstronautDogHeadView: View {
    @State private var headTilt = false
    @State private var blink = false
    
    var body: some View {
        ZStack {
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 44, height: 44)
                .shadow(color: Color.orange.opacity(0.18), radius: 4, x: 0, y: 1)
            
            // Dog head inside helmet
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.brown, Color.orange.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 30, height: 30)
                
                // Ears
                HStack(spacing: 16) {
                    Ellipse().fill(Color.brown).frame(width: 6, height: 10).offset(y: -8)
                    Ellipse().fill(Color.brown).frame(width: 6, height: 10).offset(y: -8)
                }
                
                // Eyes
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.brown).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    .opacity(blink ? 0 : 1)
                    ZStack {
                        Circle().fill(Color.brown).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    .opacity(blink ? 0 : 1)
                }
                
                // Nose
                Circle().fill(Color.black).frame(width: 3, height: 2.5).offset(y: 2.5)
                
                // Tongue
                Ellipse().fill(Color.pink).frame(width: 4, height: 2).offset(y: 4)
            }
        }
        .rotationEffect(.degrees(headTilt ? 3 : -3), anchor: .center)
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                headTilt = true
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

struct OnboardingAstronautBunnyHeadView: View {
    @State private var headTilt = false
    @State private var blink = false
    @State private var earWiggle = false
    
    var body: some View {
        ZStack {
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 44, height: 44)
                .shadow(color: Color.pink.opacity(0.18), radius: 4, x: 0, y: 1)
            
            // Bunny head inside helmet
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 30, height: 30)
                
                // Ears
                HStack(spacing: 12) {
                    Ellipse().fill(Color.white).frame(width: 4, height: 12).offset(y: -10)
                        .rotationEffect(.degrees(earWiggle ? 5 : -5), anchor: .bottom)
                    Ellipse().fill(Color.white).frame(width: 4, height: 12).offset(y: -10)
                        .rotationEffect(.degrees(earWiggle ? -5 : 5), anchor: .bottom)
                }
                
                // Eyes
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.pink).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    .opacity(blink ? 0 : 1)
                    ZStack {
                        Circle().fill(Color.pink).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    .opacity(blink ? 0 : 1)
                }
                
                // Nose
                Circle().fill(Color.pink).frame(width: 2.5, height: 2).offset(y: 2.5)
            }
        }
        .rotationEffect(.degrees(headTilt ? 3 : -3), anchor: .center)
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                headTilt = true
            }
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.4)) { earWiggle.toggle() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.4)) { earWiggle.toggle() }
                }
            }
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.1)) { blink = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { blink = false }
            }
        }
    }
}

struct OnboardingShuttleView: View {
    var body: some View {
        HStack(spacing: 32) {
            FloatingAstronautCatView(position: .zero, angle: 0, bob: 0)
            FloatingAstronautDogView(position: .zero, angle: 0, bob: 0)
            FloatingAstronautBunnyView(position: .zero, angle: 0, bob: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
} 
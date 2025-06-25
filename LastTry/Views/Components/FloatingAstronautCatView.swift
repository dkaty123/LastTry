import SwiftUI

struct FloatingAstronautCatView: View {
    let position: CGPoint
    let angle: Double
    let bob: CGFloat
    let animalSize: CGSize = CGSize(width: 64, height: 64)
    
    @State private var armWave = false
    @State private var legKick = false
    @State private var headTilt = false
    @State private var bodyRotation = false
    
    var body: some View {
        ZStack {
            // Suit body with colored panels and seams
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [Color.white, Color.gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: 24, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue.opacity(0.18), lineWidth: 1)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.blue.opacity(0.18)).frame(width: 20, height: 4).cornerRadius(3).offset(y: 8)
                        Spacer()
                    }
                )
                .offset(y: 14)
            
            // Arms with gloves (animated)
            ZStack {
                // Left arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 10)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.blue)
                        .frame(width: 6, height: 4)
                }
                .offset(x: -14, y: 16)
                .rotationEffect(.degrees(armWave ? 25 : 15), anchor: .bottom)
                
                // Right arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 10)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.blue)
                        .frame(width: 6, height: 4)
                }
                .offset(x: 14, y: 16)
                .rotationEffect(.degrees(armWave ? -35 : -15), anchor: .bottom)
            }
            
            // Legs with boots (animated)
            HStack(spacing: 10) {
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 8)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.blue)
                        .frame(width: 6, height: 4)
                }
                .offset(y: 28)
                .rotationEffect(.degrees(legKick ? 8 : -5), anchor: .top)
                
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 8)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.blue)
                        .frame(width: 6, height: 4)
                }
                .offset(y: 28)
                .rotationEffect(.degrees(legKick ? -8 : 5), anchor: .top)
            }
            
            // Chest control panel
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white.opacity(0.8))
                .frame(width: 10, height: 4)
                .overlay(
                    HStack(spacing: 1) {
                        Circle().fill(Color.red).frame(width: 1.5)
                        Circle().fill(Color.green).frame(width: 1.5)
                        Circle().fill(Color.yellow).frame(width: 1.5)
                    }
                )
                .offset(y: 18)
            
            // Helmet
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 44, height: 44)
                .offset(y: -5)
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
                
                // Eyes (matching CosmicCatAvatar)
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.green).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                    ZStack {
                        Circle().fill(Color.green).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3, height: 3)
                        Circle().fill(Color.white).frame(width: 1.5, height: 1.5).offset(x: -0.8, y: -0.8)
                    }
                }
                
                // Nose (pink triangle)
                Triangle().fill(Color.pink).frame(width: 3, height: 2.5).offset(y: 2.5)
                
                // Whiskers (matching CosmicCatAvatar)
                HStack(spacing: 11) {
                    // Left whiskers
                    VStack(spacing: 2) {
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(15))
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5)
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(-15))
                    }
                    // Right whiskers
                    VStack(spacing: 2) {
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(-15))
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5)
                        Rectangle().fill(Color.white.opacity(0.8)).frame(width: 6, height: 0.5).rotationEffect(.degrees(15))
                    }
                }.offset(y: 5)
            }
            .offset(y: -5)
            .rotationEffect(.degrees(headTilt ? 3 : -3), anchor: .center)
        }
        .frame(width: animalSize.width, height: animalSize.height)
        .rotationEffect(.radians(angle))
        .rotationEffect(.degrees(bodyRotation ? 8 : -8), anchor: .center)
        .position(position)
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Arm waving animation with random delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...0.8)) {
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                armWave = true
            }
        }
        
        // Leg kicking animation with different delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...1.2)) {
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                legKick = true
            }
        }
        
        // Head tilting animation with different delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.8...1.5)) {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                headTilt = true
            }
        }
        
        // Body rotation animation with random delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.1...0.7)) {
            withAnimation(.easeInOut(duration: 4.5).repeatForever(autoreverses: true)) {
                bodyRotation = true
            }
        }
    }
}

// Simple triangle shape for cat ears
struct CatEarTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#if DEBUG
struct FloatingAstronautCatView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            FloatingAstronautCatView(position: CGPoint(x: 0, y: 0), angle: 0, bob: 0)
        }
    }
}
#endif 
import SwiftUI

struct FloatingAstronautDogView: View {
    let position: CGPoint
    let angle: Double
    let bob: CGFloat
    let animalSize: CGSize = CGSize(width: 68, height: 68)
    
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
                        .stroke(Color.orange.opacity(0.18), lineWidth: 1)
                )
                .overlay(
                    VStack {
                        Rectangle().fill(Color.orange.opacity(0.18)).frame(width: 20, height: 4).cornerRadius(3).offset(y: 8)
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
                        .fill(Color.orange)
                        .frame(width: 6, height: 4)
                }
                .offset(x: -14, y: 16)
                .rotationEffect(.degrees(armWave ? 30 : 15), anchor: .bottom)
                
                // Right arm
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 10)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.orange)
                        .frame(width: 6, height: 4)
                }
                .offset(x: 14, y: 16)
                .rotationEffect(.degrees(armWave ? -30 : -15), anchor: .bottom)
            }
            
            // Legs with boots (animated)
            HStack(spacing: 10) {
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 8)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.orange)
                        .frame(width: 6, height: 4)
                }
                .offset(y: 28)
                .rotationEffect(.degrees(legKick ? 10 : -8), anchor: .top)
                
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 6, height: 8)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.orange)
                        .frame(width: 6, height: 4)
                }
                .offset(y: 28)
                .rotationEffect(.degrees(legKick ? -10 : 8), anchor: .top)
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
            
            // Dog head inside helmet
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.brown, Color.orange.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 30, height: 30)
                
                // Ears (floppy, animated)
                HStack(spacing: 14) {
                    DogEarShape().fill(Color.brown).frame(width: 8, height: 18).offset(y: -11 + bob).rotationEffect(.degrees(-20 + Double(bob)*2))
                    DogEarShape().fill(Color.brown).frame(width: 8, height: 18).offset(y: -11 - bob).rotationEffect(.degrees(20 - Double(bob)*2))
                }
                
                // Eyes (matching SpaceDogAvatar)
                HStack(spacing: 8) {
                    ZStack {
                        Circle().fill(Color.brown).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3.5, height: 3.5)
                    }
                    ZStack {
                        Circle().fill(Color.brown).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 3.5, height: 3.5)
                    }
                }
                
                // Nose (black circle)
                Circle().fill(Color.black).frame(width: 4, height: 3).offset(y: 2.5)
            }
            .offset(y: -5)
            .rotationEffect(.degrees(headTilt ? 4 : -4), anchor: .center)
        }
        .frame(width: animalSize.width, height: animalSize.height)
        .rotationEffect(.radians(angle))
        .rotationEffect(.degrees(bodyRotation ? -6 : 6), anchor: .center)
        .position(position)
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Arm waving animation with random delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.3...1.0)) {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                armWave = true
            }
        }
        
        // Leg kicking animation with different delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.7...1.4)) {
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                legKick = true
            }
        }
        
        // Head tilting animation with different delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.1...0.9)) {
            withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
                headTilt = true
            }
        }
        
        // Body rotation animation with random delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...0.9)) {
            withAnimation(.easeInOut(duration: 5.2).repeatForever(autoreverses: true)) {
                bodyRotation = true
            }
        }
    }
}

// Floppy dog ear shape
struct DogEarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.minX, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + 6))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

#if DEBUG
struct FloatingAstronautDogView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            FloatingAstronautDogView(position: CGPoint(x: 0, y: 0), angle: 0, bob: 0)
        }
    }
}
#endif 
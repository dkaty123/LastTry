import SwiftUI

struct FloatingAstronautPenguinView: View {
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var target: CGPoint = CGPoint(x: 0, y: 0)
    @State private var angle: Double = 0
    @State private var bob: CGFloat = 0
    let animalSize: CGSize = CGSize(width: 64, height: 68)
    let animationDuration: Double = 3.8

    func randomPoint(in size: CGSize) -> CGPoint {
        let padding: CGFloat = 40
        let topBandHeight: CGFloat = 120
        let x = CGFloat.random(in: padding...(size.width - padding))
        let y = CGFloat.random(in: padding...(padding + topBandHeight))
        return CGPoint(x: x, y: y)
    }

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
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
                
                // Arms with gloves (copying leg design exactly)
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
                    .rotationEffect(.degrees(15), anchor: .bottom)
                    
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
                    .rotationEffect(.degrees(-15), anchor: .bottom)
                }
                
                // Legs with boots
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
                    VStack(spacing: 0) {
                        Capsule()
                            .fill(Color.gray.opacity(0.7))
                            .frame(width: 6, height: 8)
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.blue)
                            .frame(width: 6, height: 4)
                    }
                    .offset(y: 28)
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
                
                // Penguin head inside helmet
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color.black, Color.gray.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                        .frame(width: 30, height: 30)
                    
                    // White belly patch
                    Ellipse()
                        .fill(Color.white)
                        .frame(width: 18, height: 20)
                        .offset(y: 2)
                    
                    // Eyes
                    HStack(spacing: 8) {
                        Circle().fill(Color.black).frame(width: 5, height: 5)
                        Circle().fill(Color.black).frame(width: 5, height: 5)
                    }
                    
                    // Beak
                    TriangleBeak().fill(Color.orange).frame(width: 6, height: 6).offset(y: 5)
                }
                .offset(y: -5)
            }
            .frame(width: animalSize.width, height: animalSize.height)
            .rotationEffect(.radians(angle))
            .position(position)
            .onAppear {
                let initial = randomPoint(in: size)
                position = initial
                target = randomPoint(in: size)
                moveToNextTarget(in: size)
                animateBob()
            }
        }
    }

    func moveToNextTarget(in size: CGSize) {
        let dx = target.x - position.x
        let dy = target.y - position.y
        let newAngle = atan2(dy, dx)
        withAnimation(.easeInOut(duration: animationDuration)) {
            angle = newAngle
            position = target
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            target = randomPoint(in: size)
            moveToNextTarget(in: size)
        }
    }

    func animateBob() {
        withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            bob = 5
        }
    }
}

// Penguin beak
struct TriangleBeak: Shape {
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
struct FloatingAstronautPenguinView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            FloatingAstronautPenguinView()
        }
    }
}
#endif 
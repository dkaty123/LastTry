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
                // Penguin body
                Ellipse()
                    .fill(Color.black)
                    .frame(width: 32, height: 38)
                    .offset(y: 14)
                Ellipse()
                    .fill(Color.white)
                    .frame(width: 20, height: 28)
                    .offset(y: 16)
                // Penguin head
                Circle()
                    .fill(Color.black)
                    .frame(width: 28, height: 28)
                // Penguin helmet (glass)
                Circle()
                    .stroke(Color.white.opacity(0.7), lineWidth: 6)
                    .frame(width: 36, height: 36)
                // Penguin face
                Group {
                    Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: -5, y: -2) // Left eye
                    Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: 5, y: -2) // Right eye
                    TriangleBeak().fill(Color.orange).frame(width: 8, height: 8).offset(y: 6) // Beak
                }
                // Penguin flippers (animated)
                PenguinFlipperShape().fill(Color.black).frame(width: 8, height: 18).offset(x: -12, y: 18 + bob).rotationEffect(.degrees(-30 + Double(bob)*2))
                PenguinFlipperShape().fill(Color.black).frame(width: 8, height: 18).offset(x: 12, y: 18 - bob).rotationEffect(.degrees(30 - Double(bob)*2))
                // Penguin feet
                Ellipse().fill(Color.orange).frame(width: 8, height: 4).offset(x: -6, y: 34)
                Ellipse().fill(Color.orange).frame(width: 8, height: 4).offset(x: 6, y: 34)
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
// Penguin flipper
struct PenguinFlipperShape: Shape {
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
struct FloatingAstronautPenguinView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            FloatingAstronautPenguinView()
        }
    }
}
#endif 
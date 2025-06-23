import SwiftUI

struct RocketshipView: View {
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var target: CGPoint = CGPoint(x: 0, y: 0)
    @State private var angle: Double = 0
    @State private var animateFlame = false
    let radius: CGFloat = 80 // Circle radius
    let speed: Double = 0.8 // Seconds per full circle
    let centerOffset: CGSize = .zero // Can be adjusted for placement
    let rocketSize: CGSize = CGSize(width: 96, height: 48)
    let animationDuration: Double = 2.8 // Slower

    func randomPoint(in size: CGSize) -> CGPoint {
        let padding: CGFloat = 60
        let topBandHeight: CGFloat = 120 // Height of the top band
        let x = CGFloat.random(in: padding...(size.width - padding))
        let y = CGFloat.random(in: padding...(padding + topBandHeight))
        return CGPoint(x: x, y: y)
    }

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let x = centerOffset.width + radius * cos(angle)
            let y = centerOffset.height + radius * sin(angle)
            let tangent = angle + .pi / 2 // Tangent to the circle
            ZStack {
                // Rocket Body (smaller, drawn horizontally)
                RocketBodyShape()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "E0E0E0"), Color(hex: "B0B0B0")]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 96, height: 48)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    .rotationEffect(.degrees(90))
                
                // Window (smaller, horizontal)
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "A7DDFC"), .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay(
                        Circle().stroke(Color(hex: "C0C0C0"), lineWidth: 2)
                    )
                    .frame(width: 18, height: 18)
                    .offset(x: 20)
                    .overlay(
                        Circle()
                            .fill(Color.white.opacity(0.7))
                            .frame(width: 7, height: 7)
                            .blur(radius: 2)
                            .offset(x: 4, y: -4)
                    )

                // Fins (smaller, horizontal)
                RocketFinShape().fill(Color(hex: "E53935"))
                    .frame(width: 36, height: 18)
                    .offset(x: -28, y: 18)
                    .rotationEffect(.degrees(90))
                RocketFinShape().fill(Color(hex: "E53935"))
                    .frame(width: 36, height: 18)
                    .scaleEffect(x: -1, y: 1)
                    .offset(x: -28, y: -18)
                    .rotationEffect(.degrees(90))
                
                // Flame (smaller, horizontal)
                ZStack {
                    FlameShape()
                        .fill(Color.orange.opacity(0.8))
                        .frame(width: 50, height: animateFlame ? 22 : 32)
                        .blur(radius: 8)
                        .rotationEffect(.degrees(90))
                    FlameShape()
                        .fill(Color.yellow.opacity(0.9))
                        .frame(width: 36, height: animateFlame ? 12 : 22)
                        .blur(radius: 4)
                        .rotationEffect(.degrees(90))
                    FlameShape()
                        .fill(Color.white)
                        .frame(width: 24, height: animateFlame ? 6 : 14)
                        .blur(radius: 2)
                        .rotationEffect(.degrees(90))
                }
                .offset(x: -54)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.1).repeatForever(autoreverses: true)) {
                        animateFlame.toggle()
                    }
                }
            }
            .frame(width: rocketSize.width, height: rocketSize.height)
            .rotationEffect(.radians(tangent))
            .position(position)
            .onAppear {
                let initial = randomPoint(in: size)
                position = initial
                target = randomPoint(in: size)
                moveToNextTarget(in: size)
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
}

// Custom shapes for the rocket components

struct RocketBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.height * 0.7), control: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height * 0.7))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}

struct RocketFinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.4))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}

struct FlameShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.minY), control: CGPoint(x: rect.width * 0.4, y: rect.height * 0.5))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY), control: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.width * 0.6, y: rect.height * 0.5))
        return path
    }
}

#if DEBUG
struct RocketshipView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            RocketshipView()
        }
    }
}
#endif 
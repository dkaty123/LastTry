import SwiftUI

struct SpaceShuttleView: View {
    let animals: [AnyView] // 3 animal views to sit in the windows
    var showTrail: Bool = false
    var isTakingOff: Bool = false
    
    var body: some View {
        ZStack {
            if showTrail {
                ShuttleTrailView()
                    .offset(x: -0, y: 45)
                    .blur(radius: 2)
            }

            // Shuttle body
            Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 220, height: 60)
                .shadow(color: .gray.opacity(0.3), radius: 8, x: 4, y: 4)
            // Shuttle nose
            Circle()
                .fill(Color.gray)
                .frame(width: 48, height: 48)
                .offset(x: 100)
            // Shuttle windows (seats)
            HStack(spacing: 18) {
                ForEach(0..<3) { i in
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.7))
                            .frame(width: 36, height: 36)
                        if animals.indices.contains(i) {
                            animals[i]
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            }
            .offset(x: 30)
            // Shuttle wings
            TriangleWing()
                .fill(Color.gray.opacity(0.7))
                .frame(width: 48, height: 28)
                .offset(x: -70, y: 32)
            TriangleWing()
                .fill(Color.gray.opacity(0.7))
                .frame(width: 48, height: 28)
                .scaleEffect(x: -1, y: 1)
                .offset(x: -70, y: -32)
            // Shuttle tail fin
            TriangleWing()
                .fill(Color.gray)
                .frame(width: 24, height: 38)
                .rotationEffect(.degrees(90))
                .offset(x: -110)
            // Flame
            if isTakingOff && !showTrail {
                Path { path in
                    path.move(to: CGPoint(x: -100, y: 0))
                    path.addQuadCurve(to: CGPoint(x: -130, y: 10), control: CGPoint(x: -115, y: -5))
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange, Color.red.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 28, height: 48)
                .offset(x: -120)
                .blur(radius: 4)
            }
        }
        .frame(width: 260, height: 100)
    }
}

struct TriangleWing: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#if DEBUG
struct SpaceShuttleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            SpaceShuttleView(animals: [
                AnyView(FloatingAstronautCatView(position: .zero, angle: 0, bob: 0)),
                AnyView(FloatingAstronautDogView(position: .zero, angle: 0, bob: 0)),
                AnyView(FloatingAstronautBunnyView(position: .zero, angle: 0, bob: 0))
            ])
        }
    }
}
#endif 
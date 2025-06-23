import SwiftUI

struct FloatingAstronautBunnyView: View {
    let position: CGPoint
    let angle: Double
    let bob: CGFloat
    let animalSize: CGSize = CGSize(width: 66, height: 72)
    var body: some View {
        ZStack {
            // Bunny body
            Ellipse()
                .fill(Color.white)
                .frame(width: 36, height: 32)
                .offset(y: 0)
            // Bunny head
            Circle()
                .fill(Color.white)
                .frame(width: 30, height: 30)
            // Bunny helmet (glass)
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 38, height: 38)
            // Bunny face
            Group {
                Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: -5, y: -2) // Left eye
                Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: 5, y: -2) // Right eye
                RoundedRectangle(cornerRadius: 2).fill(Color.pink).frame(width: 8, height: 2).offset(y: 6) // Mouth
                Ellipse().fill(Color.pink.opacity(0.7)).frame(width: 5, height: 3).offset(y: 2) // Nose
            }
            // Bunny ears (tall, animated)
            BunnyEarShape().fill(Color.white).frame(width: 8, height: 28).offset(x: -8, y: -22 + bob).rotationEffect(.degrees(-10 + Double(bob)*2))
            BunnyEarShape().fill(Color.white).frame(width: 8, height: 28).offset(x: 8, y: -22 - bob).rotationEffect(.degrees(10 - Double(bob)*2))
        }
        .frame(width: animalSize.width, height: animalSize.height)
        .rotationEffect(.radians(angle))
        .position(position)
    }
}

// Bunny ear shape
struct BunnyEarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.minX, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + 8))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

#if DEBUG
struct FloatingAstronautBunnyView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            FloatingAstronautBunnyView(position: CGPoint(x: 0, y: 0), angle: 0, bob: 0)
        }
    }
}
#endif 
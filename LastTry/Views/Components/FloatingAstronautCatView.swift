import SwiftUI

struct FloatingAstronautCatView: View {
    let position: CGPoint
    let angle: Double
    let bob: CGFloat
    let animalSize: CGSize = CGSize(width: 64, height: 64)
    var body: some View {
        ZStack {
            // Cat body
            Ellipse()
                .fill(Color.white)
                .frame(width: 36, height: 28)
                .offset(y: 10)
            // Cat head
            Circle()
                .fill(Color.orange)
                .frame(width: 28, height: 28)
            // Cat helmet (glass)
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 36, height: 36)
            // Cat face
            Group {
                Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: -5, y: -2) // Left eye
                Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: 5, y: -2) // Right eye
                RoundedRectangle(cornerRadius: 2).fill(Color.black).frame(width: 8, height: 2).offset(y: 5) // Mouth
            }
            // Cat ears
            CatEarTriangle()
                .fill(Color.orange)
                .frame(width: 10, height: 12)
                .offset(x: -8, y: -16)
            CatEarTriangle()
                .fill(Color.orange)
                .frame(width: 10, height: 12)
                .offset(x: 8, y: -16)
            // Paw (waving)
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: -16, y: 10 + bob)
                .rotationEffect(.degrees(bob * 10))
        }
        .frame(width: animalSize.width, height: animalSize.height)
        .rotationEffect(.radians(angle))
        .position(position)
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
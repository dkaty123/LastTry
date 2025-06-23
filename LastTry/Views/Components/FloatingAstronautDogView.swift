import SwiftUI

struct FloatingAstronautDogView: View {
    let position: CGPoint
    let angle: Double
    let bob: CGFloat
    let animalSize: CGSize = CGSize(width: 68, height: 68)
    var body: some View {
        ZStack {
            // Dog body
            Ellipse()
                .fill(Color.brown.opacity(0.9))
                .frame(width: 38, height: 30)
                .offset(y: 12)
            // Dog head
            Circle()
                .fill(Color.brown)
                .frame(width: 30, height: 30)
            // Dog helmet (glass)
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 6)
                .frame(width: 38, height: 38)
            // Dog face
            Group {
                Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: -5, y: -2) // Left eye
                Ellipse().fill(Color.black).frame(width: 4, height: 4).offset(x: 5, y: -2) // Right eye
                RoundedRectangle(cornerRadius: 2).fill(Color.black).frame(width: 8, height: 2).offset(y: 6) // Mouth
                Ellipse().fill(Color.black.opacity(0.7)).frame(width: 5, height: 3).offset(y: 2) // Nose
            }
            // Dog ears (floppy, animated)
            DogEarShape().fill(Color.brown).frame(width: 8, height: 18).offset(x: -10, y: -16 + bob).rotationEffect(.degrees(-20 + Double(bob)*2))
            DogEarShape().fill(Color.brown).frame(width: 8, height: 18).offset(x: 10, y: -16 - bob).rotationEffect(.degrees(20 - Double(bob)*2))
            // Paw (waving)
            Circle()
                .fill(Color.brown.opacity(0.9))
                .frame(width: 10, height: 10)
                .offset(x: 16, y: 12 + bob)
                .rotationEffect(.degrees(-bob * 10))
        }
        .frame(width: animalSize.width, height: animalSize.height)
        .rotationEffect(.radians(angle))
        .position(position)
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
import SwiftUI

struct SmokeParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    var size: CGFloat
    var opacity: Double
    let creationDate = Date()
    var velocity: CGVector
}

class SmokeParticleManager: ObservableObject {
    @Published var particles: [SmokeParticle] = []
    private var timer: Timer?

    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in
            self?.updateParticles()
            self?.createParticle()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func createParticle() {
        let color = [Color.white, .yellow, .orange].randomElement() ?? .orange
        let initialVelocity = CGVector(dx: CGFloat.random(in: -4...(-2)), dy: CGFloat.random(in: -1...1))
        
        let particle = SmokeParticle(
            position: .zero,
            color: color,
            size: CGFloat.random(in: 25...40),
            opacity: 1.0,
            velocity: initialVelocity
        )
        particles.append(particle)
    }

    private func updateParticles() {
        let now = Date()
        let trailLifetime: Double = 2.0
        
        particles.removeAll { now.timeIntervalSince($0.creationDate) > trailLifetime }

        for i in particles.indices {
            let age = now.timeIntervalSince(particles[i].creationDate)
            let progress = age / trailLifetime

            // Update physics
            particles[i].position.x += particles[i].velocity.dx
            particles[i].position.y += particles[i].velocity.dy
            particles[i].velocity.dx *= 0.98 // Slow down
            
            // Update visuals
            particles[i].size = max(0, particles[i].size * (1 - (progress * 0.8))) // Shrink
            particles[i].opacity = 1.0 - progress // Fade out
            
            // Change color as it cools
            if progress > 0.4 {
                particles[i].color = .gray
            }
        }
    }
}

struct ShuttleTrailView: View {
    @StateObject private var particleManager = SmokeParticleManager()

    var body: some View {
        ZStack {
            ForEach(particleManager.particles) { particle in
                Ellipse() // Use Ellipse for a more streaked look
                    .fill(particle.color)
                    .frame(width: particle.size * 1.5, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
                    .blur(radius: 8)
            }
        }
        .onAppear(perform: particleManager.start)
        .onDisappear(perform: particleManager.stop)
    }
} 
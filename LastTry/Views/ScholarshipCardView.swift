import Foundation
// Import the SwipeDirection enum
import SwiftUI
// If the above import does not work, try:
// import LastTry // if using modules
// Or just ensure the file is in the same target

struct ScholarshipCardView: View {
    let scholarship: Scholarship
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var isExpanded = false
    @State private var isAnimating = false
    @State private var isHovered = false
    @State private var showConfetti = false
    @State private var isSaved = false
    
    let swipeDirection: SwipeDirection?
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with floating animation
            VStack(spacing: 10) {
                Text(scholarship.name)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                
                Text("$\(Int(scholarship.amount))")
                    .font(.title.bold())
                    .foregroundColor(Theme.accentColor)
                    .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                    .scaleEffect(isHovered ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            }
            .padding(.top)
            .offset(y: isAnimating ? 0 : -20)
            .opacity(isAnimating ? 1 : 0)
            
            // Category Badge with pulsing effect
            Text(scholarship.category.rawValue.uppercased())
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    ZStack {
                        Theme.accentColor.opacity(0.3)
                        Circle()
                            .fill(Theme.accentColor.opacity(0.2))
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .opacity(isAnimating ? 0 : 1)
                    }
                )
                .cornerRadius(15)
                .scaleEffect(isHovered ? 1.05 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            
            // Description with fade-in effect
            HStack(alignment: .top, spacing: 12) {
                Image(categoryCatImageName(for: scholarship.category))
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            Text(scholarship.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
            }
                .padding(.horizontal)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
            
            if isExpanded {
                // Requirements with staggered animation
                VStack(alignment: .leading, spacing: 10) {
                    Text("Requirements:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    ForEach(Array(scholarship.requirements.enumerated()), id: \.element) { index, requirement in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Theme.successColor)
                                .scaleEffect(isAnimating ? 1 : 0.5)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6).delay(Double(index) * 0.1), value: isAnimating)
                            
                            Text(requirement)
                                .foregroundColor(.white)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(x: isAnimating ? 0 : 20)
                                .animation(.easeOut(duration: 0.3).delay(Double(index) * 0.1), value: isAnimating)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Theme.cardBackground.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Theme.accentColor.opacity(0.3), lineWidth: 1)
                        )
                )
                
                // Deadline with icon animation
                HStack {
                    Image("clock")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Theme.accentColor)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isAnimating)
                    Text("Deadline: \(scholarship.deadline.formatted(date: .long, time: .omitted))")
                        .foregroundColor(.white)
                }
                .padding(.vertical, 5)
                // Reminder and Calendar buttons
                HStack(spacing: 16) {
                    Button(action: { scheduleDeadlineReminder() }) {
                        HStack(spacing: 8) {
                            Image("remind")
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("Remind Me")
                            .font(.subheadline.bold())
                        }
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.purple.opacity(0.25))
                            .cornerRadius(10)
                    }
                    Button(action: { addToCalendar() }) {
                        HStack(spacing: 8) {
                            Image("calender")
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("Add to Calendar")
                            .font(.subheadline.bold())
                        }
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.25))
                            .cornerRadius(10)
                    }
                }
                
                if let website = scholarship.website {
                    // Website button with hover effect
                    Link(destination: URL(string: website)!) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.white)
                        Text("Visit Website")
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                            .padding()
                            .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Theme.accentColor)
                                .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                        )
                    }
                    .scaleEffect(isHovered ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
                }
            }
            
            // Expand/Collapse Button with rotation animation
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                    if isExpanded {
                        showConfetti = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            showConfetti = false
                        }
                    }
                }
            }) {
                Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Theme.accentColor)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .scaleEffect(isHovered ? 1.2 : 1.0)
            }
            .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Theme.cardBackground
                
                // Animated gradient overlay
                LinearGradient(
                    gradient: Gradient(colors: [
                        Theme.accentColor.opacity(0.1),
                        Theme.accentColor.opacity(0.05),
                        Theme.accentColor.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(isAnimating ? 1 : 0)
            }
        )
        .cornerRadius(20)
        .shadow(color: Theme.accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()
        .scaleEffect(isAnimating ? 1 : 0.9)
        .opacity(isAnimating ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
        .onHover { hovering in
            isHovered = hovering
        }
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    swipeDirection == .right ? Theme.successColor :
                    swipeDirection == .left ? Theme.errorColor : Color.clear,
                    lineWidth: (swipeDirection == .right || swipeDirection == .left) ? 8 : 0
                )
                .shadow(
                    color: (swipeDirection == .right ? Theme.successColor :
                            swipeDirection == .left ? Theme.errorColor : Color.clear).opacity(0.7),
                    radius: (swipeDirection == .right || swipeDirection == .left) ? 24 : 0
                )
                .opacity((swipeDirection == .right || swipeDirection == .left) ? 1 : 0)
                .animation(.easeOut(duration: 0.2), value: swipeDirection)
        )
        .overlay(
            ConfettiView()
                .opacity(showConfetti ? 1 : 0)
        )
    }
    
    private func saveScholarship() {
        withAnimation {
            isSaved.toggle()
            if isSaved {
                // Save the scholarship through AppViewModel
                viewModel.saveScholarship(scholarship)
                // Post notification for calendar
                NotificationCenter.default.post(
                    name: NSNotification.Name("ScholarshipSaved"),
                    object: scholarship
                )
            }
        }
    }
    
    // MARK: - Reminders & Calendar
    private func scheduleDeadlineReminder() {
        // TODO: Implement local notification scheduling for the deadline
    }
    private func addToCalendar() {
        // TODO: Implement calendar export for the deadline
    }
    
    // Helper function to map category to cat image asset name
    private func categoryCatImageName(for category: Scholarship.ScholarshipCategory) -> String {
        switch category {
        case .stem: return "stem"
        case .arts: return "art"
        case .humanities: return "human"
        case .business: return "business"
        case .general: return "general"
        }
    }
}

// Confetti animation view
struct ConfettiView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<50) { index in
                Circle()
                    .fill([
                        Theme.accentColor,
                        Theme.successColor,
                        .white,
                        .blue,
                        .purple
                    ][index % 5])
                    .frame(width: 8, height: 8)
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isAnimating ? geometry.size.height + 100 : -100
                    )
                    .opacity(isAnimating ? 0 : 1)
                    .animation(
                        Animation.linear(duration: Double.random(in: 1...2))
                            .repeatCount(1)
                            .delay(Double.random(in: 0...0.5)),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    ScholarshipCardView(scholarship: Scholarship.sampleScholarships[0], swipeDirection: nil as SwipeDirection?)
        .preferredColorScheme(.dark)
} 
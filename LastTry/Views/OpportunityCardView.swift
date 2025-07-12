import SwiftUI

struct OpportunityCardView: View {
    let opportunity: Opportunity
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var isExpanded = false
    @State private var isAnimating = false
    @State private var isHovered = false
    @State private var showConfetti = false
    @State private var isSaved = false
    
    let swipeDirection: SwipeDirection?
    
    var body: some View {
        let catImageName = deterministicCatImageName(for: opportunity)
        VStack(spacing: 20) {
            // Header with floating animation
            VStack(spacing: 10) {
                Group {
                    if isExpanded {
                        Text(opportunity.title)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    } else {
                        Text(opportunity.title)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                // Amount/Stipend display
                if let amount = opportunity.amount, amount > 0 {
                    Text("$\(Int(amount))")
                        .font(.title.bold())
                        .foregroundColor(Theme.accentColor)
                        .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                        .scaleEffect(isHovered ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
                } else if let stipend = opportunity.stipend, stipend > 0 {
                    Text("$\(Int(stipend))/hour")
                        .font(.title2.bold())
                        .foregroundColor(Theme.accentColor)
                        .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                        .scaleEffect(isHovered ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
                } else {
                    Text(opportunity.type.displayName)
                        .font(.title2.bold())
                        .foregroundColor(Theme.accentColor)
                        .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                        .scaleEffect(isHovered ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
                }
            }
            .padding(.top)
            .offset(y: isAnimating ? 0 : -20)
            .opacity(isAnimating ? 1 : 0)
            
            // Type and Category Badges with pulsing effect
            HStack(spacing: 8) {
                Text(opportunity.type.displayName.uppercased())
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
                
                Text(opportunity.category.displayName.uppercased())
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        ZStack {
                            Color(opportunity.category.color).opacity(0.3)
                            Circle()
                                .fill(Color(opportunity.category.color).opacity(0.2))
                                .scaleEffect(isAnimating ? 1.2 : 0.8)
                                .opacity(isAnimating ? 0 : 1)
                        }
                    )
                    .cornerRadius(15)
            }
            .scaleEffect(isHovered ? 1.05 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            
            // Organization
            Text(opportunity.organization)
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 10)
            
            // Description with fade-in effect
            HStack(alignment: .top, spacing: 12) {
                Image(catImageName)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                
                Group {
                    if isExpanded {
                        Text(opportunity.description)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    } else {
                        Text(opportunity.description)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
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
                    
                    ForEach(Array(opportunity.requirements.enumerated()), id: \.element) { index, requirement in
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
                                .fixedSize(horizontal: false, vertical: true)
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
                
                // Deadline with icon animation (use image, not SF Symbol)
                if let deadline = opportunity.deadline {
                    HStack {
                        Image("clock")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(Theme.accentColor)
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isAnimating)
                        Text("Deadline: \(deadline.formatted(date: .long, time: .omitted))")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 5)
                }
                // Reminder and Calendar buttons (use images, not SF Symbols)
                HStack(spacing: 16) {
                    if opportunity.deadline != nil {
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
                }
                // Website or Application URL button
                if let website = opportunity.website {
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
                // Glowy white outline
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.white.opacity(0.7), lineWidth: 3)
                    .blur(radius: 8)
                    .opacity(0.7)
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
    
    private func scheduleDeadlineReminder() {
        // Implementation for scheduling reminder
        print("Scheduling reminder for \(opportunity.title)")
    }
    
    private func addToCalendar() {
        // Implementation for adding to calendar
        print("Adding \(opportunity.title) to calendar")
    }
    
    // Deterministic cat image based on opportunity id
    private func deterministicCatImageName(for opportunity: Opportunity) -> String {
        let catNames = [
            "stem", "art", "human", "business", "general",
            "cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8", "cat9", "cat10",
            "clearIcon", "clearIcon2", "clearIcon3", "clearIcon4", "clearIcon5", "clearIcon6", "clearIcon7", "clearIcon8", "clearIcon9", "clearIcon10", "clearIcon11", "clearIcon12", "clearIcon13", "clearIcon14", "clearIcon15"
        ]
        let hash = abs(opportunity.id.hashValue)
        return catNames[hash % catNames.count]
    }
}

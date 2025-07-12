import SwiftUI

struct GalaxyMapView: View {
    let levels: [(min: Int, max: Int, name: String, emoji: String)]
    let currentLevel: Int
    @Environment(\.dismiss) private var dismiss
    @StateObject private var motion = SplashMotionManager()
    @State private var headerOffset: CGFloat = -50
    @State private var headerOpacity: Double = 0
    @State private var planetsOffset: CGFloat = 100
    @State private var planetsOpacity: Double = 0
    @State private var selectedPlanet: Int? = nil
    
    // Enhanced planet/station SF Symbols for 10 levels
    let icons = [
        "circle.fill", "moon.stars.fill", "globe.europe.africa.fill", "sparkle", "sun.max.fill",
        "cloud.moon.fill", "star.circle.fill", "tornado", "satellite", "flag.checkered"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Starry background
                ScholarSplashBackgroundView(motion: motion)
                    .ignoresSafeArea()
                ScholarSplashDriftingStarFieldView()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Enhanced Header
                    VStack(spacing: 20) {
                        // Navigation and Title
                        HStack {
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(8)
                                    .background(
                                        Circle()
                                            .fill(Theme.cardBackground.opacity(0.6))
                                            .overlay(
                                                Circle()
                                                    .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 4) {
                Text("Galaxy Progress Map")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                                
                                Text("Your journey through the scholarship universe")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            // Placeholder for balance
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 40, height: 40)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        // Current Level Status
                        HStack(spacing: 15) {
                                ZStack {
                                    Circle()
                                    .fill(Theme.accentColor.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Theme.accentColor)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Current Level")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                Text("Level \(currentLevel)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text(levels[currentLevel - 1].name)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(Theme.accentColor)
                            }
                            
                            Spacer()
                            
                            // Progress indicator
                            VStack(spacing: 4) {
                                Text("\(levels[currentLevel - 1].min)-\(levels[currentLevel - 1].max)")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text("Scholarships")
                                    .font(.system(size: 10, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Theme.cardBackground.opacity(0.8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .shadow(color: Theme.accentColor.opacity(0.2), radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        .offset(y: headerOffset)
                        .opacity(headerOpacity)
                    }
                    .background(Theme.backgroundColor.opacity(0.3))
                    
                    // Enhanced Galaxy Map
                    VStack(spacing: 20) {
                        // Map Header
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundColor(Theme.accentColor)
                                .font(.title3)
                            
                            Text("Explore Your Journey")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Enhanced Planets ScrollView
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 40) {
                                ForEach(0..<levels.count, id: \.self) { idx in
                                    let level = levels[idx]
                                    let isCurrentLevel = idx + 1 == currentLevel
                                    let isUnlocked = idx + 1 <= currentLevel
                                    let isCompleted = idx + 1 < currentLevel
                                    
                                    EnhancedPlanetView(
                                        level: level,
                                        levelNumber: idx + 1,
                                        icon: icons[idx % icons.count],
                                        isCurrentLevel: isCurrentLevel,
                                        isUnlocked: isUnlocked,
                                        isCompleted: isCompleted,
                                        isSelected: selectedPlanet == idx
                                    ) {
                                        selectedPlanet = selectedPlanet == idx ? nil : idx
                                    }
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 40)
                        }
                        .offset(y: planetsOffset)
                        .opacity(planetsOpacity)
                        
                        // Legend
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(Theme.accentColor)
                                    .font(.title3)
                                
                                Text("Legend")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 20) {
                                LegendItem(
                                    icon: "lock.fill",
                                    text: "Locked",
                                    color: .gray
                                )
                                
                                LegendItem(
                                    icon: "star.fill",
                                    text: "Current",
                                    color: Theme.accentColor
                                )
                                
                                LegendItem(
                                    icon: "checkmark.circle.fill",
                                    text: "Completed",
                                    color: Theme.successColor
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Theme.cardBackground.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Theme.cardBorder.opacity(0.2), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    headerOffset = 0
                    headerOpacity = 1
                }
                
                withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                    planetsOffset = 0
                    planetsOpacity = 1
                }
            }
        }
    }
}

struct EnhancedPlanetView: View {
    let level: (min: Int, max: Int, name: String, emoji: String)
    let levelNumber: Int
    let icon: String
    let isCurrentLevel: Bool
    let isUnlocked: Bool
    let isCompleted: Bool
    let isSelected: Bool
    let onTap: () -> Void
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // Enhanced Planet Icon
                ZStack {
                    // Background glow
                    Circle()
                        .fill(planetBackgroundColor.opacity(0.3))
                        .frame(width: 90, height: 90)
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                    
                    // Main planet circle
                    Circle()
                        .fill(planetBackgroundColor)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .stroke(planetBorderColor, lineWidth: 2)
                        )
                        .shadow(color: planetShadowColor, radius: 10, x: 0, y: 5)
                    
                    // Planet icon
                    Image(systemName: icon)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(planetIconColor)
                        .scaleEffect(isSelected ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                    
                    // Status indicator
                    if isCurrentLevel {
                        Circle()
                            .fill(Theme.accentColor)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .offset(x: 30, y: -30)
                    } else if isCompleted {
                        Circle()
                            .fill(Theme.successColor)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .offset(x: 30, y: -30)
                    }
                }
                
                // Level Info
                VStack(spacing: 6) {
                    Text("Level \(levelNumber)")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(planetTextColor)
                    
                    Text(level.name)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(planetTextColor.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .frame(width: 100)
                    
                    Text("\(level.min)-\(level.max)")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundColor(planetTextColor.opacity(0.6))
                }
            }
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if isCurrentLevel {
                isAnimating = true
            }
        }
    }
    
    private var planetBackgroundColor: Color {
        if isCompleted {
            return Theme.successColor.opacity(0.8)
        } else if isCurrentLevel {
            return Theme.accentColor.opacity(0.8)
        } else if isUnlocked {
            return Theme.cardBackground.opacity(0.8)
        } else {
            return Color.gray.opacity(0.3)
        }
    }
    
    private var planetBorderColor: Color {
        if isCompleted {
            return Theme.successColor
        } else if isCurrentLevel {
            return Theme.accentColor
        } else if isUnlocked {
            return Theme.cardBorder
        } else {
            return Color.gray
        }
    }
    
    private var planetIconColor: Color {
        if isCompleted {
            return .white
        } else if isCurrentLevel {
            return .white
        } else if isUnlocked {
            return .white
        } else {
            return Color.gray.opacity(0.5)
        }
    }
    
    private var planetTextColor: Color {
        if isCompleted {
            return Theme.successColor
        } else if isCurrentLevel {
            return Theme.accentColor
        } else if isUnlocked {
            return .white
        } else {
            return Color.gray.opacity(0.7)
        }
    }
    
    private var planetShadowColor: Color {
        if isCompleted {
            return Theme.successColor.opacity(0.3)
        } else if isCurrentLevel {
            return Theme.accentColor.opacity(0.3)
        } else if isUnlocked {
            return Theme.cardBorder.opacity(0.2)
        } else {
            return Color.clear
        }
    }
}

struct LegendItem: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(color)
            
            Text(text)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    GalaxyMapView(
        levels: [
            (0, 1, "Rookie Explorer", "🛰️"),
            (2, 6, "Stellar Seeker", "🚀"),
            (7, 16, "Rising Scholar", "🌟")
        ],
        currentLevel: 2
    )
} 
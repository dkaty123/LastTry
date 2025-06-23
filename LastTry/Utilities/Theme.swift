import SwiftUI

public enum Theme {
    public static let primaryGradient = LinearGradient(
        colors: [
            Color(hex: "2D1B69"),
            Color(hex: "1A103C")
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let accentColor = Color(hex: "9D4EDD")
    public static let backgroundColor = Color(hex: "1A103C")
    public static let textColor = Color.white
    public static let amberColor = Color(hex: "FFBF00")
    
    public static let cardBackground = Color(hex: "2D1B69").opacity(0.8)
    public static let cardBorder = Color(hex: "9D4EDD").opacity(0.3)
    
    public static let successColor = Color(hex: "4CAF50")
    public static let errorColor = Color(hex: "F44336")
}

extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

public struct SpaceButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Theme.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}

public struct SpaceCardStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .padding()
            .background(Theme.cardBackground)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Theme.cardBorder, lineWidth: 2)
            )
            .shadow(color: Theme.accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

extension View {
    public func spaceCard() -> some View {
        modifier(SpaceCardStyle())
    }
} 
import SwiftUI

struct AvatarInfo {
    let image: String
    let name: String
    let description: String
    let unlocksAt: Int
    let rarity: AvatarRarity
}

enum AvatarRarity: String, CaseIterable {
    case common = "Common"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    
    var color: Color {
        switch self {
        case .common: return .gray
        case .rare: return .blue
        case .epic: return .purple
        case .legendary: return .orange
        }
    }
    
    var icon: String {
        switch self {
        case .common: return "circle.fill"
        case .rare: return "star.fill"
        case .epic: return "crown.fill"
        case .legendary: return "sparkles"
        }
    }
}

struct AvatarGridPageView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @AppStorage("userAvatar") private var selectedAvatar: String = "clearIcon"
    @StateObject private var motion = SplashMotionManager()
    @State private var headerOffset: CGFloat = -50
    @State private var headerOpacity: Double = 0
    @State private var cardsOffset: CGFloat = 100
    @State private var cardsOpacity: Double = 0
    @State private var selectedFilter: AvatarFilter = .all
    @State private var showUnlockAnimation = false
    @State private var newlyUnlockedAvatar: String? = nil
    
    enum AvatarFilter: String, CaseIterable {
        case all = "All"
        case unlocked = "Unlocked"
        case locked = "Locked"
        case legendary = "Legendary"
    }
    
    // Enhanced avatars with rarity
    let avatars: [AvatarInfo] = [
        AvatarInfo(image: "clearIcon", name: "Luna", description: "The curious explorer", unlocksAt: 0, rarity: .common),
        AvatarInfo(image: "clearIcon2", name: "Nova", description: "The cosmic leader", unlocksAt: 0, rarity: .common),
        AvatarInfo(image: "clearIcon3", name: "Chill", description: "The relaxed dreamer", unlocksAt: 0, rarity: .common),
        AvatarInfo(image: "clearIcon4", name: "Pixel", description: "The techy cat", unlocksAt: 30, rarity: .rare),
        AvatarInfo(image: "clearIcon5", name: "Rocket", description: "Always on the move!", unlocksAt: 60, rarity: .rare),
        AvatarInfo(image: "clearIcon6", name: "Stella", description: "The shining star", unlocksAt: 90, rarity: .rare),
        AvatarInfo(image: "clearIcon7", name: "Comet", description: "Fast and playful", unlocksAt: 120, rarity: .epic),
        AvatarInfo(image: "clearIcon8", name: "Mochi", description: "Sweet and soft", unlocksAt: 150, rarity: .epic),
        AvatarInfo(image: "clearIcon9", name: "Astro", description: "The space scientist", unlocksAt: 180, rarity: .epic),
        AvatarInfo(image: "clearIcon10", name: "Shadow", description: "The mysterious one", unlocksAt: 210, rarity: .epic),
        AvatarInfo(image: "clearIcon11", name: "Sunny", description: "Brings the sunshine", unlocksAt: 240, rarity: .epic),
        AvatarInfo(image: "clearIcon12", name: "Milo", description: "The clever cat", unlocksAt: 270, rarity: .epic),
        AvatarInfo(image: "clearIcon13", name: "Cosmo", description: "Galactic adventurer", unlocksAt: 300, rarity: .legendary),
        AvatarInfo(image: "clearIcon14", name: "Peach", description: "The gentle friend", unlocksAt: 300, rarity: .legendary),
        AvatarInfo(image: "clearIcon15", name: "Ziggy", description: "The wild card", unlocksAt: 300, rarity: .legendary)
    ]
    
    var savedCount: Int { viewModel.savedScholarships.count }
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                enhancedHeaderView
                filterButtonsView
                avatarGridView
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            headerOffset = 0
            headerOpacity = 1
            cardsOffset = 0
            cardsOpacity = 1
            // Check for newly unlocked avatars
            checkForNewUnlocks()
        }
    }
    
    private var enhancedHeaderView: some View {
        VStack(spacing: 16) {
            // Header with title and stats
            HStack {
                // Placeholder for balance
                Circle()
                    .fill(Color.clear)
                    .frame(width: 40, height: 40)
                Spacer()
                VStack(spacing: 6) {
                    Text("Space Cats Collection")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    Text("Unlock your cosmic companions")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
                // Collection progress badge
                ZStack {
                    Circle()
                        .fill(Theme.accentColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    Text("\(unlockedCount)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            // Progress stats
            HStack(spacing: 20) {
                ProgressStatCard(
                    icon: "bookmark.fill",
                    title: "Saved",
                    value: "\(savedCount)",
                    color: Theme.accentColor
                )
                ProgressStatCard(
                    icon: "star.fill",
                    title: "Unlocked",
                    value: "\(unlockedCount)/\(avatars.count)",
                    color: Theme.successColor
                )
                ProgressStatCard(
                    icon: "crown.fill",
                    title: "Legendary",
                    value: "\(legendaryCount)",
                    color: Theme.amberColor
                )
            }
            .padding(.horizontal, 20)
        }
        .background(Theme.backgroundColor.opacity(0.3))
        .offset(y: 0)
        .opacity(1)
    }
    
    private var filterButtonsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(AvatarFilter.allCases, id: \.self) { filter in
                    Button(action: {
                        selectedFilter = filter
                    }) {
                        Text(filter.rawValue)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(selectedFilter == filter ? .white : .white.opacity(0.7))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedFilter == filter ? Theme.accentColor : Theme.cardBackground.opacity(0.6))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedFilter == filter ? Theme.accentColor : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    .scaleEffect(selectedFilter == filter ? 1.05 : 1.0)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    private var avatarGridView: some View {
        let filteredAvatars = getFilteredAvatars()
        return ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredAvatars, id: \.image) { avatar in
                    let isUnlocked = savedCount >= avatar.unlocksAt
                    EnhancedAvatarCardView(
                        avatar: avatar,
                        unlocked: isUnlocked,
                        selected: selectedAvatar == avatar.image,
                        savedCount: savedCount,
                        onSelect: {
                            if isUnlocked {
                                selectedAvatar = avatar.image
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 40)
        }
        .offset(y: 0)
        .opacity(1)
    }
    
    private func getFilteredAvatars() -> [AvatarInfo] {
        switch selectedFilter {
        case .all:
            return avatars
        case .unlocked:
            return avatars.filter { savedCount >= $0.unlocksAt }
        case .locked:
            return avatars.filter { savedCount < $0.unlocksAt }
        case .legendary:
            return avatars.filter { $0.rarity == .legendary }
        }
    }
    
    private var unlockedCount: Int {
        avatars.filter { savedCount >= $0.unlocksAt }.count
    }
    
    private var legendaryCount: Int {
        avatars.filter { savedCount >= $0.unlocksAt && $0.rarity == .legendary }.count
    }
    
    private func checkForNewUnlocks() {
        for avatar in avatars {
            if savedCount >= avatar.unlocksAt && avatar.unlocksAt > 0 {
                // Check if this is a new unlock (you might want to track this in UserDefaults)
                newlyUnlockedAvatar = avatar.name
                showUnlockAnimation = true
                break
            }
        }
    }
}

struct ProgressStatCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(color)
            }
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: color.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct EnhancedAvatarCardView: View {
    let avatar: AvatarInfo
    let unlocked: Bool
    let selected: Bool
    let savedCount: Int
    let onSelect: () -> Void
    @State private var isPressed = false
    var body: some View {
        Button(action: {
            if unlocked {
                isPressed = true
                onSelect()
                isPressed = false
            }
        }) {
            VStack(spacing: 0) {
                // Avatar image with effects
                ZStack {
                    if selected {
                        Circle()
                            .fill(Theme.accentColor.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .scaleEffect(1.2)
                            .blur(radius: 10)
                    }
                    Circle()
                        .fill(avatar.rarity.color.opacity(0.2))
                        .frame(width: 90, height: 90)
                    Image(avatar.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .scaleEffect(isPressed ? 1.1 : 1.0)
                        .opacity(unlocked ? 1.0 : 0.3)
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: avatar.rarity.icon)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(avatar.rarity.color)
                                .padding(6)
                                .background(
                                    Circle()
                                        .fill(Theme.cardBackground.opacity(0.8))
                                )
                        }
                        Spacer()
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                    if !unlocked {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.6))
                                .frame(width: 90, height: 90)
                            Image(systemName: "lock.fill")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.top, 20)
                VStack(spacing: 8) {
                    Text(avatar.name)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.3), radius: 5, x: 0, y: 2)
                    Text(avatar.description)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                    HStack(spacing: 4) {
                        Image(systemName: avatar.rarity.icon)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(avatar.rarity.color)
                        Text(avatar.rarity.rawValue)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(avatar.rarity.color)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(avatar.rarity.color.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(avatar.rarity.color.opacity(0.5), lineWidth: 1)
                            )
                    )
                    if !unlocked {
                        Text("Saves Needed: \(max(avatar.unlocksAt - savedCount, 0))")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundColor(Theme.amberColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Theme.amberColor.opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Theme.amberColor.opacity(0.5), lineWidth: 1)
                                    )
                            )
                    } else if selected {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Theme.successColor)
                            Text("Selected")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(Theme.successColor)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Theme.successColor.opacity(0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Theme.successColor.opacity(0.5), lineWidth: 1)
                                )
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Theme.cardBackground
                    LinearGradient(
                        gradient: Gradient(colors: [
                            avatar.rarity.color.opacity(0.1),
                            avatar.rarity.color.opacity(0.05),
                            avatar.rarity.color.opacity(0.1)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            )
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(selected ? Theme.accentColor : avatar.rarity.color.opacity(0.3), lineWidth: selected ? 3 : 1)
            )
            .shadow(color: selected ? Theme.accentColor.opacity(0.3) : avatar.rarity.color.opacity(0.2), radius: selected ? 15 : 10, x: 0, y: selected ? 8 : 5)
            .scaleEffect(1)
            .opacity(1)
            .offset(y: 0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG
struct AvatarGridPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AvatarGridPageView().environmentObject(AppViewModel())
        }
    }
}
#endif 
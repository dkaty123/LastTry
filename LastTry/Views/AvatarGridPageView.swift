import SwiftUI

struct AvatarInfo {
    let image: String
    let name: String
    let description: String
    let unlocksAt: Int
}

struct AvatarGridPageView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @AppStorage("userAvatar") private var selectedAvatar: String = "clearIcon"
    
    // 15 avatars, each unlocks at 0, 3, 6, 9, 12 saved
    let avatars: [AvatarInfo] = [
        AvatarInfo(image: "clearIcon", name: "Luna", description: "The curious explorer.", unlocksAt: 0),
        AvatarInfo(image: "clearIcon2", name: "Nova", description: "The cosmic leader.", unlocksAt: 0),
        AvatarInfo(image: "clearIcon3", name: "Chill", description: "The relaxed dreamer.", unlocksAt: 0),
        AvatarInfo(image: "clearIcon4", name: "Pixel", description: "The techy cat.", unlocksAt: 3),
        AvatarInfo(image: "clearIcon5", name: "Rocket", description: "Always on the move!", unlocksAt: 3),
        AvatarInfo(image: "clearIcon6", name: "Stella", description: "The shining star.", unlocksAt: 3),
        AvatarInfo(image: "clearIcon7", name: "Comet", description: "Fast and playful.", unlocksAt: 6),
        AvatarInfo(image: "clearIcon8", name: "Mochi", description: "Sweet and soft.", unlocksAt: 6),
        AvatarInfo(image: "clearIcon9", name: "Astro", description: "The space scientist.", unlocksAt: 6),
        AvatarInfo(image: "clearIcon10", name: "Shadow", description: "The mysterious one.", unlocksAt: 9),
        AvatarInfo(image: "clearIcon11", name: "Sunny", description: "Brings the sunshine.", unlocksAt: 9),
        AvatarInfo(image: "clearIcon12", name: "Milo", description: "The clever cat.", unlocksAt: 9),
        AvatarInfo(image: "clearIcon13", name: "Cosmo", description: "Galactic adventurer.", unlocksAt: 12),
        AvatarInfo(image: "clearIcon14", name: "Peach", description: "The gentle friend.", unlocksAt: 12),
        AvatarInfo(image: "clearIcon15", name: "Ziggy", description: "The wild card.", unlocksAt: 12)
    ]
    
    var savedCount: Int { viewModel.savedScholarships.count }
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: SplashMotionManager())
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
            ScrollView {
                VStack(spacing: 10) {
                    Text("Unlock Space Cats!")
                        .font(Font.custom("SF Pro Rounded", size: 32).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.bottom, 6)
                    Text("Saved Scholarships: \(savedCount)")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.yellow)
                        .padding(.bottom, 2)
                    Text("Tap an unlocked cat to select it as your profile avatar. Save scholarships to unlock more!")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    ForEach(avatars, id: \.image) { avatar in
                        let isUnlocked = savedCount >= avatar.unlocksAt
                        AvatarRowView(
                            avatar: avatar,
                            unlocked: isUnlocked,
                            selected: selectedAvatar == avatar.image,
                            savedCount: savedCount,
                            onSelect: {
                                if isUnlocked { selectedAvatar = avatar.image }
                            }
                        )
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isUnlocked)
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationTitle("Avatars")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AvatarRowView: View {
    let avatar: AvatarInfo
    let unlocked: Bool
    let selected: Bool
    let savedCount: Int
    let onSelect: () -> Void
    @State private var isPressed = false
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Yellow glow for selected
            if selected {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.45), Color.orange.opacity(0.25)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .blur(radius: 2)
                    .scaleEffect(1.08)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selected)
            }
            // Glassmorphic card (remove background outside rounded rect)
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.22), Color.pink.opacity(0.22)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.white.opacity(0.85), lineWidth: 2.5)
                )
                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 4)
            HStack(spacing: 18) {
                Image(avatar.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .scaleEffect(isPressed ? 1.08 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
                VStack(alignment: .leading, spacing: 6) {
                    Text(avatar.name)
                        .font(Font.custom("SF Pro Rounded", size: 18).weight(.bold))
                        .foregroundColor(.white)
                        .shadow(color: .purple.opacity(0.18), radius: 2, x: 0, y: 1)
                    Text(avatar.description)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                }
                Spacer()
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            // For locked avatars, show 'Saves Needed: X' in the top-right
            if !unlocked {
                Text("Saves Needed: \(max(avatar.unlocksAt - savedCount, 0))")
                    .font(.caption2.bold())
                    .foregroundColor(.yellow)
                    .padding(7)
                    .background(Color.black.opacity(0.65))
                    .clipShape(Capsule())
                    .offset(x: -12, y: 12)
            }
        }
        .frame(height: 100)
        .onTapGesture {
            if unlocked {
                withAnimation(.spring()) { isPressed = true }
                onSelect()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(180)) { isPressed = false }
            }
        }
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
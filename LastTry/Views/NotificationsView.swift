import SwiftUI

struct NotificationsView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.dismiss) private var dismiss
    @StateObject private var motion = SplashMotionManager()
    
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
                                Text("Notifications")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                                
                                Text("Stay updated with your scholarship journey")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Button(action: { viewModel.markAllAsRead() }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Theme.successColor)
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
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        // Enhanced Unread Count Card
                        HStack(spacing: 15) {
                            ZStack {
                                Circle()
                                    .fill(Theme.amberColor.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "bell.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(Theme.amberColor)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(viewModel.unreadCount)")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("Unread Notifications")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            // Notification status indicator
                            if viewModel.unreadCount > 0 {
                                Circle()
                                    .fill(Theme.amberColor)
                                    .frame(width: 12, height: 12)
                                    .shadow(color: Theme.amberColor.opacity(0.5), radius: 4, x: 0, y: 2)
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
                        .shadow(color: Theme.amberColor.opacity(0.2), radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 20)
                    }
                    
                    // Enhanced Type Filter
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .foregroundColor(Theme.accentColor)
                                .font(.title3)
                            
                            Text("Filter by Type")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                EnhancedTypeButton(
                                    title: "All",
                                    isSelected: viewModel.selectedType == nil,
                                    icon: "list.bullet",
                                    color: Theme.accentColor
                                ) {
                                    viewModel.filterNotifications(by: nil)
                                }
                                
                                ForEach(NotificationType.allCases, id: \.self) { type in
                                    EnhancedTypeButton(
                                        title: type.rawValue,
                                        isSelected: viewModel.selectedType == type,
                                        icon: type.icon,
                                        color: Color(type.color)
                                    ) {
                                        viewModel.filterNotifications(by: type)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Enhanced Notifications List
                    ScrollView {
                        if viewModel.filteredNotifications.isEmpty {
                            // Empty State
                            VStack(spacing: 25) {
                                ZStack {
                                    Circle()
                                        .fill(Theme.accentColor.opacity(0.1))
                                        .frame(width: 120, height: 120)
                                    
                                    Image(systemName: "bell.slash")
                                        .font(.system(size: 50, weight: .light))
                                        .foregroundColor(Theme.accentColor.opacity(0.7))
                                }
                                
                                VStack(spacing: 12) {
                                    Text("No notifications")
                                        .font(.system(size: 22, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("You're all caught up! Check back later for updates.")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.7))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 100)
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(Array(viewModel.filteredNotifications.enumerated()), id: \.element.id) { index, notification in
                                    EnhancedNotificationCard(notification: notification) {
                                        viewModel.markAsRead(notification)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 40)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct EnhancedTypeButton: View {
    let title: String
    let isSelected: Bool
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : color)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .white : .white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? color : Theme.cardBackground.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isSelected ? color : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                    )
            )
            .shadow(color: isSelected ? color.opacity(0.3) : Color.clear, radius: 8, x: 0, y: 4)
        }
    }
}

struct EnhancedNotificationCard: View {
    let notification: ScholarshipNotification
    let onRead: () -> Void
    
    var body: some View {
        Button(action: {
            onRead()
        }) {
            HStack(spacing: 16) {
                // Enhanced Icon
                ZStack {
                    Circle()
                        .fill(Color(notification.type.color).opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: notification.type.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(notification.type.color))
                }
                
                // Enhanced Content
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(notification.title)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .lineLimit(2)
                        
                        Spacer()
                        
                        // Enhanced Read Status
                        if !notification.isRead {
                            Circle()
                                .fill(Theme.amberColor)
                                .frame(width: 8, height: 8)
                                .shadow(color: Theme.amberColor.opacity(0.5), radius: 2, x: 0, y: 1)
                        }
                    }
                    
                    Text(notification.message)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(3)
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.5))
                        
                        Text(notification.timestamp, style: .relative)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                        
                        Spacer()
                        
                        // Notification type badge
                        Text(notification.type.rawValue)
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color(notification.type.color).opacity(0.3))
                            )
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Theme.cardBackground.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                    )
            )
            .shadow(color: Color(notification.type.color).opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NotificationsView()
} 
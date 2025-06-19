import SwiftUI

struct NotificationsView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Theme.primaryGradient
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Unread Count
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.yellow)
                    Text("\(viewModel.unreadCount) Unread")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black.opacity(0.3))
                )
                
                // Type Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        TypeButton(title: "All", isSelected: viewModel.selectedType == nil) {
                            viewModel.filterNotifications(by: nil)
                        }
                        
                        ForEach(NotificationType.allCases, id: \.self) { type in
                            TypeButton(
                                title: type.rawValue,
                                isSelected: viewModel.selectedType == type,
                                icon: type.icon,
                                color: type.color
                            ) {
                                viewModel.filterNotifications(by: type)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Notifications List
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.filteredNotifications) { notification in
                            NotificationCard(notification: notification) {
                                viewModel.markAsRead(notification)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Notifications")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.markAllAsRead() }) {
                    Text("Mark All Read")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct TypeButton: View {
    let title: String
    let isSelected: Bool
    var icon: String?
    var color: String?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(isSelected ? .black : Color(color ?? "white"))
                }
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundColor(isSelected ? .black : .white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.white : Color.black.opacity(0.3))
            )
        }
    }
}

struct NotificationCard: View {
    let notification: ScholarshipNotification
    let onRead: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon
            Image(systemName: notification.type.icon)
                .font(.system(size: 24))
                .foregroundColor(Color(notification.type.color))
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.3))
                )
            
            // Content
            VStack(alignment: .leading, spacing: 5) {
                Text(notification.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(notification.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            // Read Status
            if !notification.isRead {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 10, height: 10)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.3))
        )
        .onTapGesture {
            onRead()
        }
    }
}

extension NotificationType: CaseIterable {
    static var allCases: [NotificationType] = [
        .deadline,
        .newMatch,
        .status,
        .document,
        .system
    ]
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
} 
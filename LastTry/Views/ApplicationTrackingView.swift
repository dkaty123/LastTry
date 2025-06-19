import SwiftUI

struct ApplicationTrackingView: View {
    @StateObject private var viewModel = ApplicationTrackingViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Status Dashboard
                ApplicationStatusDashboardView(viewModel: viewModel)
                    .padding(.horizontal)
                
                // Progress and Analytics
                VStack(spacing: 20) {
                    ApplicationProgressView(viewModel: viewModel)
                    ApplicationAnalyticsView(viewModel: viewModel)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Theme.primaryGradient)
        .navigationTitle("Application Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Add new application action
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ApplicationTrackingView()
    }
} 
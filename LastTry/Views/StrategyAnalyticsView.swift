import SwiftUI

struct StrategyAnalyticsView: View {
    @StateObject private var applicationViewModel = ApplicationTrackingViewModel()
    @StateObject private var financialViewModel = FinancialPlanningViewModel()
    
    var body: some View {
        ZStack {
            Theme.primaryGradient.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    Text("Strategic Insights")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom, 10)

                    // Application Hotspots
                    DeadlineHeatmapView(applications: applicationViewModel.applications)
                        .padding(.horizontal)

                    // Category Analysis
                    
                    // "What If" Scenarios
                    FinancialScenarioView(viewModel: financialViewModel)
                        .padding(.horizontal)

                    Spacer()
                }
            }
        }
        .navigationTitle("Strategy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        StrategyAnalyticsView()
    }
} 
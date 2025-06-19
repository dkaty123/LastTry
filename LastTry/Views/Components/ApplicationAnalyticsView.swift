import SwiftUI

struct ApplicationAnalyticsView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    private var liveSuccessRate: Int {
        let total = viewModel.applications.count
        let successful = viewModel.applications.filter { $0.status == .accepted }.count
        return total > 0 ? Int((Double(successful) / Double(total)) * 100) : 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Success Analytics")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            VStack(spacing: 20) {
                AnalyticsCardView(
                    title: "Success Rate",
                    value: "\(liveSuccessRate)%",
                    icon: "chart.line.uptrend.xyaxis",
                    color: .green
                )
                
                AnalyticsCardView(
                    title: "Total Applications",
                    value: "\(viewModel.applications.count)",
                    icon: "doc.text.fill",
                    color: .blue
                )
                
                AnalyticsCardView(
                    title: "Pending Applications",
                    value: "\(viewModel.applications.filter { $0.status == .inProgress }.count)",
                    icon: "clock.fill",
                    color: .orange
                )
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
    }
}

struct AnalyticsCardView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(value)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
} 
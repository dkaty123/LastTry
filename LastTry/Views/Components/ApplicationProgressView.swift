import SwiftUI

struct ApplicationProgressView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Application Progress")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            VStack(spacing: 20) {
                ProgressBarView(
                    title: "Overall Progress",
                    progress: calculateOverallProgress(),
                    color: .blue
                )
                
                ProgressBarView(
                    title: "Document Completion",
                    progress: calculateDocumentProgress(),
                    color: .green
                )
                
                ProgressBarView(
                    title: "Milestone Completion",
                    progress: calculateMilestoneProgress(),
                    color: .orange
                )
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
    }
    
    private func calculateOverallProgress() -> Double {
        let total = Double(viewModel.applications.count)
        let completed = Double(viewModel.applications.filter { $0.status == .accepted || $0.status == .rejected }.count)
        return total > 0 ? (completed / total) * 100 : 0
    }
    
    private func calculateDocumentProgress() -> Double {
        let total = Double(viewModel.documents.count)
        let completed = Double(viewModel.documents.filter { $0.isUploaded }.count)
        return total > 0 ? (completed / total) * 100 : 0
    }
    
    private func calculateMilestoneProgress() -> Double {
        let total = Double(viewModel.milestones.count)
        let completed = Double(viewModel.milestones.filter { $0.isCompleted }.count)
        return total > 0 ? (completed / total) * 100 : 0
    }
}

struct ProgressBarView: View {
    let title: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(progress))%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(progress / 100), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
} 
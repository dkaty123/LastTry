import SwiftUI

struct ApplicationStatusDashboardView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @State private var statusCounts: [ApplicationStatus: Int] = [:]
    
    // Arrange 5 statuses in a 2-row grid (3 on top, 2 below)
    private var statusGrid: [[ApplicationStatus]] {
        let all = ApplicationStatus.allCases
        return [Array(all.prefix(3)), Array(all.suffix(2))]
    }
    
    var statusCountsArray: [[(status: ApplicationStatus, count: Int)]] {
        statusGrid.map { row in
            row.map { status in
                (status, viewModel.applications.filter { $0.status == status }.count)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Application Status")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            VStack(spacing: 20) {
                ForEach(0..<statusCountsArray.count, id: \.self) { row in
                    StatusRowView(statusCounts: statusCountsArray[row])
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
        .onAppear {
            // Initialize counts from the viewModel
            var initialCounts: [ApplicationStatus: Int] = [:]
            for status in ApplicationStatus.allCases {
                initialCounts[status] = viewModel.applications.filter { $0.status == status }.count
            }
            statusCounts = initialCounts
        }
    }
}

private struct StatusRowView: View {
    let statusCounts: [(status: ApplicationStatus, count: Int)]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(statusCounts, id: \.status) { item in
                StatusCellView(status: item.status, count: item.count)
            }
        }
    }
}

private struct StatusCellView: View {
    let status: ApplicationStatus
    let count: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(count)")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
            Text(status.rawValue)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, minHeight: 90)
        .padding()
        .background(status.color.opacity(0.2))
        .cornerRadius(15)
    }
}

struct StatusAddSheet: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    let status: ApplicationStatus
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.applications.filter { $0.status != status }) { application in
                    Button(action: {
                        viewModel.updateApplicationStatus(application, status: status)
                        dismiss()
                    }) {
                        HStack {
                            Text(application.scholarshipName)
                            Spacer()
                            Text(application.status.rawValue)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Move to \(status.rawValue)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

struct StatusRemoveSheet: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    let status: ApplicationStatus
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.applications.filter { $0.status == status }) { application in
                    Menu {
                        ForEach(ApplicationStatus.allCases.filter { $0 != status }, id: \.self) { newStatus in
                            Button(action: {
                                viewModel.updateApplicationStatus(application, status: newStatus)
                                dismiss()
                            }) {
                                Text("Move to \(newStatus.rawValue)")
                            }
                        }
                    } label: {
                        HStack {
                            Text(application.scholarshipName)
                            Spacer()
                            Text(application.status.rawValue)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Move from \(status.rawValue)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
} 
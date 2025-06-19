import SwiftUI

struct ApplicationMilestoneView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @State private var showAddSheet = false
    @State private var editingMilestone: ApplicationMilestone? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Milestone Tracking")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                Button(action: { showAddSheet = true }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }
            
            List {
                ForEach(Array(viewModel.milestones.sorted(by: { $0.dueDate < $1.dueDate })), id: \.id) { milestone in
                    Button(action: { editingMilestone = milestone }) {
                        MilestoneItemView(milestone: milestone)
                    }
                    .listRowBackground(Color.clear)
                }
                .onDelete { indexSet in
                    let sorted = Array(viewModel.milestones.sorted(by: { $0.dueDate < $1.dueDate }))
                    for index in indexSet {
                        let milestone = sorted[index]
                        viewModel.deleteMilestone(milestone)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: 300)
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
        .sheet(isPresented: $showAddSheet) {
            MilestoneEditSheet(viewModel: viewModel, milestone: nil)
        }
        .sheet(item: $editingMilestone) { milestone in
            MilestoneEditSheet(viewModel: viewModel, milestone: milestone)
        }
        .onChange(of: editingMilestone) { newValue in
            if newValue == nil {
                // Force a refresh if needed
            }
        }
    }
}

struct MilestoneItemView: View {
    let milestone: ApplicationMilestone
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(milestone.isCompleted ? .green : .white.opacity(0.5))
                
                Text(milestone.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(milestone.dueDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Text(milestone.description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .padding(.leading, 25)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

struct MilestoneEditSheet: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var description: String
    @State private var dueDate: Date
    @State private var isCompleted: Bool
    let milestone: ApplicationMilestone?
    
    init(viewModel: ApplicationTrackingViewModel, milestone: ApplicationMilestone?) {
        self.viewModel = viewModel
        self.milestone = milestone
        _title = State(initialValue: milestone?.title ?? "")
        _description = State(initialValue: milestone?.description ?? "")
        _dueDate = State(initialValue: milestone?.dueDate ?? Date())
        _isCompleted = State(initialValue: milestone?.isCompleted ?? false)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                Toggle("Completed", isOn: $isCompleted)
            }
            .navigationTitle(milestone == nil ? "Add Milestone" : "Edit Milestone")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let milestone = milestone {
                            viewModel.updateMilestone(ApplicationMilestone(id: milestone.id, title: title, description: description, dueDate: dueDate, isCompleted: isCompleted))
                        } else {
                            viewModel.addMilestone(ApplicationMilestone(title: title, description: description, dueDate: dueDate, isCompleted: isCompleted))
                        }
                        dismiss()
                    }
                }
            }
        }
    }
} 
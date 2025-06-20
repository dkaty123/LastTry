import SwiftUI

struct ApplicationTimelineView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @State private var showAddSheet = false
    @State private var editingApplication: ScholarshipApplication? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Application Timeline")
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
                ForEach(Array(viewModel.applications.sorted(by: { $0.deadline < $1.deadline })), id: \.id) { application in
                    Button(action: { editingApplication = application }) {
                        TimelineItemView(application: application)
                    }
                    .listRowBackground(Color.clear)
                }
                .onDelete { indexSet in
                    let sorted = Array(viewModel.applications.sorted(by: { $0.deadline < $1.deadline }))
                    for index in indexSet {
                        let application = sorted[index]
                        viewModel.deleteApplication(application)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: 350)
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
        .sheet(isPresented: $showAddSheet) {
            ApplicationEditSheet(viewModel: viewModel, application: nil)
        }
        .sheet(item: $editingApplication) { application in
            ApplicationEditSheet(viewModel: viewModel, application: application)
        }
    }
}

struct TimelineItemView: View {
    let application: ScholarshipApplication
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 15) {
                Circle()
                    .fill(application.status.color)
                    .frame(width: 12, height: 12)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(application.scholarshipName)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(application.deadline, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                Button(action: { withAnimation { isExpanded.toggle() } }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                        .background(Color.white.opacity(0.3))
                    
                    HStack {
                        Text("Status:")
                            .foregroundColor(.white.opacity(0.8))
                        Text(application.status.rawValue)
                            .foregroundColor(application.status.color)
                            .bold()
                    }
                    
                    Text("Documents Required:")
                        .foregroundColor(.white.opacity(0.8))
                    
                    ForEach(application.documents) { document in
                        HStack {
                            Image(systemName: document.isUploaded ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(document.isUploaded ? .green : .white.opacity(0.5))
                            
                            Text(document.type.rawValue)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            if !document.isUploaded {
                                Button(action: {
                                    // Upload document action
                                }) {
                                    Text("Upload")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.3))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ApplicationEditSheet: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var scholarshipName: String
    @State private var status: ApplicationStatus
    @State private var deadline: Date
    let application: ScholarshipApplication?
    
    init(viewModel: ApplicationTrackingViewModel, application: ScholarshipApplication?) {
        self.viewModel = viewModel
        self.application = application
        _scholarshipName = State(initialValue: application?.scholarshipName ?? "")
        _status = State(initialValue: application?.status ?? .notStarted)
        _deadline = State(initialValue: application?.deadline ?? Date())
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Scholarship Name", text: $scholarshipName)
                Picker("Status", selection: $status) {
                    ForEach(ApplicationStatus.allCases, id: \.self) { s in
                        Text(s.rawValue).tag(s)
                    }
                }
                DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
            }
            .navigationTitle(application == nil ? "Add Application" : "Edit Application")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let application = application {
                            viewModel.updateApplication(ScholarshipApplication(id: application.id, scholarshipName: scholarshipName, status: status, deadline: deadline, category: application.category, documents: application.documents, milestones: application.milestones))
                        } else {
                            viewModel.addApplication(ScholarshipApplication(scholarshipName: scholarshipName, status: status, deadline: deadline, category: .general))
                        }
                        dismiss()
                    }
                }
            }
        }
    }
} 
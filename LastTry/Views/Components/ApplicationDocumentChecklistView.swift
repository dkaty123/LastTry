import SwiftUI

struct ApplicationDocumentChecklistView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @State private var showAddSheet = false
    @State private var editingDocument: ApplicationDocument? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Document Checklist")
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
                ForEach(DocumentType.allCases, id: \.self) { type in
                    Section(header: Text(type.rawValue).foregroundColor(.white)) {
                        ForEach(viewModel.documents.filter { $0.type == type }, id: \.id) { document in
                            Button(action: { editingDocument = document }) {
                                DocumentChecklistItemView(document: document)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            let docs = viewModel.documents.filter { $0.type == type }
                            for index in indexSet {
                                let document = docs[index]
                                viewModel.deleteDocument(document)
                            }
                        }
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
            DocumentEditSheet(viewModel: viewModel, document: nil)
        }
        .sheet(item: $editingDocument) { document in
            DocumentEditSheet(viewModel: viewModel, document: document)
        }
    }
}

struct DocumentChecklistItemView: View {
    let document: ApplicationDocument
    
    var body: some View {
        HStack {
            Image(systemName: document.isUploaded ? "checkmark.circle.fill" : "circle")
                .foregroundColor(document.isUploaded ? .green : .white.opacity(0.5))
            
            Text(document.name)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Spacer()
            
            if let date = document.uploadDate {
                Text(date, style: .date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding(.leading)
    }
}

struct DocumentEditSheet: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var type: DocumentType
    @State private var isUploaded: Bool
    @State private var uploadDate: Date?
    @State private var uploadDateValue: Date
    let document: ApplicationDocument?
    
    init(viewModel: ApplicationTrackingViewModel, document: ApplicationDocument?) {
        self.viewModel = viewModel
        self.document = document
        _name = State(initialValue: document?.name ?? "")
        _type = State(initialValue: document?.type ?? .other)
        _isUploaded = State(initialValue: document?.isUploaded ?? false)
        _uploadDate = State(initialValue: document?.uploadDate)
        _uploadDateValue = State(initialValue: document?.uploadDate ?? Date())
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(DocumentType.allCases, id: \.self) { t in
                        Text(t.rawValue).tag(t)
                    }
                }
                Toggle("Uploaded", isOn: $isUploaded)
                if isUploaded {
                    DatePicker("Upload Date", selection: $uploadDateValue, displayedComponents: .date)
                }
            }
            .navigationTitle(document == nil ? "Add Document" : "Edit Document")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let finalUploadDate = isUploaded ? uploadDateValue : nil
                        if let document = document {
                            viewModel.updateDocument(ApplicationDocument(id: document.id, name: name, type: type, isUploaded: isUploaded, uploadDate: finalUploadDate))
                        } else {
                            viewModel.addDocument(ApplicationDocument(name: name, type: type, isUploaded: isUploaded, uploadDate: finalUploadDate))
                        }
                        dismiss()
                    }
                }
            }
        }
    }
} 
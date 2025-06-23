import SwiftUI

struct EssayDetailView: View {
    let essay: Essay
    @ObservedObject var viewModel: AIEssayAssistantViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var editedContent: String
    @State private var showingSuggestions = false
    @State private var showingPlagiarismResults = false
    
    init(essay: Essay, viewModel: AIEssayAssistantViewModel) {
        self.essay = essay
        self.viewModel = viewModel
        self._editedContent = State(initialValue: essay.content)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    contentView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        saveChanges()
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Polish with AI") {
                            Task {
                                await viewModel.polishEssay(essay)
                            }
                        }
                        
                        Button("Check Plagiarism") {
                            viewModel.checkPlagiarism()
                            showingPlagiarismResults = true
                        }
                        
                        Button("Export as PDF") {
                            exportAsPDF()
                        }
                        
                        Button("Share", role: .none) {
                            shareEssay()
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(essay.title)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Text(essay.scholarshipName)
                        .font(.subheadline)
                        .foregroundColor(Theme.accentColor)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(essay.status.rawValue)
                        .font(.caption.bold())
                        .foregroundColor(statusColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(statusColor.opacity(0.2))
                        .cornerRadius(8)
                    
                    Text("\(essay.wordCount) words")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            // AI Suggestions Button
            if !essay.aiSuggestions.isEmpty {
                Button(action: { showingSuggestions = true }) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.yellow)
                        Text("\(essay.aiSuggestions.count) AI Suggestions")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                }
            }
        }
        .padding()
    }
    
    private var contentView: some View {
        VStack {
            HStack {
                Text("Essay Content")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button("Apply All Suggestions") {
                    applyAllSuggestions()
                }
                .font(.caption)
                .foregroundColor(Theme.accentColor)
                .opacity(essay.aiSuggestions.isEmpty ? 0 : 1)
            }
            .padding(.horizontal)
            
            ScrollView {
                TextEditor(text: $editedContent)
                    .frame(minHeight: 400)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
    
    private var statusColor: Color {
        switch essay.status {
        case .draft:
            return .orange
        case .polished:
            return .green
        case .final:
            return .blue
        }
    }
    
    private func saveChanges() {
        var updatedEssay = essay
        updatedEssay.content = editedContent
        updatedEssay.lastModified = Date()
        viewModel.updateEssay(updatedEssay)
    }
    
    private func applyAllSuggestions() {
        // Apply all AI suggestions to the content
        var newContent = editedContent
        
        for suggestion in essay.aiSuggestions where !suggestion.applied {
            // In a real implementation, this would intelligently apply suggestions
            newContent += "\n\n[Applied: \(suggestion.content)]"
        }
        
        editedContent = newContent
    }
    
    private func exportAsPDF() {
        // Export essay as PDF
        // Implementation would use PDFKit
    }
    
    private func shareEssay() {
        // Share essay content
        // Implementation would use UIActivityViewController
    }
}

struct AISuggestionsView: View {
    let suggestions: [AISuggestion]
    let onApplySuggestion: (AISuggestion) -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(suggestions) { suggestion in
                            AISuggestionCard(suggestion: suggestion) {
                                onApplySuggestion(suggestion)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("AI Suggestions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AISuggestionCard: View {
    let suggestion: AISuggestion
    let onApply: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: iconForType(suggestion.type))
                    .foregroundColor(colorForType(suggestion.type))
                    .font(.title3)
                
                Text(suggestion.type.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(suggestion.confidence * 100))%")
                    .font(.caption.bold())
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Text(suggestion.content)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                Spacer()
                
                Button(action: onApply) {
                    Text("Apply Suggestion")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Theme.accentColor.opacity(0.3))
                        .cornerRadius(8)
                }
                .disabled(suggestion.applied)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private func iconForType(_ type: AISuggestion.SuggestionType) -> String {
        switch type {
        case .hook:
            return "quote.bubble"
        case .rewrite:
            return "pencil.and.outline"
        case .edit:
            return "checkmark.circle"
        case .tone:
            return "textformat.abc"
        case .structure:
            return "list.bullet"
        }
    }
    
    private func colorForType(_ type: AISuggestion.SuggestionType) -> Color {
        switch type {
        case .hook:
            return .yellow
        case .rewrite:
            return .blue
        case .edit:
            return .green
        case .tone:
            return .purple
        case .structure:
            return .orange
        }
    }
}

#Preview {
    let sampleEssay = Essay(
        title: "Sample Essay",
        content: "This is a sample essay content...",
        scholarshipName: "Sample Scholarship",
        wordCount: 500
    )
    
    EssayDetailView(essay: sampleEssay, viewModel: AIEssayAssistantViewModel())
} 
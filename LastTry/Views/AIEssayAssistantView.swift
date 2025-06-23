import SwiftUI

struct AIEssayAssistantView: View {
    @StateObject private var viewModel = AIEssayAssistantViewModel()
    @State private var selectedEssay: Essay?
    @State private var showNewEssaySheet = false
    @State private var showEssayDetail = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    quickActionsView
                    essaysListView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showNewEssaySheet) {
                NewEssaySheet(viewModel: viewModel)
            }
            .sheet(isPresented: $showEssayDetail) {
                if let essay = selectedEssay {
                    EssayDetailView(essay: essay, viewModel: viewModel)
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 32))
                    .foregroundColor(Theme.accentColor)
                Text("AI Essay Assistant")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            }
            
            Text("Generate, polish, and perfect your scholarship essays")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 32)
        .padding(.bottom, 20)
    }
    
    private var quickActionsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                QuickActionButton(
                    title: "New Essay",
                    icon: "plus.circle",
                    color: .green,
                    action: { showNewEssaySheet = true }
                )
                
                QuickActionButton(
                    title: "Polish Existing",
                    icon: "wand.and.stars",
                    color: .blue,
                    action: { viewModel.showPolishMode = true }
                )
                
                QuickActionButton(
                    title: "Check Plagiarism",
                    icon: "checkmark.shield",
                    color: .orange,
                    action: { viewModel.checkPlagiarism() }
                )
                
                QuickActionButton(
                    title: "Tone Match",
                    icon: "textformat.abc",
                    color: .purple,
                    action: { viewModel.showToneMatching = true }
                )
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
    }
    
    private var essaysListView: some View {
        VStack {
            HStack {
                Text("Your Essays")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                if !viewModel.essays.isEmpty {
                    Button("Clear All") {
                        viewModel.clearAllEssays()
                    }
                    .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal)
            
            if viewModel.essays.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.essays) { essay in
                            EssayCardView(essay: essay) {
                                selectedEssay = essay
                                showEssayDetail = true
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "brain.head.profile")
                .font(.system(size: 60))
                .foregroundColor(Theme.accentColor.opacity(0.7))
            
            Text("No essays yet")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Text("Create your first AI-powered essay")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
            
            Button("Create Essay") {
                showNewEssaySheet = true
            }
            .foregroundColor(.white)
            .padding()
            .background(Theme.accentColor.opacity(0.3))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.5)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                
                Text(title)
                    .font(.caption.bold())
                    .foregroundColor(.white)
            }
        }
    }
}

struct EssayCardView: View {
    let essay: Essay
    let onTap: () -> Void
    @State private var isExpanded = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(essay.title)
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .lineLimit(2)
                        
                        Text(essay.scholarshipName)
                            .font(.caption)
                            .foregroundColor(Theme.accentColor)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(essay.createdDate, style: .date)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.shield.fill")
                                .font(.caption2)
                                .foregroundColor(essay.plagiarismChecked ? .green : .gray)
                            
                            Text(essay.plagiarismChecked ? "Checked" : "Unchecked")
                                .font(.caption2)
                                .foregroundColor(essay.plagiarismChecked ? .green : .gray)
                        }
                    }
                }
                
                Text(essay.content)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(isExpanded ? nil : 3)
                
                HStack {
                    Text("\(essay.wordCount) words")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                    
                    Spacer()
                    
                    Text(essay.status.rawValue)
                        .font(.caption.bold())
                        .foregroundColor(statusColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(statusColor.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
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
}

struct NewEssaySheet: View {
    @ObservedObject var viewModel: AIEssayAssistantViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var scholarshipName = ""
    @State private var prompt = ""
    @State private var tone = "Professional"
    @State private var wordLimit = 500
    @State private var isGenerating = false
    
    private let tones = ["Professional", "Personal", "Creative", "Academic", "Inspirational"]
    private let wordLimits = [250, 500, 750, 1000, 1500]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Essay Details
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Essay Details")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Essay Title", text: $title)
                                .textFieldStyle(CosmicTextFieldStyle())
                            
                            TextField("Scholarship Name", text: $scholarshipName)
                                .textFieldStyle(CosmicTextFieldStyle())
                        }
                        
                        // Tone and Length
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Style & Length")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("Tone:")
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Picker("Tone", selection: $tone) {
                                    ForEach(tones, id: \.self) { tone in
                                        Text(tone).tag(tone)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack {
                                Text("Word Limit:")
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Picker("Word Limit", selection: $wordLimit) {
                                    ForEach(wordLimits, id: \.self) { limit in
                                        Text("\(limit)").tag(limit)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        
                        // Prompt
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Essay Prompt")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $prompt)
                                .frame(minHeight: 120)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                        }
                        
                        // Generate Button
                        Button(action: generateEssay) {
                            HStack {
                                if isGenerating {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Image(systemName: "wand.and.stars")
                                }
                                Text(isGenerating ? "Generating..." : "Generate Essay")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accentColor.opacity(0.3))
                            .cornerRadius(12)
                        }
                        .disabled(isGenerating || prompt.isEmpty)
                    }
                    .padding()
                }
            }
            .navigationTitle("New Essay")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    private func generateEssay() {
        isGenerating = true
        
        // Simulate AI generation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let newEssay = Essay(
                title: title.isEmpty ? "Untitled Essay" : title,
                content: generateSampleEssay(prompt: prompt, tone: tone, wordLimit: wordLimit),
                scholarshipName: scholarshipName.isEmpty ? "General Scholarship" : scholarshipName,
                status: .draft,
                plagiarismChecked: false,
                wordCount: wordLimit,
                createdDate: Date()
            )
            
            viewModel.addEssay(newEssay)
            isGenerating = false
            dismiss()
        }
    }
    
    private func generateSampleEssay(prompt: String, tone: String, wordLimit: Int) -> String {
        // This would integrate with GPT-4 Turbo in a real implementation
        return """
        This is a sample AI-generated essay based on your prompt: "\(prompt)"
        
        The essay is written in a \(tone.lowercased()) tone and targets approximately \(wordLimit) words.
        
        In a real implementation, this would be generated by GPT-4 Turbo with proper context about the scholarship, your background, and the specific requirements.
        
        The AI would analyze the prompt, understand the scholarship's values and requirements, and craft a compelling narrative that highlights your strengths while addressing the specific question or topic.
        """
    }
}

struct CosmicTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
            .foregroundColor(.white)
    }
}

#Preview {
    AIEssayAssistantView()
} 
import Foundation
import Combine

class AIEssayAssistantViewModel: ObservableObject {
    @Published var essays: [Essay] = []
    @Published var showPolishMode = false
    @Published var showToneMatching = false
    @Published var isGenerating = false
    @Published var isCheckingPlagiarism = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadEssays()
    }
    
    func addEssay(_ essay: Essay) {
        essays.append(essay)
        saveEssays()
    }
    
    func updateEssay(_ essay: Essay) {
        if let index = essays.firstIndex(where: { $0.id == essay.id }) {
            essays[index] = essay
            saveEssays()
        }
    }
    
    func deleteEssay(_ essay: Essay) {
        essays.removeAll { $0.id == essay.id }
        saveEssays()
    }
    
    func clearAllEssays() {
        essays.removeAll()
        saveEssays()
    }
    
    func generateEssay(prompt: String, tone: String, wordLimit: Int, scholarshipName: String) async -> Essay? {
        await MainActor.run {
            isGenerating = true
        }
        
        // Simulate API call delay
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        // In a real implementation, this would call GPT-4 Turbo API
        let generatedContent = await generateWithAI(prompt: prompt, tone: tone, wordLimit: wordLimit)
        
        await MainActor.run {
            isGenerating = false
            
            if let content = generatedContent {
                let essay = Essay(
                    title: "AI Generated Essay",
                    content: content,
                    scholarshipName: scholarshipName,
                    status: .draft,
                    wordCount: wordLimit
                )
                addEssay(essay)
            }
        }
        
        return nil
    }
    
    func polishEssay(_ essay: Essay) async -> Essay? {
        await MainActor.run {
            isGenerating = true
        }
        
        // Simulate AI polishing
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        let polishedContent = await polishWithAI(essay.content)
        let suggestions = await generateSuggestions(for: essay)
        
        await MainActor.run {
            isGenerating = false
            
            var updatedEssay = essay
            updatedEssay.content = polishedContent
            updatedEssay.status = .polished
            updatedEssay.aiSuggestions = suggestions
            updatedEssay.lastModified = Date()
            
            updateEssay(updatedEssay)
        }
        
        return nil
    }
    
    func checkPlagiarism() {
        isCheckingPlagiarism = true
        
        // Simulate plagiarism check
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isCheckingPlagiarism = false
            // In real implementation, this would call Turnitin or Copyscape API
        }
    }
    
    func matchTone(for essay: Essay, targetTone: String) async -> Essay? {
        await MainActor.run {
            isGenerating = true
        }
        
        // Simulate tone matching
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let toneMatchedContent = await matchToneWithAI(essay.content, targetTone: targetTone)
        
        await MainActor.run {
            isGenerating = false
            
            var updatedEssay = essay
            updatedEssay.content = toneMatchedContent
            updatedEssay.lastModified = Date()
            
            updateEssay(updatedEssay)
        }
        
        return nil
    }
    
    // MARK: - Private Methods
    
    private func generateWithAI(prompt: String, tone: String, wordLimit: Int) async -> String? {
        // This would integrate with GPT-4 Turbo API
        return """
        Based on the prompt: "\(prompt)"
        
        Here is a \(tone.lowercased()) essay targeting \(wordLimit) words:
        
        [AI-generated content would appear here with proper formatting, structure, and compelling narrative that addresses the specific scholarship requirements and showcases the student's strengths.]
        
        The essay would be tailored to the scholarship's values, requirements, and the specific prompt provided.
        """
    }
    
    private func polishWithAI(_ content: String) async -> String {
        // This would use GPT-4 Turbo to improve the essay
        return content + "\n\n[AI polishing would improve grammar, flow, and impact while maintaining the original message.]"
    }
    
    private func generateSuggestions(for essay: Essay) async -> [AISuggestion] {
        // This would generate AI suggestions for improvement
        return [
            AISuggestion(type: .hook, content: "Consider starting with a compelling anecdote", confidence: 0.85),
            AISuggestion(type: .structure, content: "Add a stronger transition between paragraphs", confidence: 0.78),
            AISuggestion(type: .tone, content: "Make the conclusion more inspiring", confidence: 0.92)
        ]
    }
    
    private func matchToneWithAI(_ content: String, targetTone: String) async -> String {
        // This would adjust the tone using AI
        return content + "\n\n[Tone adjusted to be more \(targetTone.lowercased())]"
    }
    
    private func saveEssays() {
        // Save to UserDefaults or Core Data
        if let encoded = try? JSONEncoder().encode(essays) {
            UserDefaults.standard.set(encoded, forKey: "savedEssays")
        }
    }
    
    private func loadEssays() {
        // Load from UserDefaults or Core Data
        if let data = UserDefaults.standard.data(forKey: "savedEssays"),
           let decoded = try? JSONDecoder().decode([Essay].self, from: data) {
            essays = decoded
        }
    }
} 
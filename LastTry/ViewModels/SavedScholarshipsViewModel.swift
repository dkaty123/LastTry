import Foundation

class SavedScholarshipsViewModel: ObservableObject {
    @Published var savedScholarships: [Scholarship] = []
    
    init() {
        loadSavedScholarships()
    }
    
    private func loadSavedScholarships() {
        // TODO: Load from persistence
    }
    
    func removeScholarship(_ scholarship: Scholarship) {
        if let index = savedScholarships.firstIndex(where: { $0.id == scholarship.id }) {
            savedScholarships.remove(at: index)
            // TODO: Update persistence
        }
    }
    
    func clearAllScholarships() {
        savedScholarships.removeAll()
        // TODO: Update persistence
    }
} 
import Foundation
import Combine

class SmartSearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [Scholarship] = []
    @Published var recentSearches: [String] = []
    @Published var popularSearches: [String] = []
    @Published var isSearching: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let allScholarships: [Scholarship]
    
    init() {
        // Load all scholarships from ScholarshipData
        self.allScholarships = ScholarshipData.convertAndAddScholarships()
        setupSearchSubscription()
        loadPopularSearches()
    }
    
    private func setupSearchSubscription() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    public func performSearch(query: String) {
        searchQuery = query
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        isSearching = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            // Search through all scholarships
            self.searchResults = self.allScholarships.filter { scholarship in
                scholarship.name.localizedCaseInsensitiveContains(query) ||
                scholarship.description.localizedCaseInsensitiveContains(query) ||
                scholarship.category.rawValue.localizedCaseInsensitiveContains(query) ||
                scholarship.requirements.contains { requirement in
                    requirement.localizedCaseInsensitiveContains(query)
                }
            }
            
            self.isSearching = false
            
            if !query.isEmpty {
                self.addToRecentSearches(query)
            }
        }
    }
    
    private func addToRecentSearches(_ query: String) {
        if !recentSearches.contains(query) {
            recentSearches.insert(query, at: 0)
            if recentSearches.count > 5 {
                recentSearches.removeLast()
            }
        }
    }
    
    private func loadPopularSearches() {
        // Broader category-based popular searches
        popularSearches = [
            "STEM",
            "Business",
            "Technology",
            "Arts",
            "Engineering",
            "Medicine",
            "Law",
            "Education"
        ]
    }
    
    func clearSearch() {
        searchQuery = ""
        searchResults = []
    }
} 
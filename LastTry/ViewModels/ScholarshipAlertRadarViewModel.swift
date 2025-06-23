import Foundation
import Combine

class ScholarshipAlertRadarViewModel: ObservableObject {
    @Published var alerts: [ScholarshipAlert] = []
    @Published var isScanning = false
    @Published var lastScanTime = Date()
    @Published var alertSettings = AlertSettings()
    
    private var cancellables = Set<AnyCancellable>()
    private var scanTimer: Timer?
    
    var todayAlerts: Int {
        let calendar = Calendar.current
        return alerts.filter { calendar.isDateInToday($0.createdTime) }.count
    }
    
    var weekAlerts: Int {
        let calendar = Calendar.current
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return alerts.filter { $0.createdTime >= weekAgo }.count
    }
    
    var matchRate: Int {
        guard !alerts.isEmpty else { return 0 }
        let averageMatch = alerts.map { $0.matchPercentage }.reduce(0, +) / Double(alerts.count)
        return Int(averageMatch)
    }
    
    init() {
        loadAlerts()
        loadSettings()
        startScanning()
    }
    
    func startScanning() {
        isScanning = true
        lastScanTime = Date()
        
        // Simulate scanning for new scholarships
        scanTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            self?.performScan()
        }
    }
    
    func stopScanning() {
        isScanning = false
        scanTimer?.invalidate()
        scanTimer = nil
    }
    
    func performScan() {
        // Simulate finding new scholarships
        let newAlerts = generateSampleAlerts()
        
        DispatchQueue.main.async {
            self.alerts.insert(contentsOf: newAlerts, at: 0)
            self.lastScanTime = Date()
            self.saveAlerts()
        }
    }
    
    func markAsRead(_ alert: ScholarshipAlert) {
        if let index = alerts.firstIndex(where: { $0.id == alert.id }) {
            alerts[index].isRead = true
            saveAlerts()
        }
    }
    
    func markAllAsRead() {
        for index in alerts.indices {
            alerts[index].isRead = true
        }
        saveAlerts()
    }
    
    func deleteAlert(_ alert: ScholarshipAlert) {
        alerts.removeAll { $0.id == alert.id }
        saveAlerts()
    }
    
    func updateSettings(_ settings: AlertSettings) {
        alertSettings = settings
        saveSettings()
    }
    
    // MARK: - Private Methods
    
    private func generateSampleAlerts() -> [ScholarshipAlert] {
        let sampleAlerts = [
            ScholarshipAlert(
                scholarshipName: "STEM Innovation Award",
                amount: 10000,
                description: "New STEM scholarship for innovative projects",
                deadline: Date().addingTimeInterval(86400 * 4),
                matchPercentage: 94,
                urgency: .high,
                isUrgent: true
            ),
            ScholarshipAlert(
                scholarshipName: "Community Leadership Grant",
                amount: 5000,
                description: "Leadership-focused scholarship opportunity",
                deadline: Date().addingTimeInterval(86400 * 14),
                matchPercentage: 87,
                urgency: .medium
            ),
            ScholarshipAlert(
                scholarshipName: "Arts Excellence Scholarship",
                amount: 7500,
                description: "Creative arts scholarship for talented students",
                deadline: Date().addingTimeInterval(86400 * 21),
                matchPercentage: 76,
                urgency: .low
            )
        ]
        
        return sampleAlerts
    }
    
    private func saveAlerts() {
        if let encoded = try? JSONEncoder().encode(alerts) {
            UserDefaults.standard.set(encoded, forKey: "savedAlerts")
        }
    }
    
    private func loadAlerts() {
        if let data = UserDefaults.standard.data(forKey: "savedAlerts"),
           let decoded = try? JSONDecoder().decode([ScholarshipAlert].self, from: data) {
            alerts = decoded
        }
    }
    
    private func saveSettings() {
        if let encoded = try? JSONEncoder().encode(alertSettings) {
            UserDefaults.standard.set(encoded, forKey: "alertSettings")
        }
    }
    
    private func loadSettings() {
        if let data = UserDefaults.standard.data(forKey: "alertSettings"),
           let decoded = try? JSONDecoder().decode(AlertSettings.self, from: data) {
            alertSettings = decoded
        }
    }
}

struct AlertSettings: Codable {
    var minAmount: Double = 1000
    var maxAmount: Double = 50000
    var categories: Set<Scholarship.ScholarshipCategory> = []
    var urgencyLevels: Set<ScholarshipAlert.UrgencyLevel> = [.high, .medium]
    var pushNotifications: Bool = true
    var emailNotifications: Bool = false
    var scanFrequency: ScanFrequency = .every30Minutes
    
    enum ScanFrequency: String, Codable, CaseIterable {
        case every15Minutes = "Every 15 minutes"
        case every30Minutes = "Every 30 minutes"
        case everyHour = "Every hour"
        case every3Hours = "Every 3 hours"
        case daily = "Daily"
    }
} 
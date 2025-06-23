import SwiftUI

struct AlertRadarSettingsView: View {
    @ObservedObject var viewModel: ScholarshipAlertRadarViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var settings: AlertSettings
    
    init(viewModel: ScholarshipAlertRadarViewModel) {
        self.viewModel = viewModel
        self._settings = State(initialValue: viewModel.alertSettings)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        headerView
                        amountRangeSection
                        categoriesSection
                        urgencySection
                        notificationsSection
                        scanFrequencySection
                        saveButton
                    }
                    .padding()
                }
            }
            .navigationTitle("Alert Settings")
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
    
    private var headerView: some View {
        VStack(spacing: 12) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 40))
                .foregroundColor(Theme.accentColor)
            
            Text("Configure Your Alert Radar")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Text("Customize what scholarships you want to be notified about")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }
    
    private var amountRangeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Amount Range")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 16) {
                HStack {
                    Text("Minimum:")
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Text("$\(Int(settings.minAmount))")
                        .foregroundColor(.white)
                }
                
                Slider(value: $settings.minAmount, in: 0...50000, step: 1000)
                    .accentColor(Theme.accentColor)
                
                HStack {
                    Text("Maximum:")
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Text("$\(Int(settings.maxAmount))")
                        .foregroundColor(.white)
                }
                
                Slider(value: $settings.maxAmount, in: 0...100000, step: 1000)
                    .accentColor(Theme.accentColor)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Categories")
                .font(.headline)
                .foregroundColor(.white)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                ForEach(Scholarship.ScholarshipCategory.allCases, id: \.self) { category in
                    CategoryToggleButton(
                        title: category.rawValue.capitalized,
                        isSelected: settings.categories.contains(category),
                        action: {
                            if settings.categories.contains(category) {
                                settings.categories.remove(category)
                            } else {
                                settings.categories.insert(category)
                            }
                        }
                    )
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var urgencySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Urgency Levels")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 8) {
                ForEach(ScholarshipAlert.UrgencyLevel.allCases, id: \.self) { level in
                    UrgencyToggleButton(
                        urgency: level,
                        isSelected: settings.urgencyLevels.contains(level),
                        action: {
                            if settings.urgencyLevels.contains(level) {
                                settings.urgencyLevels.remove(level)
                            } else {
                                settings.urgencyLevels.insert(level)
                            }
                        }
                    )
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var notificationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notifications")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 16) {
                Toggle("Push Notifications", isOn: $settings.pushNotifications)
                    .foregroundColor(.white)
                    .tint(Theme.accentColor)
                
                Toggle("Email Notifications", isOn: $settings.emailNotifications)
                    .foregroundColor(.white)
                    .tint(Theme.accentColor)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var scanFrequencySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Scan Frequency")
                .font(.headline)
                .foregroundColor(.white)
            
            Picker("Scan Frequency", selection: $settings.scanFrequency) {
                ForEach(AlertSettings.ScanFrequency.allCases, id: \.self) { frequency in
                    Text(frequency.rawValue).tag(frequency)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 120)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var saveButton: some View {
        Button(action: saveSettings) {
            Text("Save Settings")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.accentColor.opacity(0.3))
                .cornerRadius(12)
        }
    }
    
    private func saveSettings() {
        viewModel.updateSettings(settings)
        dismiss()
    }
}

struct CategoryToggleButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.bold())
                .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    isSelected ? Theme.accentColor : Color.white.opacity(0.2)
                )
                .cornerRadius(12)
        }
    }
}

struct UrgencyToggleButton: View {
    let urgency: ScholarshipAlert.UrgencyLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: urgencyIcon)
                    .foregroundColor(urgencyColor)
                    .font(.caption)
                
                Text(urgency.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Theme.accentColor)
                        .font(.caption)
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
    }
    
    private var urgencyIcon: String {
        switch urgency {
        case .high:
            return "exclamationmark.triangle.fill"
        case .medium:
            return "exclamationmark.circle.fill"
        case .low:
            return "info.circle.fill"
        }
    }
    
    private var urgencyColor: Color {
        switch urgency {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }
}

#Preview {
    AlertRadarSettingsView(viewModel: ScholarshipAlertRadarViewModel())
} 
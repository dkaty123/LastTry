import SwiftUI

struct AlertDetailView: View {
    let alert: ScholarshipAlert
    @Environment(\.dismiss) private var dismiss
    @State private var showScholarshipDetails = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        headerView
                        matchInfoView
                        scholarshipDetailsView
                        actionButtonsView
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showScholarshipDetails) {
                ScholarshipDetailSheet(alert: alert)
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            // Alert Icon
            ZStack {
                Circle()
                    .fill(urgencyColor.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: urgencyIcon)
                    .font(.system(size: 32))
                    .foregroundColor(urgencyColor)
            }
            
            // Scholarship Name
            Text(alert.scholarshipName)
                .font(.title2.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            // Amount
            Text("$\(Int(alert.amount))")
                .font(.largeTitle.bold())
                .foregroundColor(Theme.accentColor)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var matchInfoView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Match Score")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(alert.matchPercentage))%")
                    .font(.title2.bold())
                    .foregroundColor(matchColor)
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(matchColor)
                        .frame(width: geometry.size.width * CGFloat(alert.matchPercentage / 100), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
            
            // Match Description
            Text(matchDescription)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var scholarshipDetailsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Scholarship Details")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 12) {
                DetailRow(icon: "doc.text", title: "Description", value: alert.description)
                DetailRow(icon: "calendar", title: "Deadline", value: alert.deadline.formatted(date: .abbreviated, time: .omitted))
                DetailRow(icon: "clock", title: "Time Remaining", value: timeRemaining)
                DetailRow(icon: "exclamationmark.triangle", title: "Urgency", value: alert.urgency.rawValue)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var actionButtonsView: some View {
        VStack(spacing: 12) {
            Button(action: { showScholarshipDetails = true }) {
                HStack {
                    Image(systemName: "eye.fill")
                    Text("View Full Details")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.accentColor.opacity(0.3))
                .cornerRadius(12)
            }
            
            Button(action: saveScholarship) {
                HStack {
                    Image(systemName: "bookmark.fill")
                    Text("Save Scholarship")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(12)
            }
            
            Button(action: addToCalendar) {
                HStack {
                    Image(systemName: "calendar.badge.plus")
                    Text("Add to Calendar")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.3))
                .cornerRadius(12)
            }
        }
    }
    
    private var urgencyIcon: String {
        switch alert.urgency {
        case .high:
            return "exclamationmark.triangle.fill"
        case .medium:
            return "exclamationmark.circle.fill"
        case .low:
            return "info.circle.fill"
        }
    }
    
    private var urgencyColor: Color {
        switch alert.urgency {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }
    
    private var matchColor: Color {
        if alert.matchPercentage >= 90 {
            return .green
        } else if alert.matchPercentage >= 70 {
            return .orange
        } else {
            return .red
        }
    }
    
    private var matchDescription: String {
        if alert.matchPercentage >= 90 {
            return "Excellent match! This scholarship perfectly fits your profile."
        } else if alert.matchPercentage >= 70 {
            return "Good match! This scholarship aligns well with your background."
        } else {
            return "Fair match. Consider reviewing the requirements carefully."
        }
    }
    
    private var timeRemaining: String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day, .hour], from: now, to: alert.deadline)
        
        if let days = components.day, days > 0 {
            return "\(days) days"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) hours"
        } else {
            return "Due soon!"
        }
    }
    
    private func saveScholarship() {
        // Save scholarship to user's saved list
        // This would integrate with the main app's scholarship saving functionality
        dismiss()
    }
    
    private func addToCalendar() {
        // Add deadline to calendar
        // This would integrate with EventKit
        dismiss()
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Theme.accentColor)
                .frame(width: 20)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Text(value)
                .font(.subheadline.bold())
                .foregroundColor(.white)
        }
    }
}

struct ScholarshipDetailSheet: View {
    let alert: ScholarshipAlert
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text(alert.scholarshipName)
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            
                            Text("$\(Int(alert.amount))")
                                .font(.title.bold())
                                .foregroundColor(Theme.accentColor)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(alert.description)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        // Requirements (placeholder)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Requirements")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Requirements would be displayed here based on the scholarship data.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        // Application Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Application Information")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Application details and process would be shown here.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Scholarship Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    let sampleAlert = ScholarshipAlert(
        scholarshipName: "STEM Innovation Award",
        amount: 10000,
        description: "A prestigious scholarship for innovative STEM projects",
        deadline: Date().addingTimeInterval(86400 * 4),
        matchPercentage: 94,
        urgency: .high,
        isUrgent: true
    )
    
    AlertDetailView(alert: sampleAlert)
} 
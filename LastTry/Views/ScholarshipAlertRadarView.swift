import SwiftUI

struct ScholarshipAlertRadarView: View {
    @StateObject private var viewModel = ScholarshipAlertRadarViewModel()
    @State private var showSettings = false
    @State private var selectedAlert: ScholarshipAlert?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    radarStatusView
                    alertsListView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                AlertRadarSettingsView(viewModel: viewModel)
            }
            .sheet(item: $selectedAlert) { alert in
                AlertDetailView(alert: alert)
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "radar")
                    .font(.system(size: 32))
                    .foregroundColor(Theme.accentColor)
                Text("Alert Radar")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            }
            
            Text("Real-time scholarship alerts matching your criteria")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 32)
        .padding(.bottom, 20)
    }
    
    private var radarStatusView: some View {
        VStack(spacing: 16) {
            // Radar Animation
            ZStack {
                Circle()
                    .stroke(Theme.accentColor.opacity(0.3), lineWidth: 2)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .stroke(Theme.accentColor.opacity(0.6), lineWidth: 2)
                    .frame(width: 80, height: 80)
                
                Circle()
                    .stroke(Theme.accentColor, lineWidth: 2)
                    .frame(width: 40, height: 40)
                
                Image(systemName: "radar")
                    .font(.title)
                    .foregroundColor(Theme.accentColor)
                    .scaleEffect(viewModel.isScanning ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: viewModel.isScanning)
            }
            
            // Status Info
            VStack(spacing: 8) {
                Text(viewModel.isScanning ? "Scanning for Scholarships..." : "Radar Active")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Last scan: \(viewModel.lastScanTime, style: .relative)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Quick Stats
            HStack(spacing: 20) {
                StatCard(title: "Today", value: "\(viewModel.todayAlerts)", color: .green)
                StatCard(title: "This Week", value: "\(viewModel.weekAlerts)", color: .blue)
                StatCard(title: "Match Rate", value: "\(viewModel.matchRate)%", color: .orange)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
    
    private var alertsListView: some View {
        VStack {
            HStack {
                Text("Recent Alerts")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                if !viewModel.alerts.isEmpty {
                    Button("Mark All Read") {
                        viewModel.markAllAsRead()
                    }
                    .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal)
            
            if viewModel.alerts.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.alerts) { alert in
                            AlertCardView(alert: alert) {
                                selectedAlert = alert
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
            Image(systemName: "radar")
                .font(.system(size: 60))
                .foregroundColor(Theme.accentColor.opacity(0.7))
            
            Text("No alerts yet")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Text("We'll notify you when new scholarships match your criteria")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
            
            Button("Configure Alerts") {
                showSettings = true
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

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(8)
    }
}

struct AlertCardView: View {
    let alert: ScholarshipAlert
    let onTap: () -> Void
    @State private var isExpanded = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(alert.scholarshipName)
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .lineLimit(2)
                        
                        Text("$\(Int(alert.amount))")
                            .font(.title3.bold())
                            .foregroundColor(Theme.accentColor)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(Int(alert.matchPercentage))%")
                            .font(.caption.bold())
                            .foregroundColor(matchColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(matchColor.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text(alert.urgency.rawValue)
                            .font(.caption2)
                            .foregroundColor(urgencyColor)
                    }
                }
                
                Text(alert.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(isExpanded ? nil : 2)
                
                HStack {
                    Text(alert.deadline, style: .date)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    
                    Spacer()
                    
                    Text(alert.createdTime, style: .relative)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                if alert.isUrgent {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text("Deadline approaching!")
                            .font(.caption.bold())
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
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
}

#Preview {
    ScholarshipAlertRadarView()
} 
import SwiftUI
import MessageUI
import EventKit
import EventKitUI

struct SavedOpportunitiesView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var showDeleteConfirmation = false
    @State private var showMailComposer = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showMailError = false
    @StateObject private var motion = SplashMotionManager()
    @State private var selectedFilter: SavedFilter = .all
    
    enum SavedFilter: String, CaseIterable {
        case all = "All"
        case upcoming = "Upcoming"
        case highValue = "High Value"
        case urgent = "Urgent"
    }
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                enhancedHeaderView
                filterButtonsView
                contentView
            }
        }
        .navigationBarHidden(true)
        .alert("Clear All Saved Opportunities?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear All", role: .destructive) {
                viewModel.clearSavedOpportunities()
            }
        } message: {
            Text("This action cannot be undone.")
        }
        .sheet(isPresented: $showMailComposer) {
            MailView(
                recipients: [],
                subject: "My Saved Opportunities",
                messageBody: emailBody,
                result: $mailResult
            )
        }
        .alert("Mail services are not available on this device.", isPresented: $showMailError) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private var enhancedHeaderView: some View {
        VStack(spacing: 16) {
            // Header with title and actions
            HStack {
                // Placeholder for balance
                Circle()
                    .fill(Color.clear)
                    .frame(width: 40, height: 40)
                
                Spacer()
                
                VStack(spacing: 6) {
                    Text("Saved Opportunities")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Text("Your collection of opportunities")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Saved count badge
                ZStack {
                    Circle()
                        .fill(Theme.accentColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Text("\(filteredOpportunities.count)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Stats card
            HStack(spacing: 20) {
                SavedStatCard(
                    icon: "bookmark.fill",
                    title: "Total Saved",
                    value: "\(viewModel.savedOpportunities.count)",
                    color: Theme.accentColor
                )
                
                SavedStatCard(
                    icon: "dollarsign.circle.fill",
                    title: "Total Value",
                    value: "$\(Int(totalValue))",
                    color: Theme.successColor
                )
                
                SavedStatCard(
                    icon: "clock.fill",
                    title: "Upcoming",
                    value: "\(upcomingCount)",
                    color: Theme.amberColor
                )
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var filterButtonsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(SavedFilter.allCases, id: \.self) { filter in
                    Button(action: {
                        selectedFilter = filter
                    }) {
                        Text(filter.rawValue)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(selectedFilter == filter ? .white : .white.opacity(0.7))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedFilter == filter ? Theme.accentColor : Theme.cardBackground.opacity(0.6))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedFilter == filter ? Theme.accentColor : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    private var contentView: some View {
        Group {
            if filteredOpportunities.isEmpty {
                enhancedEmptyStateView
            } else {
                enhancedOpportunityListView
            }
        }
    }
    
    private var filteredOpportunities: [Opportunity] {
        switch selectedFilter {
        case .all:
            return viewModel.savedOpportunities
        case .upcoming:
            let thirtyDaysFromNow = Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date()
            return viewModel.savedOpportunities.filter { $0.deadline != nil && $0.deadline! <= thirtyDaysFromNow }
        case .highValue:
            return viewModel.savedOpportunities.filter { ($0.amount ?? 0) >= 10000 || ($0.stipend ?? 0) >= 10000 }
        case .urgent:
            let sevenDaysFromNow = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
            return viewModel.savedOpportunities.filter { $0.deadline != nil && $0.deadline! <= sevenDaysFromNow }
        }
    }
    
    private var totalValue: Double {
        viewModel.savedOpportunities.reduce(0) { $0 + ($1.amount ?? 0) + ($1.stipend ?? 0) }
    }
    
    private var upcomingCount: Int {
        let thirtyDaysFromNow = Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date()
        return viewModel.savedOpportunities.filter { $0.deadline != nil && $0.deadline! <= thirtyDaysFromNow }.count
    }
    
    private var enhancedEmptyStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Theme.accentColor.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "bookmark.slash")
                    .font(.system(size: 50, weight: .medium))
                    .foregroundColor(Theme.accentColor)
            }
            
            VStack(spacing: 12) {
                Text("No saved opportunities yet!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("Start exploring to find and save your perfect matches.")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            // Action buttons
            VStack(spacing: 12) {
                Button(action: {
                    // Navigate to explore
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Explore Opportunities")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Theme.accentColor)
                            .shadow(color: Theme.accentColor.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
                }
                
                Button(action: {
                    // Navigate to matches
                }) {
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("View Matches")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(Theme.accentColor)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Theme.cardBackground.opacity(0.8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                            )
                    )
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private var enhancedOpportunityListView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(filteredOpportunities) { opportunity in
                    OpportunityCardView(opportunity: opportunity, swipeDirection: nil)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 40)
        }
    }
    
    private var emailBody: String {
        guard !viewModel.savedOpportunities.isEmpty else {
            return "You have no saved opportunities."
        }
        var lines: [String] = ["Here are my saved opportunities:\n"]
        for opportunity in viewModel.savedOpportunities {
            let amountString = String(format: "$%.2f", opportunity.amount ?? 0)
            let deadlineString = opportunity.deadline?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
            lines.append("• \(opportunity.title)\n  Amount: \(amountString)\n  Deadline: \(deadlineString)\n")
        }
        return lines.joined(separator: "\n")
    }
}

struct SavedStatCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(color)
            }
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: color.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct MailView: UIViewControllerRepresentable {
    var recipients: [String]
    var subject: String
    var messageBody: String
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var result: Result<MFMailComposeResult, Error>?
        init(result: Binding<Result<MFMailComposeResult, Error>?>) {
            _result = result
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer { controller.dismiss(animated: true) }
            if let error = error {
                self.result = .failure(error)
                return
            }
            self.result = .success(result)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(result: $result)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(recipients)
        vc.setSubject(subject)
        vc.setMessageBody(messageBody, isHTML: false)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

#Preview {
    SavedOpportunitiesView()
        .environmentObject(AppViewModel())
} 
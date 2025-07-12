import SwiftUI

struct ApplicationTrackingView: View {
    @StateObject private var viewModel = ApplicationTrackingViewModel()
    @StateObject private var motion = SplashMotionManager()
    @State private var selectedTab = 0
    @State private var headerOffset: CGFloat = -50
    @State private var headerOpacity: Double = 0
    @State private var contentOffset: CGFloat = 100
    @State private var contentOpacity: Double = 0
    @State private var showingAddApplication = false
    
    var body: some View {
        ZStack {
            ScholarSplashBackgroundView(motion: motion)
                .ignoresSafeArea()
            ScholarSplashDriftingStarFieldView()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                enhancedHeaderView
                tabSelectorView
                
                TabView(selection: $selectedTab) {
                    overviewTab
                        .tag(0)
                    applicationsTab
                        .tag(1)
                    documentsTab
                        .tag(2)
                    milestonesTab
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                headerOffset = 0
                headerOpacity = 1
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                contentOffset = 0
                contentOpacity = 1
            }
        }
        .sheet(isPresented: $showingAddApplication) {
            AddApplicationView(viewModel: viewModel)
        }
    }
    
    private var enhancedHeaderView: some View {
        VStack(spacing: 16) {
            // Header with title and mascot
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Application Tracker")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Text("Track your scholarship journey")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Add application button
                Button(action: {
                    showingAddApplication = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Theme.accentColor.opacity(0.2))
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Theme.accentColor)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Quick stats
            HStack(spacing: 16) {
                ApplicationQuickStatCard(
                    icon: "doc.text.fill",
                    title: "Total",
                    value: viewModel.applications.count,
                    color: Theme.accentColor
                )
                
                ApplicationQuickStatCard(
                    icon: "checkmark.circle.fill",
                    title: "Accepted",
                    value: viewModel.applications.filter { $0.status == .accepted }.count,
                    color: Theme.successColor
                )
                
                ApplicationQuickStatCard(
                    icon: "clock.fill",
                    title: "Pending",
                    value: viewModel.applications.filter { $0.status == .inProgress || $0.status == .submitted }.count,
                    color: Theme.amberColor
                )
            }
            .padding(.horizontal, 20)
        }
        .background(Theme.backgroundColor.opacity(0.3))
        .offset(y: headerOffset)
        .opacity(headerOpacity)
    }
    
    private var tabSelectorView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(["Overview", "Applications", "Documents", "Milestones"], id: \.self) { tab in
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = ["Overview", "Applications", "Documents", "Milestones"].firstIndex(of: tab) ?? 0
                        }
                    }) {
                        Text(tab)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(selectedTab == ["Overview", "Applications", "Documents", "Milestones"].firstIndex(of: tab) ? .white : .white.opacity(0.7))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedTab == ["Overview", "Applications", "Documents", "Milestones"].firstIndex(of: tab) ? Theme.accentColor : Theme.cardBackground.opacity(0.6))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedTab == ["Overview", "Applications", "Documents", "Milestones"].firstIndex(of: tab) ? Theme.accentColor : Theme.cardBorder.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    .scaleEffect(selectedTab == ["Overview", "Applications", "Documents", "Milestones"].firstIndex(of: tab) ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    private var overviewTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Status dashboard
                EnhancedStatusDashboardCard(viewModel: viewModel)
                
                // Progress overview
                EnhancedProgressCard(viewModel: viewModel)
                
                // Success analytics
                EnhancedAnalyticsCard(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
    
    private var applicationsTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Add application button
                Button(action: {
                    showingAddApplication = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 20, weight: .medium))
                        Text("Add New Application")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Theme.accentColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Theme.accentColor.opacity(0.5), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                
                // Applications list
                VStack(spacing: 12) {
                    ForEach(viewModel.applications) { application in
                        EnhancedApplicationCard(application: application, viewModel: viewModel)
                    }
                    
                    if viewModel.applications.isEmpty {
                        ApplicationEmptyStateView(
                            icon: "doc.text",
                            title: "No Applications Yet",
                            subtitle: "Start tracking your scholarship applications"
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
    
    private var documentsTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Document overview
                EnhancedDocumentOverviewCard(viewModel: viewModel)
                
                // Documents list
                VStack(spacing: 12) {
                    ForEach(viewModel.documents) { document in
                        EnhancedDocumentCard(document: document, viewModel: viewModel)
                    }
                    
                    if viewModel.documents.isEmpty {
                        ApplicationEmptyStateView(
                            icon: "doc.on.doc",
                            title: "No Documents Yet",
                            subtitle: "Add documents to track your application materials"
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
    
    private var milestonesTab: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Milestone overview
                EnhancedMilestoneOverviewCard(viewModel: viewModel)
                
                // Milestones list
                VStack(spacing: 12) {
                    ForEach(viewModel.milestones) { milestone in
                        EnhancedMilestoneCard(milestone: milestone, viewModel: viewModel)
                    }
                    
                    if viewModel.milestones.isEmpty {
                        ApplicationEmptyStateView(
                            icon: "flag",
                            title: "No Milestones Yet",
                            subtitle: "Add milestones to track your application progress"
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
        .offset(y: contentOffset)
        .opacity(contentOpacity)
    }
}

struct ApplicationQuickStatCard: View {
    let icon: String
    let title: String
    let value: Int
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
                Text("\(value)")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
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

struct EnhancedStatusDashboardCard: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "chart.pie.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Application Status")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            // Status grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(ApplicationStatus.allCases, id: \.self) { status in
                    StatusItemCard(
                        status: status,
                        count: viewModel.applications.filter { $0.status == status }.count
                    )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct StatusItemCard: View {
    let status: ApplicationStatus
    let count: Int
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(status.color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: statusIcon(for: status))
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(status.color)
            }
            
            Text("\(count)")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(status.rawValue)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(status.color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(status.color.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private func statusIcon(for status: ApplicationStatus) -> String {
        switch status {
        case .notStarted: return "circle"
        case .inProgress: return "clock.fill"
        case .submitted: return "paperplane.fill"
        case .accepted: return "checkmark.circle.fill"
        case .rejected: return "xmark.circle.fill"
        }
    }
}

struct EnhancedProgressCard: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Progress Overview")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                EnhancedProgressBar(
                    title: "Overall Progress",
                    progress: calculateOverallProgress(),
                    color: Theme.accentColor,
                    icon: "chart.line.uptrend.xyaxis"
                )
                
                EnhancedProgressBar(
                    title: "Document Completion",
                    progress: calculateDocumentProgress(),
                    color: Theme.successColor,
                    icon: "doc.on.doc"
                )
                
                EnhancedProgressBar(
                    title: "Milestone Completion",
                    progress: calculateMilestoneProgress(),
                    color: Theme.amberColor,
                    icon: "flag"
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    private func calculateOverallProgress() -> Double {
        let total = Double(viewModel.applications.count)
        let completed = Double(viewModel.applications.filter { $0.status == .accepted || $0.status == .rejected }.count)
        return total > 0 ? (completed / total) * 100 : 0
    }
    
    private func calculateDocumentProgress() -> Double {
        let total = Double(viewModel.documents.count)
        let completed = Double(viewModel.documents.filter { $0.isUploaded }.count)
        return total > 0 ? (completed / total) * 100 : 0
    }
    
    private func calculateMilestoneProgress() -> Double {
        let total = Double(viewModel.milestones.count)
        let completed = Double(viewModel.milestones.filter { $0.isCompleted }.count)
        return total > 0 ? (completed / total) * 100 : 0
    }
}

struct EnhancedProgressBar: View {
    let title: String
    let progress: Double
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(progress))%")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(color)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 12)
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [color, color.opacity(0.7)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * CGFloat(progress / 100), height: 12)
                        .animation(.easeInOut(duration: 1.0), value: progress)
                }
            }
            .frame(height: 12)
        }
    }
}

struct EnhancedAnalyticsCard: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    private var successRate: Int {
        let total = viewModel.applications.count
        let successful = viewModel.applications.filter { $0.status == .accepted }.count
        return total > 0 ? Int((Double(successful) / Double(total)) * 100) : 0
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "chart.pie.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Success Analytics")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                AnalyticsItemCard(
                    title: "Success Rate",
                    value: "\(successRate)%",
                    icon: "chart.line.uptrend.xyaxis",
                    color: Theme.successColor
                )
                
                AnalyticsItemCard(
                    title: "Total Applications",
                    value: "\(viewModel.applications.count)",
                    icon: "doc.text.fill",
                    color: Theme.accentColor
                )
                
                AnalyticsItemCard(
                    title: "Pending",
                    value: "\(viewModel.applications.filter { $0.status == .inProgress || $0.status == .submitted }.count)",
                    icon: "clock.fill",
                    color: Theme.amberColor
                )
                
                AnalyticsItemCard(
                    title: "Completed",
                    value: "\(viewModel.applications.filter { $0.status == .accepted || $0.status == .rejected }.count)",
                    icon: "checkmark.circle.fill",
                    color: Theme.successColor
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct AnalyticsItemCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(title)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct EnhancedApplicationCard: View {
    let application: ScholarshipApplication
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(application.scholarshipName)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(application.category.rawValue)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Status badge
                Text(application.status.rawValue)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(application.status.color)
                    )
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Deadline")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text(application.deadline, style: .date)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Documents")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text("\(application.documents.filter { $0.isUploaded }.count)/\(application.documents.count)")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: application.status.color.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct EnhancedDocumentOverviewCard: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "doc.on.doc")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Document Overview")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack(spacing: 16) {
                DocumentStatCard(
                    title: "Total",
                    value: viewModel.documents.count,
                    color: Theme.accentColor
                )
                
                DocumentStatCard(
                    title: "Uploaded",
                    value: viewModel.documents.filter { $0.isUploaded }.count,
                    color: Theme.successColor
                )
                
                DocumentStatCard(
                    title: "Pending",
                    value: viewModel.documents.filter { !$0.isUploaded }.count,
                    color: Theme.amberColor
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct DocumentStatCard: View {
    let title: String
    let value: Int
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(value)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct EnhancedDocumentCard: View {
    let document: ApplicationDocument
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Status icon
            ZStack {
                Circle()
                    .fill(document.isUploaded ? Theme.successColor.opacity(0.2) : Theme.amberColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: document.isUploaded ? "checkmark.circle.fill" : "clock.circle.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(document.isUploaded ? Theme.successColor : Theme.amberColor)
            }
            
            // Document details
            VStack(alignment: .leading, spacing: 4) {
                Text(document.name)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(document.type.rawValue)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            // Upload status
            VStack(alignment: .trailing, spacing: 4) {
                Text(document.isUploaded ? "Uploaded" : "Pending")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(document.isUploaded ? Theme.successColor : Theme.amberColor)
                
                if let uploadDate = document.uploadDate {
                    Text(uploadDate, style: .date)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: (document.isUploaded ? Theme.successColor : Theme.amberColor).opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct EnhancedMilestoneOverviewCard: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "flag")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.accentColor)
                
                Text("Milestone Overview")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack(spacing: 16) {
                MilestoneStatCard(
                    title: "Total",
                    value: viewModel.milestones.count,
                    color: Theme.accentColor
                )
                
                MilestoneStatCard(
                    title: "Completed",
                    value: viewModel.milestones.filter { $0.isCompleted }.count,
                    color: Theme.successColor
                )
                
                MilestoneStatCard(
                    title: "Pending",
                    value: viewModel.milestones.filter { !$0.isCompleted }.count,
                    color: Theme.amberColor
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct MilestoneStatCard: View {
    let title: String
    let value: Int
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(value)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct EnhancedMilestoneCard: View {
    let milestone: ApplicationMilestone
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(milestone.title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(milestone.description)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Completion status
                ZStack {
                    Circle()
                        .fill(milestone.isCompleted ? Theme.successColor.opacity(0.2) : Theme.amberColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(milestone.isCompleted ? Theme.successColor : Theme.amberColor)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Due Date")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text(milestone.dueDate, style: .date)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text(milestone.isCompleted ? "Completed" : "Pending")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(milestone.isCompleted ? Theme.successColor : Theme.amberColor)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: (milestone.isCompleted ? Theme.successColor : Theme.amberColor).opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ApplicationEmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Theme.accentColor.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: icon)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(Theme.accentColor)
            }
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.cardBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct AddApplicationView: View {
    @ObservedObject var viewModel: ApplicationTrackingViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var scholarshipName = ""
    @State private var deadline = Date()
    @State private var category = Scholarship.ScholarshipCategory.general
    
    var body: some View {
        NavigationView {
            ZStack {
                ScholarSplashBackgroundView(motion: SplashMotionManager())
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Add New Application")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        TextField("Scholarship Name", text: $scholarshipName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                            .colorScheme(.dark)
                        
                        Picker("Category", selection: $category) {
                            ForEach(Scholarship.ScholarshipCategory.allCases, id: \.self) { category in
                                Text(category.rawValue.capitalized).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        let application = ScholarshipApplication(
                            scholarshipName: scholarshipName,
                            deadline: deadline,
                            category: category
                        )
                        viewModel.addApplication(application)
                        dismiss()
                    }) {
                        Text("Add Application")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Theme.accentColor)
                            )
                    }
                    .disabled(scholarshipName.isEmpty)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ApplicationTrackingView()
} 
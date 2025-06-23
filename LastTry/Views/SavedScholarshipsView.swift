import SwiftUI
import MessageUI
import EventKit
import EventKitUI

struct SavedScholarshipsView: View {
    @EnvironmentObject private var viewModel: AppViewModel
    @State private var showDeleteConfirmation = false
    @State private var showMailComposer = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showMailError = false
    
    var body: some View {
        NavigationStack {
        ZStack {
            Theme.primaryGradient
                .ignoresSafeArea()
            
            if viewModel.savedScholarships.isEmpty {
                    EmptySavedView()
                } else {
                    ScrollView {
                VStack(spacing: 20) {
                            HStack {
                                Text("Saved Scholarships")
                                    .font(.title)
                                    .bold()
                        .foregroundColor(.white)
                    
                                Spacer()
                                
                                Button(action: { showDeleteConfirmation = true }) {
                                    Text("Clear All")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.red.opacity(0.3))
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal)
                            
                            Button(action: {
                                if MFMailComposeViewController.canSendMail() {
                                    showMailComposer = true
            } else {
                                    showMailError = true
                                }
                            }) {
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.white)
                                    Text("Email My Scholarships")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            
                        ForEach(viewModel.savedScholarships) { scholarship in
                                SavedScholarshipCard(scholarship: scholarship) {
                                    viewModel.removeSavedScholarship(scholarship)
                                }
                        }
                    }
                        .padding(.vertical)
                }
            }
        }
            .alert("Clear All Saved Scholarships?", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Clear All", role: .destructive) {
                    viewModel.clearAllSavedScholarships()
                }
            } message: {
                Text("This action cannot be undone.")
            }
            .sheet(isPresented: $showMailComposer) {
                MailView(
                    recipients: [],
                    subject: "My Saved Scholarships",
                    messageBody: emailBody,
                    result: $mailResult
                )
            }
            .alert("Mail services are not available on this device.", isPresented: $showMailError) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    private var emailBody: String {
        guard !viewModel.savedScholarships.isEmpty else {
            return "You have no saved scholarships."
        }
        var lines: [String] = ["Here are my saved scholarships:\n"]
        for scholarship in viewModel.savedScholarships {
            let amountString = String(format: "$%.2f", scholarship.amount)
            let deadlineString = scholarship.deadline.formatted(date: .abbreviated, time: .omitted)
            lines.append("• \(scholarship.name)\n  Amount: \(amountString)\n  Deadline: \(deadlineString)\n")
            }
        return lines.joined(separator: "\n")
    }
}

struct SavedScholarshipCard: View {
    let scholarship: Scholarship
    let onDelete: () -> Void
    @State private var isExpanded = false
    @State private var showCalendarSheet = false
    @State private var calendarEvent: EKEvent? = nil
    @State private var calendarEventStore: EKEventStore? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
            Text(scholarship.name)
                    .font(.title3)
                    .bold()
                .foregroundColor(.white)
                
                Spacer()
                
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.title3)
                }
            }
            
            Text(scholarship.description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(isExpanded ? nil : 2)
            
            HStack {
                Text("$\(scholarship.amount, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.green)
                
                Spacer()
                
                Text(scholarship.deadline, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            // Countdown widget always visible
            DeadlineCountdownView(deadline: scholarship.deadline, scholarshipName: scholarship.name, amount: Int(scholarship.amount))
            
            // Reminder and Calendar buttons
            HStack(spacing: 16) {
                Button(action: { scheduleDeadlineReminder() }) {
                    Label("Remind Me", systemImage: "bell.badge.fill")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.purple.opacity(0.25))
                        .cornerRadius(10)
                }
                Button(action: { addToCalendar() }) {
                    Label("Add to Calendar", systemImage: "calendar.badge.plus")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.25))
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showCalendarSheet) {
                if let event = calendarEvent, let eventStore = calendarEventStore {
                    CalendarEventEditView(event: event, eventStore: eventStore) { showCalendarSheet = false }
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                        .background(Color.white.opacity(0.3))
                    
                    Text("Requirements")
                        .font(.headline)
                            .foregroundColor(.white)
                        
                        ForEach(scholarship.requirements, id: \.self) { requirement in
                        HStack(alignment: .top) {
                                Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.subheadline)
                            
                                Text(requirement)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    
                    if let website = scholarship.website {
                        Link(destination: URL(string: website)!) {
                            HStack {
                            Text("Visit Website")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                                Image(systemName: "arrow.up.right")
                                    .font(.caption)
                                .foregroundColor(.white)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 8)
            }
            
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.green)
                        .font(.title3)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    // MARK: - Reminders & Calendar
    private func scheduleDeadlineReminder() {
        // TODO: Implement local notification scheduling for the deadline
    }
    private func addToCalendar() {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                let event = EKEvent(eventStore: eventStore)
                event.title = scholarship.name
                event.startDate = scholarship.deadline
                event.endDate = scholarship.deadline.addingTimeInterval(3600) // 1 hour
                event.notes = scholarship.description
                event.calendar = eventStore.defaultCalendarForNewEvents
                event.location = ""
                event.url = scholarship.website != nil ? URL(string: scholarship.website!) : nil
                calendarEvent = event
                calendarEventStore = eventStore
                showCalendarSheet = true
            } else {
                // Handle denied access (show alert, etc.)
            }
        }
    }
}

struct EmptySavedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 60))
                .foregroundColor(.white.opacity(0.5))
            
            Text("No Saved Scholarships")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text("Save scholarships you're interested in to track them here")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
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

// CalendarEventEditView for presenting EKEventEditViewController
struct CalendarEventEditView: UIViewControllerRepresentable {
    let event: EKEvent
    let eventStore: EKEventStore
    var onDismiss: () -> Void
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.event = event
        controller.eventStore = eventStore
        controller.editViewDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onDismiss: onDismiss)
    }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        let onDismiss: () -> Void
        init(onDismiss: @escaping () -> Void) {
            self.onDismiss = onDismiss
        }
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            controller.dismiss(animated: true, completion: nil)
            onDismiss()
        }
    }
}

#Preview {
    SavedScholarshipsView()
        .environmentObject(AppViewModel())
} 
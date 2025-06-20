import Foundation
import SwiftUI

class ApplicationTrackingViewModel: ObservableObject {
    @Published var applications: [ScholarshipApplication] = []
    @Published var documents: [ApplicationDocument] = []
    @Published var milestones: [ApplicationMilestone] = []
    @Published var successRate: Double = 0.0
    
    init() {
        loadData()
    }
    
    private func loadData() {
        // Load sample data for testing
        applications = [
            ScholarshipApplication(
                id: UUID(),
                scholarshipName: "Merit Scholarship",
                status: .inProgress,
                deadline: Date().addingTimeInterval(86400 * 30),
                category: .general,
                documents: [
                    ApplicationDocument(id: UUID(), name: "Transcript", type: .transcript, isUploaded: true),
                    ApplicationDocument(id: UUID(), name: "Essay", type: .essay, isUploaded: false)
                ],
                milestones: []
            ),
            ScholarshipApplication(
                id: UUID(),
                scholarshipName: "STEM Excellence Award",
                status: .accepted,
                deadline: Date().addingTimeInterval(86400 * 15),
                category: .stem,
                documents: [
                    ApplicationDocument(id: UUID(), name: "Transcript", type: .transcript, isUploaded: true),
                    ApplicationDocument(id: UUID(), name: "Essay", type: .essay, isUploaded: true)
                ],
                milestones: []
            ),
            ScholarshipApplication(
                id: UUID(),
                scholarshipName: "Community Service Grant",
                status: .notStarted,
                deadline: Date().addingTimeInterval(86400 * 45),
                category: .humanities,
                documents: [
                    ApplicationDocument(id: UUID(), name: "Transcript", type: .transcript, isUploaded: false),
                    ApplicationDocument(id: UUID(), name: "Essay", type: .essay, isUploaded: false)
                ],
                milestones: []
            )
        ]
        
        // Load all documents from applications
        documents = applications.flatMap { $0.documents }
        
        // Create milestones
        milestones = [
            ApplicationMilestone(
                id: UUID(),
                title: "Complete Essay",
                description: "Write and review scholarship essay",
                dueDate: Date().addingTimeInterval(86400 * 7),
                isCompleted: false
            ),
            ApplicationMilestone(
                id: UUID(),
                title: "Gather Transcripts",
                description: "Request and collect academic transcripts",
                dueDate: Date().addingTimeInterval(86400 * 14),
                isCompleted: true
            ),
            ApplicationMilestone(
                id: UUID(),
                title: "Submit Application",
                description: "Final review and submission",
                dueDate: Date().addingTimeInterval(86400 * 21),
                isCompleted: false
            )
        ]
        
        calculateSuccessRate()
    }
    
    func updateApplicationStatus(_ application: ScholarshipApplication, status: ApplicationStatus) {
        if let index = applications.firstIndex(where: { $0.id == application.id }) {
            applications[index].status = status
            calculateSuccessRate()
        }
    }
    
    func addDocument(_ document: ApplicationDocument) {
        documents.append(document)
    }
    
    func deleteDocument(_ document: ApplicationDocument) {
        documents.removeAll { $0.id == document.id }
    }
    
    func updateDocument(_ document: ApplicationDocument) {
        if let index = documents.firstIndex(where: { $0.id == document.id }) {
            documents[index] = document
        }
    }
    
    func updateMilestone(_ milestone: ApplicationMilestone) {
        if let index = milestones.firstIndex(where: { $0.id == milestone.id }) {
            milestones[index] = milestone
        }
    }
    
    func addMilestone(_ milestone: ApplicationMilestone) {
        milestones.append(milestone)
    }
    
    func deleteMilestone(_ milestone: ApplicationMilestone) {
        milestones.removeAll { $0.id == milestone.id }
    }
    
    private func calculateSuccessRate() {
        let total = Double(applications.count)
        let successful = Double(applications.filter { $0.status == .accepted }.count)
        successRate = total > 0 ? (successful / total) * 100 : 0
    }
    
    func addApplication(_ application: ScholarshipApplication) {
        applications.append(application)
    }
    
    func deleteApplication(_ application: ScholarshipApplication) {
        applications.removeAll { $0.id == application.id }
    }
    
    func updateApplication(_ application: ScholarshipApplication) {
        if let index = applications.firstIndex(where: { $0.id == application.id }) {
            applications[index] = application
        }
    }
} 
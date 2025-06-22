import SwiftUI

struct PeerReviewExchangeView: View {
    @State private var showSubmitSheet = false
    @State private var showReviewSheet = false
    @State private var selectedEssay: PeerEssay? = nil
    
    let peerEssays: [PeerEssay] = [
        PeerEssay(title: "Why I Want to Study CS", author: "Student A", excerpt: "I have always been fascinated by computers...", status: .open),
        PeerEssay(title: "Overcoming Adversity", author: "Student B", excerpt: "My journey began in a small town...", status: .open),
        PeerEssay(title: "Leadership in Action", author: "Student C", excerpt: "During my time as club president...", status: .reviewed),
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Peer Review Exchange")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Spacer()
                Button(action: { showSubmitSheet = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(Theme.accentColor)
                }
            }
            .padding(.horizontal)
            ScrollView {
                VStack(spacing: 18) {
                    ForEach(peerEssays) { essay in
                        PeerEssayCardView(essay: essay) {
                            selectedEssay = essay
                            showReviewSheet = true
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showSubmitSheet) {
            SubmitPeerEssaySheet()
        }
        .sheet(isPresented: $showReviewSheet) {
            if let essay = selectedEssay {
                ReviewPeerEssaySheet(essay: essay)
            }
        }
    }
}

struct PeerEssay: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let excerpt: String
    let status: PeerEssayStatus
}

enum PeerEssayStatus: String {
    case open = "Open for Review"
    case reviewed = "Reviewed"
}

struct PeerEssayCardView: View {
    let essay: PeerEssay
    let onReview: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(essay.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text(essay.status.rawValue)
                    .font(.caption)
                    .foregroundColor(essay.status == .open ? .yellow : .green)
            }
            Text("by \(essay.author)")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
            Text(essay.excerpt)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(2)
            HStack {
                Spacer()
                Button(action: onReview) {
                    Text("Review Essay")
                        .font(.subheadline.bold())
                        .padding(.horizontal, 16)
                        .padding(.vertical, 7)
                        .background(Theme.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.22))
        .cornerRadius(15)
        .shadow(color: Theme.accentColor.opacity(0.12), radius: 4, x: 0, y: 2)
    }
}

struct SubmitPeerEssaySheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var essayTitle = ""
    @State private var essayText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                TextField("Essay Title", text: $essayTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextEditor(text: $essayText)
                    .frame(height: 180)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                Button(action: {
                    // Submit logic here
                    dismiss()
                }) {
                    Text("Submit for Peer Review")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Theme.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                Spacer()
            }
            .padding()
            .background(Theme.primaryGradient.ignoresSafeArea())
            .navigationTitle("Submit Essay")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

struct ReviewPeerEssaySheet: View {
    let essay: PeerEssay
    @Environment(\.dismiss) private var dismiss
    @State private var reviewText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                Text(essay.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("by \(essay.author)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                Text(essay.excerpt)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.bottom, 8)
                TextEditor(text: $reviewText)
                    .frame(height: 120)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                Button(action: {
                    // Submit review logic here
                    dismiss()
                }) {
                    Text("Submit Review & Earn Points")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Theme.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                Spacer()
            }
            .padding()
            .background(Theme.primaryGradient.ignoresSafeArea())
            .navigationTitle("Review Essay")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
} 
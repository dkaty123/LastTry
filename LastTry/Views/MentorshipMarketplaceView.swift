import SwiftUI

struct MentorshipMarketplaceView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            Theme.primaryGradient.ignoresSafeArea()
            VStack(spacing: 0) {
                Picker("Mentorship Options", selection: $selectedTab) {
                    Text("Book a Mentor").tag(0)
                    Text("Peer Review").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedTab == 0 {
                    BookMentorListView()
                } else {
                    PeerReviewExchangeView()
                }
                Spacer()
            }
        }
        .navigationTitle("Mentorship")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        MentorshipMarketplaceView()
    }
} 
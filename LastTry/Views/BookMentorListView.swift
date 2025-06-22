import SwiftUI

struct BookMentorListView: View {
    @State private var showBookingSheet = false
    @State private var selectedMentor: MentorProfile? = nil
    
    let mentors: [MentorProfile] = [
        MentorProfile(name: "Alex Chen", university: "Waterloo CS", expertise: "Essay Coaching", bio: "CS student, $10k+ in scholarships, loves helping others win!", price: 25, image: "person.crop.circle.fill"),
        MentorProfile(name: "Priya Singh", university: "McGill Law", expertise: "Interview Prep", bio: "Law student, interview ace, 5+ major awards.", price: 30, image: "person.crop.circle.badge.checkmark"),
        MentorProfile(name: "Samir Patel", university: "UBC Science", expertise: "STEM Scholarships", bio: "Science major, specializes in STEM and research awards.", price: 20, image: "person.crop.circle.badge.moon"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(mentors) { mentor in
                    MentorCardView(mentor: mentor) {
                        selectedMentor = mentor
                        showBookingSheet = true
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showBookingSheet) {
            if let mentor = selectedMentor {
                BookMentorSessionSheet(mentor: mentor)
            }
        }
    }
}

struct MentorProfile: Identifiable {
    let id = UUID()
    let name: String
    let university: String
    let expertise: String
    let bio: String
    let price: Int // in app points or $ for demo
    let image: String // system image name
}

struct MentorCardView: View {
    let mentor: MentorProfile
    let onBook: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 15) {
                Image(systemName: mentor.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Theme.accentColor)
                VStack(alignment: .leading, spacing: 4) {
                    Text(mentor.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(mentor.university)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                    Text(mentor.expertise)
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
                Spacer()
                Button(action: onBook) {
                    Text("Book")
                        .font(.subheadline.bold())
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .background(Theme.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            Text(mentor.bio)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .padding(.top, 4)
        }
        .padding()
        .background(Color.black.opacity(0.25))
        .cornerRadius(18)
        .shadow(color: Theme.accentColor.opacity(0.15), radius: 6, x: 0, y: 2)
    }
}

struct BookMentorSessionSheet: View {
    let mentor: MentorProfile
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTime = Date().addingTimeInterval(3600)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: mentor.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Theme.accentColor)
                Text("Book a session with \(mentor.name)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text(mentor.bio)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                DatePicker("Select Time", selection: $selectedTime, in: Date()..., displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                Button(action: {
                    // Booking logic here
                    dismiss()
                }) {
                    Text("Confirm Booking for \(mentor.price) points")
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
            .navigationTitle("Book Mentor")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
} 
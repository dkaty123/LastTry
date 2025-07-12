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
        ZStack {
            Theme.primaryGradient.ignoresSafeArea()
            VStack(spacing: 0) {
                // Enhanced header
                VStack(spacing: 4) {
                    Text("Mentorship Marketplace")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Theme.accentColor.opacity(0.4), radius: 8, x: 0, y: 4)
                    Text("Book a session with top student mentors")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 32)
                .padding(.bottom, 12)
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(mentors) { mentor in
                            MentorCardView(mentor: mentor) {
                                selectedMentor = mentor
                                showBookingSheet = true
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 32)
                }
            }
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
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 18) {
                ZStack {
                    Circle()
                        .fill(Theme.accentColor.opacity(0.18))
                        .frame(width: 62, height: 62)
                    Image(systemName: mentor.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundColor(Theme.accentColor)
                }
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Text(mentor.name)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        // Price chip
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.yellow)
                            Text("\(mentor.price)")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.yellow.opacity(0.15))
                        .cornerRadius(10)
                    }
                    HStack(spacing: 8) {
                        Label(mentor.university, systemImage: "graduationcap.fill")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                    }
                    HStack(spacing: 8) {
                        Label(mentor.expertise, systemImage: "lightbulb.fill")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundColor(.blue)
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 8)
            Text(mentor.bio)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.92))
                .padding(.bottom, 10)
                .padding(.leading, 2)
            HStack {
                Spacer()
                Button(action: onBook) {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar.badge.plus")
                        Text("Book Session")
                    }
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .padding(.horizontal, 22)
                    .padding(.vertical, 10)
                    .background(Theme.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .shadow(color: Theme.accentColor.opacity(0.18), radius: 4, x: 0, y: 2)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.white.opacity(0.07))
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(Theme.accentColor.opacity(0.18), lineWidth: 1.5)
                )
        )
        .shadow(color: Theme.accentColor.opacity(0.10), radius: 10, x: 0, y: 4)
    }
}

struct BookMentorSessionSheet: View {
    let mentor: MentorProfile
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTime = Date().addingTimeInterval(3600)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Mentor profile card at top
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Theme.accentColor.opacity(0.18))
                            .frame(width: 80, height: 80)
                        Image(systemName: mentor.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Theme.accentColor)
                    }
                    Text(mentor.name)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text(mentor.university)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                    Text(mentor.expertise)
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.blue)
                }
                .padding(.top, 12)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white.opacity(0.06))
                )
                // Time selection
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select a time for your session:")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    DatePicker("Select Time", selection: $selectedTime, in: Date()..., displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 8)
                // Confirm button
                Button(action: {
                    // Booking logic here
                    dismiss()
                }) {
                    Text("Confirm Booking for \(mentor.price) points")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
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
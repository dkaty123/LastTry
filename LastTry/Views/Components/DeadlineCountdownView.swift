import SwiftUI

struct DeadlineCountdownView: View {
    let deadline: Date
    let scholarshipName: String
    let amount: Int
    @State private var timeLeft: String = ""
    @State private var timer: Timer? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "clock.fill")
                .foregroundColor(.yellow)
            Text(timeLeft)
                .font(.headline)
                .foregroundColor(.white)
            Text("for $\(amount.formatted()) \(scholarshipName)")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.purple.opacity(0.25))
        )
        .onAppear(perform: updateCountdown)
        .onDisappear { timer?.invalidate() }
    }
    
    private func updateCountdown() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let now = Date()
            let diff = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: deadline)
            if let day = diff.day, let hour = diff.hour, let minute = diff.minute, let second = diff.second {
                if now > deadline {
                    timeLeft = ""
                    timer?.invalidate()
                } else if day > 0 {
                    timeLeft = "\(day) Day\(day == 1 ? "" : "s") Left"
                } else if hour > 0 {
                    timeLeft = "\(hour) Hour\(hour == 1 ? "" : "s") Left"
                } else if minute > 0 {
                    timeLeft = "\(minute) Min\(minute == 1 ? "" : "s") Left"
                } else {
                    timeLeft = "\(second) Sec\(second == 1 ? "" : "s") Left"
                }
            }
        }
    }
}

#if DEBUG
struct DeadlineCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineCountdownView(
            deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            scholarshipName: "STEM Award",
            amount: 10000
        )
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.black)
    }
}
#endif 
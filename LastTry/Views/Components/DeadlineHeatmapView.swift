import SwiftUI

struct DeadlineHeatmapView: View {
    let applications: [ScholarshipApplication]
    private let months: [Date]
    
    init(applications: [ScholarshipApplication]) {
        self.applications = applications
        let calendar = Calendar.current
        var monthsArray: [Date] = []
        for i in 0..<3 {
            if let date = calendar.date(byAdding: .month, value: i, to: Date()) {
                monthsArray.append(date)
            }
        }
        self.months = monthsArray
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Application Hotspots")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            VStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, applications: applications)
                }
            }
            .padding()
            .background(Color.black.opacity(0.2))
            .cornerRadius(15)
        }
    }
}

private struct MonthView: View {
    let month: Date
    let applications: [ScholarshipApplication]
    private let calendar = Calendar.current
    private let days: [Date]
    private let monthFormatter: DateFormatter
    
    init(month: Date, applications: [ScholarshipApplication]) {
        self.month = month
        self.applications = applications
        self.days = Self.generateDays(for: month)
        self.monthFormatter = DateFormatter()
        self.monthFormatter.dateFormat = "MMMM yyyy"
    }
    
    var body: some View {
        VStack {
            Text(monthFormatter.string(from: month))
                .font(.headline.bold())
                .foregroundColor(.white)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { day in
                    DayView(day: day, deadlines: deadlines(for: day))
                }
            }
        }
    }
    
    private func deadlines(for day: Date) -> Int {
        applications.filter {
            calendar.isDate($0.deadline, inSameDayAs: day)
        }.count
    }
    
    static private func generateDays(for month: Date) -> [Date] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: month),
              let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else { return [] }
        
        let startDate = monthFirstWeek.start
        let endDate = monthLastWeek.end
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate < endDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
}

private struct DayView: View {
    let day: Date
    let deadlines: Int
    private let calendar = Calendar.current
    
    var body: some View {
        Text(isDateInCurrentMonth() ? "\(calendar.component(.day, from: day))" : "")
            .font(.system(size: 12))
            .frame(width: 28, height: 28)
            .background(colorForDay().opacity(0.8))
            .clipShape(Circle())
            .foregroundColor(.white)
    }
    
    private func isDateInCurrentMonth() -> Bool {
        // This logic can be improved, for now, we just show the day number
        return true
    }
    
    private func colorForDay() -> Color {
        if deadlines == 0 {
            return .clear
        } else if deadlines == 1 {
            return .green.opacity(0.5)
        } else if deadlines <= 3 {
            return .yellow.opacity(0.7)
        } else {
            return .red.opacity(0.9)
        }
    }
} 
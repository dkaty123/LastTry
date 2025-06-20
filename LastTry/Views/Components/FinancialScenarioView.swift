import SwiftUI

struct FinancialScenarioView: View {
    @ObservedObject var viewModel: FinancialPlanningViewModel
    @State private var additionalMonthlySavings: Double = 100

    private var remainingBalance: Double {
        viewModel.remainingBalance
    }

    private var monthsToGoal: Double {
        guard remainingBalance > 0 else { return 0 }
        let currentMonthlySavings = viewModel.financialPlan.monthlyBudget - viewModel.monthlyExpenses
        let totalMonthlySavings = currentMonthlySavings + additionalMonthlySavings
        guard totalMonthlySavings > 0 else { return .infinity }
        return remainingBalance / totalMonthlySavings
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\"What If\" Scenarios")
                .font(.title2.bold())
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 20) {
                Text("See how extra savings can fast-track your goals. What if you saved an extra...")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                Text("$\(String(format: "%.0f", additionalMonthlySavings))/month")
                    .font(.title.bold())
                    .foregroundColor(Theme.accentColor)
                
                Slider(value: $additionalMonthlySavings, in: 0...1000, step: 25)
                    .tint(Theme.accentColor)

                Divider().background(Color.white.opacity(0.2))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Time to Reach Funding Goal:")
                        .font(.headline)
                        .foregroundColor(.white)

                    if monthsToGoal.isInfinite {
                        Text("Your expenses exceed your budget. Increase savings to see a forecast.")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    } else if monthsToGoal == 0 {
                        Text("🎉 You've already reached your funding goal! 🎉")
                            .font(.subheadline.bold())
                            .foregroundColor(.green)
                    } else {
                        Text("\(String(format: "%.1f", monthsToGoal)) months")
                            .font(.title2.bold())
                            .foregroundColor(.green)
                    }
                }
            }
            .padding()
            .background(Color.black.opacity(0.2))
            .cornerRadius(15)
        }
    }
} 
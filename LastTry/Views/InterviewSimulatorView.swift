import SwiftUI

struct InterviewSimulatorView: View {
    @State private var started = false
    @State private var currentQuestion: String? = nil
    @State private var userAnswer: String = ""
    @State private var feedback: String? = nil
    
    // Example questions
    let questions = [
        "Tell me about yourself.",
        "Why are you interested in this scholarship?",
        "What are your academic strengths?",
        "Describe a challenge you've overcome.",
        "Where do you see yourself in five years?"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.primaryGradient.ignoresSafeArea()
                VStack(spacing: 24) {
                    Text("AI Interview Simulator")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 32)
                    Text("Practice common scholarship interview questions and get instant AI feedback!")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    if !started {
                        Button(action: startInterview) {
                            Label("Start Mock Interview", systemImage: "play.circle.fill")
                                .font(.title2.bold())
                                .padding()
                                .background(Theme.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                    } else {
                        VStack(spacing: 18) {
                            if let question = currentQuestion {
                                Text(question)
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.white.opacity(0.08))
                                    .cornerRadius(12)
                                TextField("Type your answer...", text: $userAnswer, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.horizontal)
                                Button("Submit Answer") {
                                    submitAnswer()
                                }
                                .padding(.top, 4)
                                .buttonStyle(.borderedProminent)
                                .tint(.blue)
                                if let feedback = feedback {
                                    Text("AI Feedback:")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                    Text(feedback)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Interview Simulator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func startInterview() {
        started = true
        currentQuestion = questions.randomElement()
        userAnswer = ""
        feedback = nil
    }
    
    func submitAnswer() {
        // Placeholder AI feedback logic
        if userAnswer.isEmpty {
            feedback = "Try to give a detailed answer to make a strong impression!"
        } else if userAnswer.count < 30 {
            feedback = "Good start! Try to elaborate a bit more."
        } else {
            feedback = "Great answer! You addressed the question clearly."
        }
    }
}

#Preview {
    InterviewSimulatorView()
} 
import SwiftUI

struct QCMView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: []
    ) var users: FetchedResults<User>
    
    
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int?
    @State private var score = 0
    @State private var quizCompleted = false
    @State private var showScore = false

    let model = Model()

    var body: some View {
        VStack {
            if quizCompleted {
                Text("Quiz Completed! Your score: \(score)/\(model.questions.count)")
                Button("Take Again") {
                    restartQuiz()
                }
            } else {
                Text(model.questions[currentQuestionIndex].statement)
                    .padding()

                ForEach(model.questions[currentQuestionIndex].proposal.indices, id: \.self) { index in
                    Button(action: {
                        selectedAnswerIndex = index
                        checkAnswerAndAdvance()
                    }) {
                        Text(model.questions[currentQuestionIndex].proposal[index])
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    
                    .padding(.top, 5)
                }
            }
        }
        .onAppear(perform: checkPreviousCompletion)
    }

    private func checkAnswerAndAdvance() {
        if selectedAnswerIndex != nil && selectedAnswerIndex! + 1 == model.questions[currentQuestionIndex].answer.rawValue {
            score += 1
        }
        if currentQuestionIndex < model.questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
        } else {
            quizCompleted = true
            saveCompletion()
        }
    }

    private func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        quizCompleted = false
        selectedAnswerIndex = nil
    }

    private func checkPreviousCompletion() {
        // Assume the first user is the logged in user for simplicity
        if let user = users.first, user.hasCompletedQuiz {
            quizCompleted = true
            score = Int(user.lastScore)
        }
    }

    private func saveCompletion() {
        if let user = users.first {
            print("le user",user)
            user.hasCompletedQuiz = true
            user.lastScore = Int16(score)
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}

#Preview {
    QCMView()
}

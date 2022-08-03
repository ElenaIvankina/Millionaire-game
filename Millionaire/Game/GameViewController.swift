//
//  GameViewController.swift
//  Millionaire
//
//  Created by Елена Иванкина on 09.07.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var symbolImage: UIImageView!
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionRightNumberLabel: UILabel!
    
    var gameDelegate: GameDelegate?
    var alertDelegate: AlertGameDelegate?
    var questionOrderStrategy: QuestionsOrderStrategy?
    var questions: [Question] = QuestionsSingleton.shared.arrQ
    var currentQuestionNumber: Observable<Int> = Observable(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        symbolImage.image = UIImage(named: "GameSymbol")
        questionTextView.isEditable = false
        GameSingleton.shared.gameSession?.countOfQuestions = questions.count
        GameSingleton.shared.gameSession?.notUseNumberQuestion = Array(0...questions.count-1)
        currentQuestionNumber.addObserver(self, options: [.new] , closure: { number, change in
            DispatchQueue.main.async {
                self.questionNumberLabel.text = "Вы отвечаете на вопрос №\(number + 1)"
            }
        })
        GameSingleton.shared.gameSession?.counterRightAnswers.addObserver(self, options: [.new] , closure: { number, change in
            DispatchQueue.main.async {
                self.questionRightNumberLabel.text = "Вы ответили правильно на \(number) из \(self.questions.count) вопросов "
            }
        })
        currentQuestionNumber.value = questionOrderStrategy!.giveNextQuestionNumber(notUseQuestionNumbers: &GameSingleton.shared.gameSession!.notUseNumberQuestion)
        fillQuestionAndAnswers(question: questions[currentQuestionNumber.value])
    }
    
    

    @IBAction func answer1Tapped(_ sender: UIButton) {
        handlingAnswer(answer: sender.currentTitle ?? "")
    }
    
    @IBAction func answer2Tapped(_ sender: UIButton) {
        handlingAnswer(answer: sender.currentTitle ?? "")
    }
    
    @IBAction func answer3Tapped(_ sender: UIButton) {
        handlingAnswer(answer: sender.currentTitle ?? "")
    }
    
    @IBAction func answer4Tapped(_ sender: UIButton) {
        handlingAnswer(answer: sender.currentTitle ?? "")
    }
    
    private func fillQuestionAndAnswers (question: Question) {
        DispatchQueue.main.async {
            self.questionTextView.text = question.question
            self.answer1Button.setTitle(question.allAnswers[0], for: .normal)
            self.answer2Button.setTitle(question.allAnswers[1], for: .normal)
            self.answer3Button.setTitle(question.allAnswers[2], for: .normal)
            self.answer4Button.setTitle(question.allAnswers[3], for: .normal)
        }
    }
    
    private func handlingAnswer (answer: String) {
        guard let gameDelegate = gameDelegate else {return}
        if gameDelegate.checkAnswer(q: questions[currentQuestionNumber.value], answer: answer) {
            rightAnswer()
        } else {
            wrongAnswer()
        }
    }
    
    private func rightAnswer () {
        GameSingleton.shared.gameSession?.counterRightAnswers.value += 1
        if let number = questionOrderStrategy?.giveNextQuestionNumber(notUseQuestionNumbers: &GameSingleton.shared.gameSession!.notUseNumberQuestion), number >= 0 {
            currentQuestionNumber.value = number
            fillQuestionAndAnswers(question: questions[currentQuestionNumber.value])
        }

        else {
            endGame()
            alertDelegate?.makeAlertController(title1: "Ура!", title2: "ОК", message: "Вы ответили на все вопросы правильно")
        }
    }
    
    private func wrongAnswer () {
        endGame()
        alertDelegate?.makeAlertController(title1: "Упс!", title2: "ОК", message: "Вы проиграли \n Количество правильных ответов: \(GameSingleton.shared.gameSession?.counterRightAnswers.value ?? 0) из \(GameSingleton.shared.gameSession?.countOfQuestions ?? 0)")
    }
    
    private func endGame() {
        if let rightAnswers = GameSingleton.shared.gameSession?.counterRightAnswers.value,  let questions = GameSingleton.shared.gameSession?.countOfQuestions {
            let result = (rightAnswers * 100) / questions
            GameSingleton.shared.addResult(result: result)
        }
        dismiss(animated: true, completion: nil)

    }
}

protocol GameDelegate: AnyObject {
    func checkAnswer(q: Question, answer: String) -> Bool
}

protocol AlertGameDelegate: AnyObject {
    func makeAlertController(title1: String, title2: String, message: String)
}

protocol QuestionsOrderStrategy {
    func giveNextQuestionNumber(notUseQuestionNumbers: inout [Int]) -> Int
}



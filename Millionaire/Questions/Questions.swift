//
//  Questions.swift
//  Millionaire
//
//  Created by Елена Иванкина on 11.07.2021.
//

import Foundation

class QuestionsSingleton: GameDelegate {
    
    private let questionsCareTaker = CareTakerQuestions()
    static let shared = QuestionsSingleton()
    
    var arrQ: [Question] {
        didSet {
            questionsCareTaker.saveQuestions(questions: arrQ)
        }
    }
    
    private init() {
        arrQ = questionsCareTaker.loadQuestions() ?? [
            Question(question: "Как публика может донести до актера свое недовольство его игрой?", rightAnswer: "Освистать", allAnswers: ["Остудить", "Осмотреть", "Осадить", "Освистать"]),
            Question(question: "Как по-другому называется шпион?", rightAnswer: "Секретный агент", allAnswers: ["Секрет", "Секреция", "Секретарь", "Секретный агент"]),
            Question(question: "Из чего была сделана туфелька Золушки?", rightAnswer: "Хрусталь", allAnswers: ["Сахар", "Железо", "Хрусталь", "Золото"]),
            Question(question: "На сколько семей рассчитан дуплекс?", rightAnswer: "Две", allAnswers: ["Четыре", "Две", "Три", "Одна"]),
            Question(question: "В меню какого ресторана можно найти блюдо полента? ", rightAnswer: "Итальянского", allAnswers: ["Турецкого", "Китайского", "Индийского", "Итальянского"])]
    }

    
    func checkAnswer(q: Question, answer: String) -> Bool {
        return q.rightAnswer == answer
    }
    
    
}



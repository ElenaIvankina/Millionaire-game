//
//  Question.swift
//  Millionaire
//
//  Created by Елена Иванкина on 11.07.2021.
//

import Foundation

class Question: Codable {
    let question: String
    let rightAnswer: String
    let allAnswers: [String]
    
    init (question: String, rightAnswer: String, allAnswers: [String]) {
        self.question = question
        self.rightAnswer = rightAnswer
        self.allAnswers = allAnswers
    }
}

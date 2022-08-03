//
//  GameSingleton.swift
//  Millionaire
//
//  Created by Елена Иванкина on 11.07.2021.
//


import Foundation

class GameSingleton {
    
    static let shared = GameSingleton()
    var gameSession: GameSession?
    private let resultsCareTaker = CareTaker()
    
    private init() {
        results = resultsCareTaker.loadResults() ?? []
    }
    
    private(set) var results: [Int] {
        didSet {
            resultsCareTaker.saveResults(results: results)
        }
    }
    
    func addResult(result: Int) {
        results.append(result)
    }
    
    func clearRecors() {
        results.removeAll()
    }
    
}

class GameSession {
    var counterRightAnswers: Observable<Int> = Observable(0)
    var countOfQuestions: Int = 0
    var notUseNumberQuestion: [Int] = []
}

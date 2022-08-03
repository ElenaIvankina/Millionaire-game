//
//  RandomQuestionOrderStrategy.swift
//  Millionaire
//
//  Created by Елена Иванкина on 14.07.2021.
//

import UIKit

class RandomQuestionOrderStrategy: QuestionsOrderStrategy {
    
    func giveNextQuestionNumber( notUseQuestionNumbers: inout [Int]) -> Int {
        var nextQuestionNumber = -1
        if notUseQuestionNumbers.count > 0 {
            let randomNumber = arc4random_uniform(UInt32(notUseQuestionNumbers.count - 1))
            nextQuestionNumber = notUseQuestionNumbers[Int(randomNumber)]
            let index = notUseQuestionNumbers.firstIndex(of: nextQuestionNumber)!
            notUseQuestionNumbers.remove(at: index)
        }
        return nextQuestionNumber
    }
    
}

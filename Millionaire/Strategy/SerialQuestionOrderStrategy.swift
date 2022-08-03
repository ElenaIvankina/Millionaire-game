//
//  SerialQuestionOrderStrategy.swift
//  Millionaire
//
//  Created by Елена Иванкина on 14.07.2021.
//

import UIKit

class SerialQuestionOrderStrategy: QuestionsOrderStrategy {
    
    func giveNextQuestionNumber( notUseQuestionNumbers: inout [Int]) -> Int {
        var nextQuestionNumber = -1
        if notUseQuestionNumbers.count > 0 {
            nextQuestionNumber = notUseQuestionNumbers[0]
            let index = notUseQuestionNumbers.firstIndex(of: nextQuestionNumber)!
            notUseQuestionNumbers.remove(at: index)
        }
        return nextQuestionNumber
    }
    
}

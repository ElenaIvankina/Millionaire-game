//
//  NewQuestionViewController.swift
//  Millionaire
//
//  Created by Елена Иванкина on 17.07.2021.
//

import UIKit

class NewQuestionViewController: UIViewController {

    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var rightAnswerTextField: UITextField!
    
    @IBOutlet weak var wrongAnswer1TextField: UITextField!
    
    @IBOutlet weak var wrongAnswer2TextField: UITextField!
    
    @IBOutlet weak var wrongAnswer3TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func checkData() -> Bool {
        
        if questionTextField.text!.isEmpty || rightAnswerTextField.text!.isEmpty || wrongAnswer1TextField.text!.isEmpty || wrongAnswer2TextField.text!.isEmpty || wrongAnswer3TextField.text!.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    private func makeAlertController(title1: String, title2: String, message: String) {
            let alert = UIAlertController(title: title1, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: title2, style: .default, handler: nil)
            alert.addAction(action)
        present(alert, animated: true, completion: nil)
        }
    
    @IBAction func pressReadyButton(_ sender: Any) {
        if checkData() {
            let q = Question(question: questionTextField.text!, rightAnswer: rightAnswerTextField.text!, allAnswers: [rightAnswerTextField.text!, wrongAnswer2TextField.text!, wrongAnswer1TextField.text!, wrongAnswer3TextField.text!])
            QuestionsSingleton.shared.arrQ.append(q)
            dismiss(animated: true, completion: nil)
        } else {
            makeAlertController(title1: "Упс", title2: "Ок", message: "Заполните все поля")
        }
        
    }
    


}

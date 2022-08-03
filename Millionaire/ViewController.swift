//
//  ViewController.swift
//  Millionaire
//
//  Created by Елена Иванкина on 09.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var symbolImage: UIImageView!
    @IBOutlet weak var selectedStrategyControl: UISegmentedControl!
    
    private var selectedStrategy: QuestionsOrderStrategy {
        switch selectedStrategyControl.selectedSegmentIndex {
        case 0:
            return SerialQuestionOrderStrategy()
        case 1:
            return RandomQuestionOrderStrategy()
        default:
            return SerialQuestionOrderStrategy()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symbolImage.image = UIImage(named: "GameSymbol")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "NewGame":
            if let destinationVC = segue.destination as? GameViewController {
                destinationVC.gameDelegate = QuestionsSingleton.shared
                destinationVC.alertDelegate = self
                destinationVC.questionOrderStrategy = selectedStrategy
                GameSingleton.shared.gameSession = nil
                let gameSession = GameSession()
                GameSingleton.shared.gameSession = gameSession
            }
        default:
            break
        }
    }
    
    

    @IBAction func pressNewGameButton(_ sender: Any) {
        performSegue(withIdentifier: "NewGame", sender: nil)
    }
    
    @IBAction func pressResultsButton(_ sender: Any) {
        performSegue(withIdentifier: "ResultTable", sender: nil)
    }
    @IBAction func pressNewQuestionButton(_ sender: Any) {
        performSegue(withIdentifier: "NewQuestion", sender: nil)
    }
}

extension ViewController: AlertGameDelegate {
    
        func makeAlertController(title1: String, title2: String, message: String) {
                let alert = UIAlertController(title: title1, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: title2, style: .default, handler: nil)
                alert.addAction(action)
            present(alert, animated: true, completion: nil)
            }
}


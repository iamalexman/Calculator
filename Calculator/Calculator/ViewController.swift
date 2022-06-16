//
//  ViewController.swift
//  Calculator
//
//  Created by Alex Smith on 16.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var halfScore: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var calc: Calculator!
    override func viewDidLoad() {
        super.viewDidLoad()
        calc = Calculator()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let textLabel = sender.titleLabel?.text
        if let text = textLabel {
            switch text {
            case "+", "-", "x", "/":
                calc.hasOption = true
                calc.option = text
                if calc.firstValue.isEmpty {
                    calc.firstValue = "0"
                } else if !calc.secondValue.isEmpty {
                    calc.exOption = calc.option
                    calc.option = text
                    calc.inMemoryValue = calc.firstValue
                    calc.firstValue = String(calc.calculate(firstArg: calc.firstValue, secondArg: calc.secondValue))
                    calc.secondValue = ""
                    result.text = calc.firstValue
                } else if !calc.inMemoryValue.isEmpty {
                    
                }
            case "=":
                if calc.hasOption {
                    result.text = calc.summaryButtonPressed()
                } else if !calc.inMemoryValue.isEmpty {
                    result.text = String(calc.calculate(firstArg: calc.firstValue, secondArg: calc.inMemoryValue))
                }
//                print("=")
            case "AC":
                calc.cleanButtonPressed()
                halfScore.text = "..."
                result.text = "0"
//                print("🧹🪣")
            case "NEG":
                if calc.neg == true {
                    calc.neg = false
                } else {
                    calc.neg = true
                }
                result.text = calc.negativeButtonPressed(value: result.text!)
//                print("negative")
            default:
                if !calc.hasOption {
                    calc.firstValue = calc.firstValue + text
                    result.text = calc.firstValue
                    halfScore.text = calc.firstValue
                    calc.isFirstNum = false
                } else {
                    calc.secondValue = calc.secondValue + text
                    result.text = calc.secondValue
                    halfScore.text = String(calc.calculate(firstArg: calc.firstValue, secondArg: calc.secondValue))
                }
                calc.isFirstNum = false
                if calc.error {
                    result.text = "Error"
                    calc.cleanButtonPressed()
                }
            }
        }
    }
}

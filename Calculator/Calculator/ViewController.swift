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
                calc.isFirstNum = true
                if calc.firstValue.isEmpty {
                    calc.firstValue = "0"
                } else if !calc.secondValue.isEmpty {
                    calc.exOption = calc.option
                    calc.option = text
                    calc.inMemoryValue = calc.firstValue
                    calc.firstValue = String(format: "%.8f",calc.calculate(firstArg: calc.firstValue, secondArg: calc.secondValue))
                    calc.secondValue = ""
                    result.text = calc.firstValue.shorted(to: 10)
                }
            case "=":
                if calc.hasOption {
                    result.text = calc.summaryButtonPressed().shorted(to: 10)
                } else if !calc.inMemoryValue.isEmpty {
                    result.text = String(format: "%.8f",calc.calculate(firstArg: calc.firstValue, secondArg: calc.inMemoryValue))
                }
                calc.neg = false
                calc.secondValue = ""
                calc.isFirstNum = true
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
                if !calc.isFirstNum && text == "0" && result.text == "0" {
                    break
                }
                if !calc.hasOption {
                    if calc.firstValue == "0" {
                        calc.firstValue = ""
                    }
                    calc.firstValue = calc.firstValue.shorted(to: 9) + text
                    result.text = calc.firstValue
                    halfScore.text = calc.firstValue
                } else {
                    if calc.secondValue == "0" {
                        calc.secondValue = ""
                    }
                    calc.secondValue = calc.secondValue.shorted(to: 9) + text
                    result.text = calc.secondValue
                    halfScore.text = String(format: "%.8f", calc.calculate(firstArg: calc.firstValue, secondArg: calc.secondValue)).shorted(to: 10)
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

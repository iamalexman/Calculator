//
//  Calculator.swift
//  Calculator
//
//  Created by Alex Smith on 16.06.2022.
//

import Foundation

// ARG1 + ARG2 * = SUM

protocol Calculating {

    var summary: String { get set }
    var firstValue: String { get set }
    var secondValue: String { get set }
    var inMemoryValue: String { get set }
    var option: String { get set }
    var isFirstNum: Bool { get set }
    var error: Bool { get set }
    var hasOption: Bool { get set }
    var neg: Bool { get set }
    static var maxLen: Int { get }

    mutating func cleanButtonPressed()
    mutating func calculate(firstArg: String, secondArg: String) -> Double
    mutating func summaryButtonPressed() -> String
    mutating func optionButtonPressed(sign: String)
    mutating func negativeButtonPressed(value: String) -> String
}

struct Calculator: Calculating {

    var firstValue = ""
    var secondValue = ""
    var option = ""
    var inMemoryValue = ""
    var summary = ""
    var exOption = ""
    var isFirstNum = true
    var error = false
    var hasOption = false
    var neg = false
    static let maxLen = 8

    mutating func cleanButtonPressed() {
        summary = ""
        firstValue = ""
        secondValue = ""
        inMemoryValue = ""
        option = ""
        exOption = ""
        isFirstNum = true
        error = false
        hasOption = false
        neg = false
    }

    mutating func calculate(firstArg: String, secondArg: String) -> Double {
        let firstNumber = Double(firstArg) ?? 0
        let secondNumber = Double(secondArg) ?? 0
//        firstValue = ""
//        secondValue = ""

        switch option {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "x":
            return firstNumber * secondNumber
        case "/":
            guard secondNumber != 0 else {
                self.error = true
                return -1
            }
            return firstNumber / secondNumber
        default:
            return 0
        }
    }

    mutating func summaryButtonPressed() -> String  {
        if secondValue == "" && hasOption {
            secondValue = firstValue
            summary = String(calculate(firstArg: firstValue, secondArg: secondValue))
        } else if secondValue != "" {
            summary = String(calculate(firstArg: firstValue, secondArg: secondValue))
            firstValue = summary
        } else {
            summary = ""
        }
        return summary
//        calc.summary = String(format: %.0f, calc.calculate())
    }

    mutating func optionButtonPressed(sign: String) {
//        1) no args
//        1.1) option
//        2) 1 arg + option
//        3) 2 args
//        4) 2 args 2 options
        hasOption = true
        if option == "" {
            option = sign
        } else {
            exOption = option
            option = sign
        }
    }

    mutating func negativeButtonPressed (value: String) -> String {
        var newValue = value
    
        if neg {
            newValue.insert("-", at: newValue.startIndex)
        } else {
            newValue.removeFirst()
        }
        return newValue
    }
}

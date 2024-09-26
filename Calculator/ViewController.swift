//
//  ViewController.swift
//  Calculator
//
//  Created by Gwen Thelin on 9/3/24.
//

import UIKit

enum Operators: String {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "x"
    case division = "÷"
    case percent = "%"
}

enum MiscButtons {
    case clear
    case equal
    case negative
}

enum ButtonType {
    case number(Double)
    case operators(Operators)
    case misc(MiscButtons)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var resultDisplay: UIView!
    @IBOutlet weak var result: UILabel!
    
    var equation: [ButtonType] = []
    var resultOnScreen: String = ""
    var currentNumber: Double = 0
    
    func returnDoubleFromString(_ string: String) -> Double {
        guard let double = Double(string) else {
            print("returnDoubleFromString: string is not a Double")
            return 0 }
        return double
    }
    
    func clearZeroes() {
        if resultOnScreen.first == "0" {
            resultOnScreen.removeFirst()
        }
        if resultOnScreen.last == "0" && resultOnScreen.contains(".") {
            resultOnScreen.removeLast()
            
            if resultOnScreen.hasSuffix(".") {
                resultOnScreen.removeLast()
            }
        }
    }
    
    func concatenateDigits() {
        resultOnScreen.append(String(currentNumber))
        clearZeroes()
        result.text = resultOnScreen
    }
    
    func addToEquation(_ button: ButtonType) {
        equation.append(button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let resultOnScreenToAssign = result.text else { return }
        resultOnScreen = resultOnScreenToAssign
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultDisplay.layer.cornerRadius = 35
    }
    
    @IBAction func touchNumber(_ sender: UIButton) {
        if let numberTouchedAsString = sender.titleLabel?.text {
            if numberTouchedAsString  == "." {
                if !resultOnScreen.contains(".") {
                    resultOnScreen.append(".")
                    result.text?.append(".")
                } else { return }
            } else {
                let numberTouchedAsDouble = returnDoubleFromString(numberTouchedAsString)
                if currentNumber != 0 {
                    currentNumber = numberTouchedAsDouble
                } else {
                    currentNumber = currentNumber * 10 + Double(numberTouchedAsDouble)
                }
                concatenateDigits()
            }
        } else { print("Could not convert button label to a String") }
    }
    
    @IBAction func clearButtonTouched(_ sender: UIButton) {
        equation.removeAll()
        result.text = "0"
        resultOnScreen = result?.text ?? "0"
        currentNumber = 0
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        print("""
              equation: \(equation)
              resultOnScreen: \(resultOnScreen)
              currentNumber: \(currentNumber)
              """)
        print()
        
        guard let operatorTouchedAsString = sender.titleLabel?.text else {
            print("operator title could not be converted to string")
            return
        }
        
        guard let currentOperator = Operators(rawValue: operatorTouchedAsString) else {
            print("Operator could not be converted to the Operators type")
            return
        }
        
        equation.append(ButtonType.number(returnDoubleFromString(resultOnScreen)))
        equation.append(ButtonType.operators(currentOperator))
        
        print("""
              equation: \(equation)
              resultOnScreen: \(resultOnScreen)
              currentNumber: \(currentNumber)
              """)
        
        result.text = "0"
        resultOnScreen = result?.text ?? "0"
        currentNumber = 0
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        equation.append(ButtonType.number(returnDoubleFromString(resultOnScreen)))
        
        if let operatorToUse = equation.first(where: {
            if case .operators = $0 {
                return true
            } else {
                return false
            }
        }) {
            print("""
                         equation: \(equation)
                         resultOnScreen: \(resultOnScreen)
                         currentNumber: \(currentNumber)
                         """)
            
            let getOperatorRawValue: () -> String = {
                if case let .operators(value) = operatorToUse {
                    return value.rawValue
                } else {
                    return "Error converting operator to string."
                }
            }
            
            let getDoubleFromNumberType: (_ number: ButtonType) -> Double = {number in 
                if case let .number(value) = number {
                    print(value)
                    return value
                } else {
                    return 0
                }
            }
            
            var resultToCalculate: Double = getDoubleFromNumberType((equation.first(where: {
                if case .number = $0 {
                    return true
                } else {
                    return false
                }
            }) ?? ButtonType.number(0)))
            
            equation.remove(at: equation.firstIndex(where: {
                if case .number = $0 {
                    return true
                } else {
                    return false
                }
            }) ?? 0)
            
            for element in equation {
                switch element {
                case .number:
                    let numberToCalculate = getDoubleFromNumberType(element)
                    switch getOperatorRawValue() {
                    case "+":
                        resultToCalculate += numberToCalculate
                    case "-":
                        resultToCalculate -= numberToCalculate
                    case "x":
                        resultToCalculate = resultToCalculate * numberToCalculate
                    case "/":
                        resultToCalculate = resultToCalculate / numberToCalculate
                    default:
                        break
                    }
                default:
                    break
                }
            }
            print(resultToCalculate)
            
            equation.removeAll()
            equation.append(.number(resultToCalculate))
        }
    }
}

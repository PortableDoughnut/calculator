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
    case multiplication = "*"
    case division = "÷"
}

class ViewController: UIViewController {

    @IBOutlet weak var resultDisplay: UIView!
    @IBOutlet weak var result: UILabel!
    
    var zeroPressed: Bool = false
    var isFirstNumber: Bool = true
    var firstNumber: String = ""
    var secondNumber: String = ""
    var operatorPressed: Operators?
    var operatorExists: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultDisplay.layer.cornerRadius = 35
    }

    @IBAction func touchNumber(_ sender: UIButton) {
        let numberPressed = sender.titleLabel?.text ?? ""
        let previousResultText = result.text ?? ""
        
        if previousResultText == "0" {
            if numberPressed == "0" {
                zeroPressed = true
            } else {
                result.text = numberPressed
                if isFirstNumber {
                    firstNumber.append(numberPressed)
                } else {
                    secondNumber.append(numberPressed)
                }
            }
        } else {
            result.text?.append(numberPressed)
            if isFirstNumber {
                firstNumber.append(numberPressed)
            } else {
                secondNumber.append(numberPressed)
            }
            zeroPressed = false
            
            print("firstNumber: \(firstNumber)")
            print("secondNumber: \(secondNumber)")
            print("operator: \(operatorPressed != nil ? operatorPressed!.rawValue : "none")")
        }
    }
    
    @IBAction func clearButtonTouched(_ sender: UIButton) {
        result.text = "0"
        firstNumber = ""
        secondNumber = ""
        isFirstNumber = true
        operatorExists = false
        operatorPressed = nil
    }
    
    @IBAction func operatorToched(_ sender: UIButton) {
        if !operatorExists {
            switch sender.titleLabel?.text {
            case "+":
                operatorPressed = .addition
                result.text?.append(" + ")
            case "-":
                operatorPressed = .subtraction
                result.text?.append(" - ")
            case "x":
                operatorPressed = .multiplication
                result.text?.append(" * ")
            case "÷":
                operatorPressed = .division
                result.text?.append(" ÷ ")
            default:
                print("No operator found")
            }
            
            isFirstNumber = false
            operatorExists = true
        }
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        if !operatorExists {
            return
        }
        
        let answer: String
        
        switch operatorPressed {
        case .addition:
            answer = String(Double(firstNumber)! + Double(secondNumber)!)
        case .division:
            answer = String(Double(firstNumber)! / Double(secondNumber)!)
        case .multiplication:
            answer = String(Double(firstNumber)! * Double(secondNumber)!)
        case .subtraction:
            answer = String(Double(firstNumber)! - Double(secondNumber)!)
        default:
            print("Error: No operator pressed")
            answer = "0"
        }
        result.text = answer
        firstNumber = answer
        secondNumber = ""
        operatorExists = false
        operatorPressed = nil
    }
}


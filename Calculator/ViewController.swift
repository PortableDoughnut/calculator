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
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        
    }
}

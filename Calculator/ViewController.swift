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
        guard let double = Double(string) else { return 0 }
        return double
    }
    
    func clearZeroes() {
        if resultOnScreen.first == "0" {
            resultOnScreen.removeFirst()
        }
        if resultOnScreen.last == "0" && resultOnScreen.contains(".") {
            resultOnScreen.removeLast()
        }
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
            let numberTouchedAsDouble = returnDoubleFromString(numberTouchedAsString)
            if currentNumber != 0 {
                currentNumber = numberTouchedAsDouble
            } else {
                currentNumber = currentNumber * 10 + Double(numberTouchedAsDouble)
            }
        } else { print("Could not convert button label to a Int") }
        resultOnScreen.append(String(currentNumber))
        if resultOnScreen.contains(".0") {
            resultOnScreen = resultOnScreen.replacingOccurrences(of: ".0", with: "")
        }
        clearZeroes()
        result.text = resultOnScreen
    }
    
    @IBAction func clearButtonTouched(_ sender: UIButton) {
        
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        
    }
}

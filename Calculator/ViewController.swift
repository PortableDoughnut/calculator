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
    
    
    func returnDoubleFromString(_ string: String) -> Double {
        guard let double = Double(string) else { return 0 }
        return double
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultDisplay.layer.cornerRadius = 35
    }

    @IBAction func touchNumber(_ sender: UIButton) {
        
    }
    
    @IBAction func equalTouched(_ sender: UIButton) {
        
    }
}

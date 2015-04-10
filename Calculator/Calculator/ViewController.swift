//
//  ViewController.swift
//  Calculator
//
//  Created by Jason Wu on 4/7/15.
//  Copyright (c) 2015 Jason Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleofTypingANumber = false
    
    @IBAction func AppendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleofTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleofTypingANumber = true
        }
        println("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleofTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperationTwoArg {$0 * $1}
        case "÷": performOperationTwoArg {$1 / $0}
        case "+": performOperationTwoArg {$0 + $1}
        case "−": performOperationTwoArg {$1 - $0}
        case "√": performOperationOneArg {sqrt($0)}
        default: break
        }
    }
    
    func performOperationTwoArg(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperationOneArg(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleofTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleofTypingANumber = false
        }
    }
}
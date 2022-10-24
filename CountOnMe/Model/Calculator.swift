//
//  Calculator.swift
//  CountOnMe
//
//  Created by Cobra on 10/10/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {

    // MARK: - Properties
    
    private var output: String = "0"
    private let operands: [String] = ["+", "-", "x", "÷"]
    
    private var elements: [String] {
        return output.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        // We know for sure that output is never empty, so neither are elements
        return !operands.contains(elements.last!)
    }
    
    private var expressionHaveResult: Bool {
        return output.firstIndex(of: "=") != nil
    }
    
    private var errorDivisionByZero: Bool {
        return elements.last == "Error"
    }
    
    // MARK: - Methods
    
    // Allow operand change during operation and new operation with previous result
    private func addOperator(_ operand: String) -> String {
        guard !errorDivisionByZero else {
            return output
        }
        
        if !canAddOperator {
            output.removeLast(3)
        } else if expressionHaveResult {
            output = elements.last!
        }
        output.append(operand)
        return output
    }
    
    func addNumber(_ input: String) -> String {
        if expressionHaveResult {
            output = ""
        }
        
        // Avoid several zeros in a row
        if input != "0" && output == "0" {
            output = input
        } else if output == "-0" {
            output = "-\(input)"
        } else if (input == "0" && output != "0") || input != "0" {
            output.append(input)
        }
        
        return output
    }
    
    func add() -> String {
        addOperator(" + ")
    }
    
    func substract() -> String {
        addOperator(" - ")
    }
    
    func multiply() -> String {
        addOperator(" x ")
    }
    
    func divide() -> String {
        addOperator(" ÷ ")
    }
    
    func signChange() -> String {        
        let result = elements.last!
        
        // if sign negative
        if expressionHaveResult {
            if result.contains("-") {
                output = String(result.dropFirst())
            } else {
                if errorDivisionByZero {
                    output = "-0"
                } else {
                    output = "-\(result)"
                }
            }
        } else if canAddOperator {
            output.removeLast(result.count)
            if result.contains("-") {
                output.append(String(result.dropFirst()))
            } else {
                output.append("-\(result)")
            }
        } else if !canAddOperator {
            output.append("-")
        }
        
        return output
    }
    
    func getPercent() -> String {
        let result = elements.last!
        var percent: Double
        
        guard result != "0" && result != "0." && !errorDivisionByZero else {
            return output
        }
        
        if expressionHaveResult {
            percent = computeDivision(leftStr: result, right: 100)
            output = "\(percent)"
        } else if canAddOperator {
            percent = computeDivision(leftStr: result, right: 100)
            output.removeLast(result.count)
            output.append("\(percent)")
        }
        
        return output
    }
    
    func addDecimalSeparator() -> String {
        if expressionHaveResult {
            output = "0."
        } else if !canAddOperator {
            output.append("0.")
        } else if !elements.last!.contains(".") {
            output.append(".")
        }
        return output
    }
    
    private func computeDivision(leftStr: String, right: Double) -> Double {
        // Specific case with division by number which are multiple of 10 (100, 200, 1000, etc.)
        // In some rare cases, the result of a Double divided by 100 (or any multiple of 10) is incorrect (ex: 5.6 / 100 = 0.05599... by default)
        
        let left = Double(leftStr)!
        
        if left.hasDecimal && !right.hasDecimal && Int(right).isMultiple(of: 10) {
            // Get number of digits of right number -1 (ex: 100 will return 2), representing movement of the decimal separator
            let rightStr = String(Int(right))
            let numberOfDigits = rightStr.count
            let gap = numberOfDigits - 1
            
            // First, divide by righNumberOne (ex: if right number is 900, divide by 9 first to keep precision)
            let rightNumberOne = Double(rightStr.prefix(1))! // (in our example, rightNumberOne = 9)
            let firstOperation = left / rightNumberOne // (in our example, firstOperation = left / 9)
            
            // Get number of decimal digits of firstOperation result
            let decimalDigits = String(firstOperation).split(separator: ".")[1]
            let decimalDigitsNumber = decimalDigits.count
            
            // Second, divide by numberTwo (ex: if right number is 900, divide by 100 after first division)
            let rightNumberTwo = right / rightNumberOne // (in our example, rightNumberTwo = 100)
            
            // Correction of mistake for some divisions (ex: 5.6 / 100 = 0.05599... by default, become 0.056 as expected)
            return (firstOperation / rightNumberTwo).roundToDecimal(decimalDigitsNumber + gap)
        } else {
            return left / right
        }
    }
    
    private func formatWholeNumber(_ resultStr: String) -> String {
        // Return integer number if decimal is 0
        if resultStr.hasSuffix(".0") {
            return String(resultStr.dropLast(2))
        }
        return resultStr
    }
    
    private func computePriorityOperations() -> [String] {
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while a multiply or divide operand is still there
        while operationsToReduce.contains("x") || operationsToReduce.contains("÷") {
            // Get index of operand
            guard let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) else {
                return operationsToReduce
            }
            
            let leftStr = operationsToReduce[index-1]
            let left = Double(leftStr)!
            let operand = operationsToReduce[index]
            let right = Double(operationsToReduce[index+1])!
            
            let result: Double
            switch operand {
            case "x": result = left * right
            case "÷": result = computeDivision(leftStr: leftStr, right: right)
            default: return operationsToReduce
            }
            
            // Delete previously calculated operation (left, operand and right elements)
            for _ in 1...3 {
                operationsToReduce.remove(at: index-1)
            }
            
            // Limit maximum fraction digits
            var resultStr: String = result.displayFormatted
            
            // Show integer number if decimal is 0
            resultStr = formatWholeNumber(resultStr)
            
            // Insert the result of the previously calculated operation
            operationsToReduce.insert(resultStr, at: index-1)
        }
        return operationsToReduce
    }
    
    func equal() -> String {
        // Apply only if there is not result already, there is enough elements and expression does not end with an operand
        guard !expressionHaveResult && expressionHaveEnoughElement && canAddOperator else {
            return output
        }
        
        // Compute priority operations first
        let operation = computePriorityOperations()
        
        // Create a local copy of operations (after computing the priority operation)
        var operationsToReduce = operation
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return output
            }
            
            // Limit maximum fraction digits
            var resultStr: String = result.displayFormatted
            
            // Show integer number if decimal is 0
            resultStr = formatWholeNumber(resultStr)
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(resultStr, at: 0)
        }
        
        let operationToReduceStr = "\(operationsToReduce.first!)"
        if operationToReduceStr.contains("inf") || operationToReduceStr.contains("∞") {
            output.append(" = Error")
        } else {
            output.append(" = \(operationToReduceStr)")
        }
        
        return output
    }
    
    func allClear() -> String {
        output = "0"
        return output
    }
}

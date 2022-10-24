//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var calc: Calculator!
    
    override func setUp() {
        super.setUp()
        calc = Calculator()
    }
    
    // Addition
    func testGivenResultIsEmpty_When5plus6_ThenResultEqual11() {
        // When
        let num1 = calc.addNumber("5")
        let operand = calc.add()
        let num2 = calc.addNumber("6")
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(operand, "5 + ")
        XCTAssertEqual(num2, "5 + 6")
        XCTAssertEqual(result, "5 + 6 = 11")
    }
    
    // Substraction with a negative result
    func testGivenResultIsEmpty_When3minus9_ThenResultEqualMinus6() {
        // When
        let num1 = calc.addNumber("3")
        let operand = calc.substract()
        let num2 = calc.addNumber("9")
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "3")
        XCTAssertEqual(operand, "3 - ")
        XCTAssertEqual(num2, "3 - 9")
        XCTAssertEqual(result, "3 - 9 = -6")
    }
    
    // Addition with the first negative number and a positive result
    func testGivenResultIsEmpty_WhenMinus9plus10_ThenResultEqual1() {
        // When
        let num0 = calc.addNumber("-")
        let num1 = calc.addNumber("9")
        let operand = calc.add()
        let num2 = calc.addNumber("10")
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num0, "-")
        XCTAssertEqual(num1, "-9")
        XCTAssertEqual(operand, "-9 + ")
        XCTAssertEqual(num2, "-9 + 10")
        XCTAssertEqual(result, "-9 + 10 = 1")
    }
    
    // Multiplication
    func testGivenResultIsEmpty_When5MultiplyBy5_ThenResultEqual25() {
        // When
        let num1 = calc.addNumber("5")
        let operand = calc.multiply()
        let num2 = calc.addNumber("5")
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(operand, "5 x ")
        XCTAssertEqual(num2, "5 x 5")
        XCTAssertEqual(result, "5 x 5 = 25")
    }
    
    // Division with integer result
    func testGivenResultIsEmpty_When25DivideBy5_ThenResultEqual5() {
        // When
        let num1 = calc.addNumber("25")
        let operand = calc.divide()
        let num2 = calc.addNumber("5")
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "25")
        XCTAssertEqual(operand, "25 ÷ ")
        XCTAssertEqual(num2, "25 ÷ 5")
        XCTAssertEqual(result, "25 ÷ 5 = 5")
    }
    
    // Division with double result
    func testGivenResultIsEmpty_When3dividedby2_ThenResultEqual1point5() {
        // When
        let num1 = calc.addNumber("3")
        let operand = calc.divide()
        let num2 = calc.addNumber("2")
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "3")
        XCTAssertEqual(operand, "3 ÷ ")
        XCTAssertEqual(num2, "3 ÷ 2")
        XCTAssertEqual(result, "3 ÷ 2 = 1.5")
    }
    
    // Change operand plus to minus during operation
    func testGivenResultIs5plus_WhenAddingMinus_ThenResultEqual5Minus() {
        // Given
        let num1 = calc.addNumber("5")
        let operand1 = calc.substract()
        
        // When
        let operand2 = calc.add()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(operand1, "5 - ")
        XCTAssertEqual(operand2, "5 + ")
    }
    
    // Change operand minus to plus during operation
    func testGivenResultIs5minus_WhenAddingPlus_ThenResultEqual5Plus() {
        // Given
        let num1 = calc.addNumber("5")
        let operand1 = calc.add()
        
        // When
        let operand2 = calc.substract()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(operand1, "5 + ")
        XCTAssertEqual(operand2, "5 - ")
    }
    
    // Click twice on equal
    func testGivenResult_WhenAddingEqual_ThenNothingHappens() {
        // Given
        let num1 = calc.addNumber("3")
        let operand = calc.divide()
        let num2 = calc.addNumber("2")
        let result1 = calc.equal()
        
        // When
        let result2 = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "3")
        XCTAssertEqual(operand, "3 ÷ ")
        XCTAssertEqual(num2, "3 ÷ 2")
        XCTAssertEqual(result1, "3 ÷ 2 = 1.5")
        XCTAssertEqual(result2, "3 ÷ 2 = 1.5")
    }
    
    // Adding a number after a result
    func testGivenResult_WhenAddingNumber_ThenNumberOnly() {
        // Given
        let num1 = calc.addNumber("3")
        let operand = calc.add()
        let num2 = calc.addNumber("2")
        let result1 = calc.equal()
        
        // When
        let result2 = calc.addNumber("6")
        
        // Then
        XCTAssertEqual(num1, "3")
        XCTAssertEqual(operand, "3 + ")
        XCTAssertEqual(num2, "3 + 2")
        XCTAssertEqual(result1, "3 + 2 = 5")
        XCTAssertEqual(result2, "6")
    }
    
    // Adding an operand after a result
    func testGivenResult_WhenAddingOperator_ThenKeepResultNumber() {
        // Given
        let num1 = calc.addNumber("3")
        let operand = calc.add()
        let num2 = calc.addNumber("2")
        let result1 = calc.equal()
        
        // When
        let result2 = calc.substract()
        
        // Then
        XCTAssertEqual(num1, "3")
        XCTAssertEqual(operand, "3 + ")
        XCTAssertEqual(num2, "3 + 2")
        XCTAssertEqual(result1, "3 + 2 = 5")
        XCTAssertEqual(result2, "5 - ")
    }
    
    // Adding 0 to existing number
    func testGivenResultIs5_WhenAdding0_ThenResultIs50() {
        // Given
        let num1 = calc.addNumber("5")
                
        // When
        let num2 = calc.addNumber("0")
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(num2, "50")
    }
    
    // Change of sign: take the positive number of the result and make it negative
    func testGivenResultIs5_WhenUsingSignChangeButton_ThenResultIsMinus5() {
        // Given
        let num1 = calc.addNumber("3")
        let operand = calc.add()
        let num2 = calc.addNumber("2")
        let result1 = calc.equal()
        
        // When
        let result2 = calc.signChange()
        
        // Then
        XCTAssertEqual(num1, "3")
        XCTAssertEqual(operand, "3 + ")
        XCTAssertEqual(num2, "3 + 2")
        XCTAssertEqual(result1, "3 + 2 = 5")
        XCTAssertEqual(result2, "-5")
    }
    
    // Change of sign: take the negative number of the result and make it positive
    func testGivenResultIsMinus2_WhenUsingSignChangeButton_ThenResultIsMinus5() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.substract()
        let num2 = calc.addNumber("8")
        let result1 = calc.equal()
        
        // When
        let result2 = calc.signChange()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 - ")
        XCTAssertEqual(num2, "6 - 8")
        XCTAssertEqual(result1, "6 - 8 = -2")
        XCTAssertEqual(result2, "2")
    }
    
    // Change of sign: add negative sign, then a number, right after an operand
    func testGivenBeginOfOperation_WhenUsingSignChangeButtonAndNumber_ThenResultIsOperationPlusNegativeNumber() {
        // Given
        let num1 = calc.addNumber("6")
        let operand1 = calc.multiply()
        
        // When
        let operand2 = calc.signChange()
        let num2 = calc.addNumber("8")
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand1, "6 x ")
        XCTAssertEqual(operand2, "6 x -")
        XCTAssertEqual(num2, "6 x -8")
    }
    
    // Change of sign: add a number, then negative sign, right after an operand
    func testGivenBeginOfOperation_WhenAddingNumberAndUsingSignChangeButton_ThenResultIsOperationPlusNegativeNumber() {
        // Given
        let num1 = calc.addNumber("6")
        let operand1 = calc.multiply()
        
        // When
        let num2 = calc.addNumber("8")
        let operand2 = calc.signChange()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand1, "6 x ")
        XCTAssertEqual(num2, "6 x 8")
        XCTAssertEqual(operand2, "6 x -8")
    }
    
    // Change of sign: add negative to 0
    func testGiven0_WhenUsingSignChangeButton_ThenResultIsMinusZero() {
        // Given
                
        // When
        let operand = calc.signChange()
        
        // Then
        XCTAssertEqual(operand, "-0")
    }
    
    // Change of sign: add negative to 0
    func testGivenMinus0_WhenAdding5_ThenResultIsMinus5() {
        // Given
        let operand1 = calc.signChange()
                
        // When
        let num1 = calc.addNumber("5")
        
        // Then
        XCTAssertEqual(operand1, "-0")
        XCTAssertEqual(num1, "-5")
    }
    
    // Check priority operations
    func testGivenOperation_WhenPriorityOperands_ThenResultIs28() {
        // Given
        let num1 = calc.addNumber("5")
        let operand1 = calc.add()
        let num2 = calc.addNumber("6")
        let operand2 = calc.multiply()
        let num3 = calc.addNumber("3")
        let operand3 = calc.substract()
        let num4 = calc.addNumber("4")
        let operand4 = calc.divide()
        let num5 = calc.addNumber("2")
        let operand5 = calc.add()
        let num6 = calc.addNumber("7")
                
        // When
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(operand1, "5 + ")
        XCTAssertEqual(num2, "5 + 6")
        XCTAssertEqual(operand2, "5 + 6 x ")
        XCTAssertEqual(num3, "5 + 6 x 3")
        XCTAssertEqual(operand3, "5 + 6 x 3 - ")
        XCTAssertEqual(num4, "5 + 6 x 3 - 4")
        XCTAssertEqual(operand4, "5 + 6 x 3 - 4 ÷ ")
        XCTAssertEqual(num5, "5 + 6 x 3 - 4 ÷ 2")
        XCTAssertEqual(operand5, "5 + 6 x 3 - 4 ÷ 2 + ")
        XCTAssertEqual(num6, "5 + 6 x 3 - 4 ÷ 2 + 7")
        XCTAssertEqual(result, "5 + 6 x 3 - 4 ÷ 2 + 7 = 28")
    }
    
    // Division by zero: result after equal
    func testGiven6DividedByZero_WhenEqual_ThenResultIsError() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.divide()
        let num2 = calc.addNumber("0")
                
        // When
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 ÷ ")
        XCTAssertEqual(num2, "6 ÷ 0")
        XCTAssertEqual(result, "6 ÷ 0 = Error")
    }
    
    // Division by zero: result after new operand
    func testGiven6DividedByZero_WhenAddingOperand_ThenResultIsTheSame() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.divide()
        let num2 = calc.addNumber("0")
        let result1 = calc.equal()
                
        // When
        let result2 = calc.add()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 ÷ ")
        XCTAssertEqual(num2, "6 ÷ 0")
        XCTAssertEqual(result1, "6 ÷ 0 = Error")
        XCTAssertEqual(result2, "6 ÷ 0 = Error")
    }
    
    // Division by zero: result after sign-change
    func testGiven6DividedByZero_WhenAddingSignChange_ThenResultIsMinusZero() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.divide()
        let num2 = calc.addNumber("0")
        let result1 = calc.equal()
                
        // When
        let result2 = calc.signChange()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 ÷ ")
        XCTAssertEqual(num2, "6 ÷ 0")
        XCTAssertEqual(result1, "6 ÷ 0 = Error")
        XCTAssertEqual(result2, "-0")
    }
    
    // Division by zero: result after percent
    func testGiven6DividedByZero_WhenAddingPercent_ThenResultIsSame() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.divide()
        let num2 = calc.addNumber("0")
        let result1 = calc.equal()
                
        // When
        let result2 = calc.getPercent()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 ÷ ")
        XCTAssertEqual(num2, "6 ÷ 0")
        XCTAssertEqual(result1, "6 ÷ 0 = Error")
        XCTAssertEqual(result2, "6 ÷ 0 = Error")
    }
    
    // Decimal Separator: after a number
    func testGiven6Plus12Point3_WhenEqual_ThenResultIs18Point3() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.add()
        let num2 = calc.addNumber("1")
        let num3 = calc.addNumber("2")
        let separator = calc.addDecimalSeparator()
        let num4 = calc.addNumber("3")
        
        // When
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 + ")
        XCTAssertEqual(num2, "6 + 1")
        XCTAssertEqual(num3, "6 + 12")
        XCTAssertEqual(separator, "6 + 12.")
        XCTAssertEqual(num4, "6 + 12.3")
        XCTAssertEqual(result, "6 + 12.3 = 18.3")
    }
    
    // Decimal Separator: after an operand
    func testGiven6PlusPoint3_WhenEqual_ThenResultIs6Point3() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.add()
        let separator = calc.addDecimalSeparator()
        let num2 = calc.addNumber("3")
        
        // When
        let result = calc.equal()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 + ")
        XCTAssertEqual(separator, "6 + 0.")
        XCTAssertEqual(num2, "6 + 0.3")
        XCTAssertEqual(result, "6 + 0.3 = 6.3")
    }
    
    // Decimal Separator: after a result
    func testGivenResult_WhenPoint_ThenResultIs0Point() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.add()
        let num2 = calc.addNumber("3")
        let result = calc.equal()
        
        // When
        let separator = calc.addDecimalSeparator()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 + ")
        XCTAssertEqual(num2, "6 + 3")
        XCTAssertEqual(result, "6 + 3 = 9")
        XCTAssertEqual(separator, "0.")
    }
    
    // Decimal Separator: after a number which already has a separator
    func testGivenNumberWithSeparator_WhenPoint_ThenResultIsSame() {
        // Given
        let num1 = calc.addNumber("6")
        let operand = calc.add()
        let num2 = calc.addNumber("8")
        let separator1 = calc.addDecimalSeparator()
        let num3 = calc.addNumber("5")
        
        // When
        let separator2 = calc.addDecimalSeparator()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(operand, "6 + ")
        XCTAssertEqual(num2, "6 + 8")
        XCTAssertEqual(separator1, "6 + 8.")
        XCTAssertEqual(num3, "6 + 8.5")
        XCTAssertEqual(separator2, "6 + 8.5")
    }
    
    // Percent: after a whole number
    func testGivenWholeNumber_WhenPercent_ThenResultIsCorrect() {
        // Given
        let num1 = calc.addNumber("6")
        let num2 = calc.addNumber("5")
        let num3 = calc.addNumber("9")
        
        // When
        let percent = calc.getPercent()
        
        // Then
        XCTAssertEqual(num1, "6")
        XCTAssertEqual(num2, "65")
        XCTAssertEqual(num3, "659")
        XCTAssertEqual(percent, "6.59")
    }
    
    // Percent: afer a result
    func testGivenResult_WhenPercent_ThenResultIsPercentOfResult() {
        // Given
        let num1 = calc.addNumber("5")
        let operand = calc.add()
        let num2 = calc.addNumber("6")
        let result = calc.equal()
        
        // When
        let percent = calc.getPercent()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(operand, "5 + ")
        XCTAssertEqual(num2, "5 + 6")
        XCTAssertEqual(result, "5 + 6 = 11")
        XCTAssertEqual(percent, "0.11")
    }
    
    // Percent: specific case with 5.6
    func testGivenNumber5point6_WhenPercent_ThenResultIsCorrect() {
        // Given
        let num1 = calc.addNumber("5")
        let separator = calc.addDecimalSeparator()
        let num2 = calc.addNumber("6")
        
        // When
        let percent = calc.getPercent()
        
        // Then
        XCTAssertEqual(num1, "5")
        XCTAssertEqual(separator, "5.")
        XCTAssertEqual(num2, "5.6")
        XCTAssertEqual(percent, "0.056")
    }
}

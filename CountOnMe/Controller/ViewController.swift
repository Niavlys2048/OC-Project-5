//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    // MARK: - Properties

    private let calculator = Calculator()

    // MARK: - Methods

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init textView
        textView.text = calculator.allClear()
    }

    // MARK: - Actions
    
    // View actions
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        textView.text = calculator.addNumber(numberText)
    }
    
    @IBAction private func tappedAdditionButton(_ sender: UIButton) {
        textView.text = calculator.add()
    }
    
    @IBAction private func tappedSubstractionButton(_ sender: UIButton) {
        textView.text = calculator.substract()

    }
    
    @IBAction private func tappedMultiplyButton(_ sender: UIButton) {
        textView.text = calculator.multiply()
    }
    
    @IBAction private func tappedDivideButton(_ sender: UIButton) {
        textView.text = calculator.divide()
    }
    
    @IBAction private func tappedAllClearButton(_ sender: UIButton) {
        textView.text = calculator.allClear()
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        textView.text = calculator.equal()
    }
    
    @IBAction private func tappedSignChangeButton(_ sender: UIButton) {
        textView.text = calculator.signChange()
    }
    
    @IBAction func tappedDecimalSeparatorButton(_ sender: UIButton) {
        textView.text = calculator.addDecimalSeparator()
    }
    
    @IBAction func tappedPercentButton(_ sender: UIButton) {
        textView.text = calculator.getPercent()
    }
}

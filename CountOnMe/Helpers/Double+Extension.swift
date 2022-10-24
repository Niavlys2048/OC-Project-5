//
//  Double+Extension.swift
//  CountOnMe
//
//  Created by Cobra on 24/10/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

// https://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift
// https://stackoverflow.com/questions/24051314/precision-string-format-specifier-in-swift
extension Double {
    var displayFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 8
        return numberFormatter.string(for: self) ?? String(self)
    }
    var hasDecimal: Bool {
        return self.truncatingRemainder(dividingBy: 1) != 0
    }
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

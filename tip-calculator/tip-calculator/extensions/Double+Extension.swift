//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 01.08.2023.
//

import Foundation

extension Int {
    var stringValue: String{
        return "\(self)"
    }
}

extension Double {
    var currencyFormatted: String {
        let isWholeNumber = isZero ? true : (!isNormal ? false : (self == rounded()))
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        let str = formatter.string(for: self) ?? ""
        return "$\(str)"
    }
}

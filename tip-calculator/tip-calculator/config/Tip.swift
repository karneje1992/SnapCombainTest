//
//  Tip.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 01.08.2023.
//

import Foundation

enum Tip {
    case none
    case tenPercent
    case fiftenPercent
    case twentyPercent
    case custom(value: Int)
    
    var strValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fiftenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return String(value)
        }
    }
}

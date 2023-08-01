//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 20.07.2023.
//

import UIKit

struct LabelFactory {
    static func buildLabel(
        text: String?,
        font: UIFont,
        bgColor: UIColor = UIColor.clear,
        textColor: UIColor = ThemeColor.text,
        textAligment: NSTextAlignment = .center) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.backgroundColor = bgColor
            label.textColor = textColor
            label.textAlignment = textAligment
            return label
        }
}

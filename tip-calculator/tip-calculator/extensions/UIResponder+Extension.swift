//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 07.08.2023.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

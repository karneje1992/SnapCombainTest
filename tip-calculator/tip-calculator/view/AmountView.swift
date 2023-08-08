//
//  AmountView.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 24.07.2023.
//

import UIKit
import SnapKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.buildLabel(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAligment: textAlignment)
    }()
    
    private lazy var amountLabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sw = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        sw.axis = .vertical
        return sw
    }()
    
    init(title: String, textAlignment: NSTextAlignment){
        
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(text: String) {
        let text = NSMutableAttributedString(
        string: text,
        attributes: [
            .font: ThemeFont.bold(ofSize: 24)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
}

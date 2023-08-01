//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import UIKit

class TipInputView: UIView {

    private let headerView: HeaderView = {
    
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        return buildTipButton(tip: .tenPercent)
    }()
    
    private lazy var fifPercentTipButton: UIButton = {
        return buildTipButton(tip: .fiftenPercent)
    }()
    
    private lazy var twenPercentTipButton: UIButton = {
        return buildTipButton(tip: .twentyPercent)
    }()
    
    private lazy var customTipButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Custom tip", for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.backgroundColor = ThemeColor.primary
        btn.addCornerRadius(radius: 8.0)
        return btn
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let sw = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifPercentTipButton,
            twenPercentTipButton
        ])
        sw.distribution = .fillEqually
        sw.spacing = 16
        sw.axis = .horizontal
        return sw
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let sw = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customTipButton
        ])
        sw.axis = .vertical
        sw.spacing = 16
        sw.distribution = .fillEqually
        return sw
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }

    private func buildTipButton(tip: Tip) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = ThemeColor.primary
        btn.tintColor = .white
        btn.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.strValue,
            attributes:[
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
        )
        text.addAttributes([
            .font: ThemeFont.demibold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        btn.setAttributedTitle(text, for: .normal)
        return btn
    }
}

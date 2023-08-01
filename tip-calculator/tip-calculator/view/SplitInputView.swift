//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import UIKit

class SplitInputView: UIView {

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decrimentButton: UIButton = {
        return buildButton(text: "-", corners: [
            .layerMinXMaxYCorner, .layerMinXMinYCorner
        ])
    }()
    
    private lazy var incrimentButton: UIButton = {
        return buildButton(text: "+", corners: [
            .layerMaxXMinYCorner, .layerMaxXMaxYCorner
        ])
    }()
    
    private lazy var quantityLabel: UILabel = {
        return LabelFactory.buildLabel(
            text: "1",
            font: ThemeFont.bold(ofSize: 20),
            bgColor: .white
        )
    }()
    
    private lazy var stackView: UIStackView = {
        let sw = UIStackView(arrangedSubviews: [
            decrimentButton,
            quantityLabel,
            incrimentButton
        ])
        sw.axis = .horizontal
        sw.spacing = 0
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
        [headerView, stackView].forEach(addSubview(_:))
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrimentButton, decrimentButton].forEach { btn in
            btn.snp.makeConstraints { make in
                make.width.equalTo(btn.snp.height)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }

    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let btn = UIButton()
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.addRaundedCorners(corners: corners, radius: 8.0)
        btn.backgroundColor = ThemeColor.primary
        return btn
    }
}

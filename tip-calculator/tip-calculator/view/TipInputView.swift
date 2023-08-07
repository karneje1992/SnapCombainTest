//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {

    private let headerView: HeaderView = {
    
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tenPercentTipButton: UIButton = {
        let btn = buildTipButton(tip: .tenPercent)
        btn.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject).store(in: &cancellables)
        return btn
    }()
    
    private lazy var fifPercentTipButton: UIButton = {
        let btn = buildTipButton(tip: .fiftenPercent)
        btn.tapPublisher.flatMap({
            Just(Tip.fiftenPercent)
        }).assign(to: \.value, on: tipSubject).store(in: &cancellables)
        return btn
    }()
    
    private lazy var twenPercentTipButton: UIButton = {
        let btn = buildTipButton(tip: .twentyPercent)
        btn.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject).store(in: &cancellables)
        return btn
    }()
    
    private lazy var customTipButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Custom tip", for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.backgroundColor = ThemeColor.primary
        btn.addCornerRadius(radius: 8.0)
        btn.tapPublisher.sink { [weak self] in
            self?.handelCustomTipButton()
        }.store(in: &cancellables)
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
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
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
    
    private func handelCustomTipButton() {
        let alertController: UIAlertController = {
            let ac = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert)
            ac.addTextField{ textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let okAction = UIAlertAction(
                title: "OK",
                style: .default) { [weak self] _ in
                    guard let text = ac.textFields?.first?.text,
                    let value = Int(text)
                    else { return }
                    self?.tipSubject.send(.custom(value: value))
                }
            [okAction, cancelAction].forEach(ac.addAction(_:))
            return ac
        }()
        
        parentViewController?.present(alertController, animated: true)
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

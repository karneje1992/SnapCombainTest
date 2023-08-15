//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decrimentButton: UIButton = {
        let btn = buildButton(text: "-", corners: [
            .layerMinXMaxYCorner, .layerMinXMinYCorner
        ])
        btn.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 :splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject).store(in: &cancellables)
        return btn
    }()
    
    private lazy var incrimentButton: UIButton = {
        let btn = buildButton(text: "+", corners: [
            .layerMaxXMinYCorner, .layerMaxXMaxYCorner
        ])
        btn.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject).store(in: &cancellables)
        return btn
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
    
    private var cancellables = Set<AnyCancellable>()
    private let splitSubject:CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
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
    
    private func observe(){
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellables)
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

extension SplitInputView: UIViewMainProtocol {
    func reset() {
        splitSubject.send(1)
    }
}

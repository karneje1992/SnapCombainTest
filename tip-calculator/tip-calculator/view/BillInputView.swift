//
//  BillInputView.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private let headerView : HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Enter", bottomText: "your bill")
        return view
    }()
    
    private lazy var textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: .init(width: 0, height: 3), color: .black, radius: 8.0, opacity: 0.1)
        return view
    }()
    
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.buildLabel(
            text: "$",
            font: ThemeFont.bold(ofSize: 24))
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        
        //add toolbar
        let toolBar = UIToolbar(frame: CGRect(
            x: 0,
            y: 0,
            width: frame.size.width,
            height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "OK",
            style: .plain,
            target: self,
            action: #selector(doneButtonAction))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    private let billSubjects: PassthroughSubject<Double, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubjects.eraseToAnyPublisher()
    }

    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        textField.textPublisher.sink { text in
            self.billSubjects.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
    
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)

        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
            make.width.equalTo(16)
        }

        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }

    @objc private func doneButtonAction(){
        textField.endEditing(true)
    }
}

extension BillInputView: UIViewMainProtocol{
    func reset() {
        textField.text = nil
        billSubjects.send(0)
    }
}

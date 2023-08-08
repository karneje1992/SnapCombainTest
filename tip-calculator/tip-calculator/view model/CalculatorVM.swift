//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 01.08.2023.
//

import Combine

class CalculatorVM {
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.splitPublisher,
            input.tipPublisher).flatMap { [unowned self] (bill, split, tip) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amoutPerPerson = totalBill / Double(split)
                let result = Result(
                    amountPerPerson: amoutPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip
                )
                return Just(result)
            }.eraseToAnyPublisher()
        
        
        
        return Output(updateViewPublisher: updateViewPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fiftenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}

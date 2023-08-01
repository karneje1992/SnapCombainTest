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
    
    func transform(input: Input) -> Output {
        
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50.0
        )
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
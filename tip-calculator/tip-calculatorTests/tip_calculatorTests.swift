//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {
    
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    private let logoViewTapSubject = PassthroughSubject<Void, Never>()
    
    override func setUp() {
        sut = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func testResultWithoutTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
        let bill: Double = 100.0
        let tip: Tip = .twentyPercent
        let split: Int = 4
        
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 30)
            XCTAssertEqual(result.totalBill, 120)
            XCTAssertEqual(result.totalTip, 20)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double = 100.0, tip: Tip = .none, split: Int = 1) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
}

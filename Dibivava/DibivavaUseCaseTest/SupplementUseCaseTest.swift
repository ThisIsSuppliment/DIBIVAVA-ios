//
//  SupplementUseCaseTest.swift
//  DibivavaUseCaseTest
//
//  Created by dong eun shin on 2023/08/22.
//

import XCTest
import RxSwift

@testable import Dibivava

final class SupplementUseCaseTest: XCTestCase {
    private var useCase: DefaultSupplementUseCase!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        self.useCase = DefaultSupplementUseCase(supplementRepository: MockSupplementRepository())
        self.disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        self.disposeBag = nil
    }

    func testExample() {
        
    }
}

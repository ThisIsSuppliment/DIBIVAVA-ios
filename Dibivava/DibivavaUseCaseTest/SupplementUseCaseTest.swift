//
//  SupplementUseCaseTest.swift
//  DibivavaUseCaseTest
//
//  Created by dong eun shin on 2023/08/22.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest

@testable import Dibivava

final class SupplementUseCaseTest: XCTestCase {
    private var useCase: DefaultSupplementUseCase!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!

    override func setUpWithError() throws {
        self.useCase = DefaultSupplementUseCase(supplementRepository: MockSupplementRepository())
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        self.useCase = nil
        self.disposeBag = nil
    }
    
    func test_fetchSupplement_when_id_is_1() {
        let observable = self.useCase.fetchSupplement(id: "1").toBlocking()

        let values = try! observable.single()
        let expectedValues = 1
        
        XCTAssertEqual(values.supplementID, expectedValues)
    }
    
    func test_fetchRecommendSupplement_when_id_is_1() {
        let observable = self.useCase.fetchRecommendSupplement(id: "1").toBlocking()

        let values = try! observable.single()
        let expectedValues = 1
        
        XCTAssertEqual(values.count, expectedValues)
    }
    
    func test_fetchMaterial_when_id_is_nil() {
        let observable = self.useCase.fetchMaterials(id: nil).toBlocking()

        let values = try? observable.single()
        let expectedValues: [Material]? = nil
        
        XCTAssertEqual(values, expectedValues)
    }
    
    func test_fetchTerm() {
//        let completable = self.useCase.fetchTerm().toBlocking()
    }
}

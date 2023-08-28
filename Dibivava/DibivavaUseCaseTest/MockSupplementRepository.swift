//
//  MockSupplementRepository.swift
//  DibivavaTests
//
//  Created by dong eun shin on 2023/08/22.
//

import Foundation
import RxSwift

@testable import Dibivava

final class MockSupplementRepository: SupplementRepository {
    func fetchSupplement(with id: String) -> RxSwift.Single<SupplementObject> {
        return Single.just(())
    }
    
    func fetchMaterial(with id: [String]?) -> RxSwift.Single<[Material]?> {
        return Single.just(())
    }
    
    func fetchTerm() -> RxSwift.Single<[Term]> {
        return Single.just(())
    }
    
    func fetchRecommendSupplement(with id: String) -> RxSwift.Single<[SupplementObject]> {
        return Single.just(())
    }
}

//
//  MockSupplementNetworkService.swift
//  DibivavaUseCaseTest
//
//  Created by dong eun shin on 2023/08/22.
//

import Foundation
import RxSwift

@testable import Dibivava

final class MockSupplementNetworkService: SupplementNetworkService {
    func fetchTermDescription() -> Single<[Term]> {
        return Single.just(())
    }
    
    func fetchSupplement(by id: String) -> Single<SupplementResponse> {
        return Single.just(())
    }
    
    func fetchMaterial(by idList: [String]?) -> Single<[MaterialResponse]?> {
        return Single.just(())
    }
    
    func fetchRecommendSupplement(by id: String) -> RxSwift.Single<[SupplementResponse]> {
        return Single.just(())
    }
}

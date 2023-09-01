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
        return Single.just(SupplementObject(supplementID: 1,
                                            name: nil,
                                            company: nil,
                                            expireDate: nil,
                                            intakeMethod: nil,
                                            functionality: nil,
                                            mainMaterial: nil,
                                            subMaterial: nil,
                                            additive: nil,
                                            imageLink: nil,
                                            gmpCheck: nil)
        )
    }
    
    func fetchMaterial(with id: [String]?) -> RxSwift.Single<[Material]?> {
        return Single.just([])
    }
    
    func fetchTerm() -> RxSwift.Single<[Term]> {
        return Single.just([Term(name: "",
                                 description: "")
        ])
    }
    
    func fetchRecommendSupplement(with id: String) -> RxSwift.Single<[SupplementObject]> {
        return Single.just([SupplementObject(supplementID: 1,
                                            name: nil,
                                            company: nil,
                                            expireDate: nil,
                                            intakeMethod: nil,
                                            functionality: nil,
                                            mainMaterial: nil,
                                            subMaterial: nil,
                                            additive: nil,
                                            imageLink: nil,
                                            gmpCheck: nil)
        ])
    }
}

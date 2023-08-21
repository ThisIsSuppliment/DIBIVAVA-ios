//
//  SupplementRepository.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation
import RxSwift

protocol SupplementRepository {
    func fetchSupplement(with id: String) -> Single<SupplementObject>
    func fetchMaterial(with id: [String]?) -> Single<[Material]?>
    func fetchTerm() -> Single<[Term]>
}

final class DefaultSupplementRepository: SupplementRepository {
    private var supplementNetworkService: SupplementNetworkService
    
    init(supplementNetworkService: SupplementNetworkService) {
        self.supplementNetworkService = supplementNetworkService
    }
    
    func fetchSupplement(with id: String) -> RxSwift.Single<SupplementObject> {
        self.supplementNetworkService.requestSupplement(by: id)
            .map { $0.toDomain() }
    }
    
    func fetchMaterial(with id: [String]?) -> RxSwift.Single<[Material]?> {
        self.supplementNetworkService.requestMaterial(by: id)
            .map { materials in
                guard let materials = materials
                else {
                    return nil
                }
                
                return materials.map { $0.toDomain() }
            }
    }
    
    func fetchTerm() -> Single<[Term]> {
        self.supplementNetworkService.fetchTermDescription()
    }
}

//
//  SupplementRepository.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation
import RxSwift

protocol SupplementRepository {
    /// 첨가제 설명 데이터  불러오기
    func fetchTerm() -> Single<[Term]>
    
    /// 건강기능 식품 데이터 불러오기
    func fetchSupplement(with id: String) -> Single<SupplementObject>
    
    /// 건강기능 식품 원재료 데이터 불러오기
    func fetchMaterial(with id: [String]?) -> Single<[Material]?>
    
    /// 검색한 건강기능 식품보다 첨가제가 적거나 같은  건강기능 식품 불러오기
    func fetchRecommendSupplement(with keyword: String) -> RxSwift.Single<[SupplementObject?]?>
}

final class DefaultSupplementRepository: SupplementRepository {
    private var supplementNetworkService: SupplementNetworkService
    
    init(supplementNetworkService: SupplementNetworkService) {
        self.supplementNetworkService = supplementNetworkService
    }
    
    func fetchSupplement(with id: String) -> RxSwift.Single<SupplementObject> {
        self.supplementNetworkService.fetchSupplement(by: id)
            .map { $0.toDomain() }
    }
    
    func fetchMaterial(with id: [String]?) -> RxSwift.Single<[Material]?> {
        self.supplementNetworkService.fetchMaterial(by: id)
            .map { materials in
                guard let materials = materials
                else {
                    return nil
                }
                
                return materials.compactMap { $0.toDomain() }
            }
    }
    
    func fetchTerm() -> RxSwift.Single<[Term]> {
        self.supplementNetworkService.fetchTermDescription()
    }
    
    func fetchRecommendSupplement(with keyword: String) -> RxSwift.Single<[SupplementObject?]?> {
        self.supplementNetworkService.fetchRecommendSupplement(by: keyword)
            .map { $0.toDomain() }
    }
}

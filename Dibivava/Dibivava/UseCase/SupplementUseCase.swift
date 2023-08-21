//
//  SupplementUseCase.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation
import RxSwift
import RxRelay

protocol SupplementUseCase {
    /// key는 첨가제 이름, value는 설명이 저장된 딕셔너리  불러오기
    func fetchTerm()
    
    /// 건강기능 식품 데이터 불러오기
    func fetchSupplement(id: String) -> Single<SupplementObject>
    
    /// 첨가제 설명이 포함된 건강기능 식품 원재료 데이터 불러오기
    func fetchMaterials(id: [String]?) -> Single<[Material]?>
    
    /// 검색한 건강기능 식품보다 첨가제가 적거나 같은  건강기능 식품 불러오기
    func fetchRecommendSupplement(id: String) -> Single<[SupplementObject]>
}

class DefaultSupplementUseCase: SupplementUseCase {
    
    // MARK: Property
    
    private var supplementRepository: SupplementRepository
    
    private let termsRelay: BehaviorRelay<[String: String]> = .init(value: [:])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(supplementRepository: SupplementRepository) {
        self.supplementRepository = supplementRepository
    }
    
    func fetchTerm() {
        self.supplementRepository.fetchTerm()
            .subscribe(onSuccess: { [weak self] terms in
                guard let self
                else {
                    return
                }
                var termsByName: [String: String] = [:]
                terms.forEach { termsByName[$0.name] = $0.description }
                self.termsRelay.accept(termsByName)
            })
            .disposed(by: self.disposeBag)
    }
    
    func fetchSupplement(id: String) -> Single<SupplementObject> {
        self.supplementRepository.fetchSupplement(with: id)
    }
    
    func fetchMaterials(id: [String]?) -> Single<[Material]?> {
        self.supplementRepository.fetchMaterial(with: id)
            .map { additives in
                guard let additives = additives
                else {
                    return additives
                }
                
                return additives.map { additive in
                    let termDescription = additive.termIds?.map { id in
                        "\(id) - " + (self.termsRelay.value[id] ?? "설명 준비중입니다") + "\n"
                    }.joined(separator: "\n")
                    
                    return additive.setTermDescription(termDescription)
                }
        }
    }
    
    func fetchRecommendSupplement(id: String) -> RxSwift.Single<[SupplementObject]> {
        self.supplementRepository.fetchRecommendSupplement(with: id)
    }
}

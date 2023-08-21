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
    func fetchTerm()
    func fetchSupplement(id: String) -> Single<SupplementObject>
    func fetchMaterials(id: [String]?) -> Single<[Material]?>
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
                        "\(id) - " + (self.termsRelay.value[id] ?? "설명 중비중") + "\n"
                    }.joined(separator: "\n")
                    
                    return additive.setTermDescription(termDescription)
                }
        }
    }
    
    func fetchRecommendSupplement(id: String) -> RxSwift.Single<[SupplementObject]> {
        self.supplementRepository.fetchRecommendSupplement(with: id)
    }
}

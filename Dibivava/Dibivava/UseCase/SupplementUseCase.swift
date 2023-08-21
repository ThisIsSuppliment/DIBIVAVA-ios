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
    func fetchAdditivesWithTermDescription(additives: [Material]?) -> [Material]?
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
    
    func fetchAdditivesWithTermDescription(additives: [Material]?) -> [Material]? {
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
    
//    func getAdditivesWithTermDescription(additives: [MaterialDTO]?) -> [Material]? {
//        additives?.map {
//            $0.toMaterial(
//                termDescription: $0.termIds.map { id in
//                    "\(id) - " + (self.termsRelay.value[id] ?? "설명 중비중") + "\n"
//                }.joined(separator: "\n")
//            )
//        }
//    }
}

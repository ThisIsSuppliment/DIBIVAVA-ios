//
//  SupplementDetailViewModel.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import Foundation
import RxSwift
import RxCocoa

protocol SupplementDetailViewModelInput {
    func viewWillAppear()
}

protocol SupplementDetailViewModelOutput {
    var supplementDetail: Driver<SupplementDetail?> { get }
    var materialDriver: Driver<[MaterialType:[Material]]?> { get }
    var numOfMainMaterial: Driver<Int> { get }
    var numOfSubMaterial: Driver<Int?> { get }
    var numOfAddMaterial: Driver<Int?> { get }
}

protocol SupplementDetailViewModel: SupplementDetailViewModelInput, SupplementDetailViewModelOutput {}

class DefaultSupplementDetailViewModel {
    private let disposeBag = DisposeBag()
    private let supplementDetailRelay = PublishRelay<SupplementDetail?>()
    private let termsRelay: BehaviorRelay<[String: String]> = .init(value: [:])
    private let materialDetailRelay = PublishRelay<[Material]?>()
    private let materialRelay: BehaviorRelay<[MaterialType:[Material]]?> = .init(value: [.main: [], .sub: [], .addictive: []])
    private let numOfMainMaterialRelay = PublishRelay<Int>()
    private let numOfSubMaterialRelay = PublishRelay<Int?>()
    private let numOfAdditiveRelay = PublishRelay<Int?>()
    
    private let supplementNetworkService: SupplementNetworkService
    
    private var id: Int
    private var material: [MaterialType:[Material]]
    
    init(id: Int,
         supplementNetworkService: SupplementNetworkService) {
        self.id = id
        self.material = [:]
        self.supplementNetworkService = supplementNetworkService
        self.fetchTerm()
    }
}

extension DefaultSupplementDetailViewModel: SupplementDetailViewModel {
    var supplementDetail: Driver<SupplementDetail?> {
        return self.supplementDetailRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var materialDriver: Driver<[MaterialType:[Material]]?> {
        return self.materialRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var numOfMainMaterial: Driver<Int> {
        return self.numOfMainMaterialRelay.asDriver(onErrorJustReturn: 0)
    }
    
    var numOfSubMaterial: Driver<Int?> {
        return self.numOfSubMaterialRelay.asDriver(onErrorJustReturn: 0)
    }
    
    var numOfAddMaterial: Driver<Int?> {
        return self.numOfAdditiveRelay.asDriver(onErrorJustReturn: 0)
    }
    
    func viewWillAppear() {
        self.fetchSupplement(with: self.id)
    }
    
    func fetchSupplement(with id: Int) {
        self.supplementNetworkService.requestSupplement(by: id)
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self
                else {
                    return
                }
                
                self.supplementDetailRelay.accept(supplement.result)
                
                self.numOfMainMaterialRelay.accept(supplement.result.mainMaterial == nil ? 0 : 1)
                self.numOfSubMaterialRelay.accept(supplement.result.subMaterial?.count)
                
                self.material[.main] = [supplement.result.mainMaterial ?? "없음"].map { $0.toMaterial(with: .main) }
                self.material[.sub] = (supplement.result.subMaterial ?? ["없음"]).map { $0.toMaterial(with: .sub) }
                self.materialRelay.accept(self.material)
                
                self.fetchAdditiveMaterial(with: supplement.result.additive)
                
            }, onFailure: {
                print("Error: Fetch supplementDetail - \($0)")
            })
            .disposed(by: self.disposeBag)
    }
    
    func fetchAdditiveMaterial(with termIDs: [String]?) {
        self.supplementNetworkService.requestMaterial(by: termIDs)
            .subscribe(onSuccess: { [weak self] additives in
                guard let self
                else {
                    return
                }

                self.numOfAdditiveRelay.accept(additives?.count)
                                
                let additivesWithTermDescription = additives?.map {
                    $0.toMaterial(
                        termDescription: $0.termIds.map {
                            "[\($0)]: " + (self.termsRelay.value[$0] ?? "설명 중비중")
                        }.joined(separator: "\n")
                    )
                }
                self.material[.addictive] = additivesWithTermDescription ?? [Material(category: "add")]
                self.materialRelay.accept(self.material)

            }, onFailure: {
                print("Error: Fetch Additives - \($0)")
            })
            .disposed(by: self.disposeBag)
    }
    
    func fetchTerm() {
        self.supplementNetworkService.fetchTermDescription()
            .subscribe(onSuccess: { [weak self] terms in
                guard let self
                else {
                    return
                }
                var tmp: [String: String] = [:]
                terms.forEach { tmp[$0.name] = $0.description }
                self.termsRelay.accept(tmp)
            })
            .disposed(by: self.disposeBag)
    }
}

enum MaterialType: String {
    case main
    case sub
    case addictive
}

extension String {
    func toMaterial(with materialType: MaterialType, termsDescription: String? = nil) -> Material {
        Material(category: materialType.rawValue,
                 name: self,
                 termsDescription: termsDescription)
    }
}

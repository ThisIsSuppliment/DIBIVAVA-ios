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
    var supplementDetail: Driver<SupplementDTO?> { get }
    var materialDriver: Driver<[MaterialType:[Material]]?> { get }
    var numOfMainMaterial: Driver<Int?> { get }
    var numOfSubMaterial: Driver<Int?> { get }
    var numOfAddMaterial: Driver<Int?> { get }
}

protocol SupplementDetailViewModel: SupplementDetailViewModelInput, SupplementDetailViewModelOutput {}

class DefaultSupplementDetailViewModel {
    private var id: Int
    private let supplementNetworkService: SupplementNetworkService
    
    private let supplementDetailRelay: PublishRelay<SupplementDTO?> = .init()
    private let termsRelay: BehaviorRelay<[String: String]> = .init(value: [:])
    private let materialRelay: BehaviorRelay<[MaterialType:[Material]]?> = .init(value: [.main: [], .sub: [], .addictive: []])
    private let numOfMainMaterialRelay: PublishRelay<Int?> = .init()
    private let numOfSubMaterialRelay: PublishRelay<Int?> = .init()
    private let numOfAdditiveRelay: PublishRelay<Int?> = .init()
    
    private var material: [MaterialType:[Material]]
    private let disposeBag = DisposeBag()
    
    init(id: Int,
         supplementNetworkService: SupplementNetworkService
    ) {
        self.id = id
        self.material = [:]
        self.supplementNetworkService = supplementNetworkService
        self.fetchTerms()
    }
}

extension DefaultSupplementDetailViewModel: SupplementDetailViewModel {
    var supplementDetail: Driver<SupplementDTO?> {
        return self.supplementDetailRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var materialDriver: Driver<[MaterialType:[Material]]?> {
        return self.materialRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var numOfMainMaterial: Driver<Int?> {
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
}

private extension DefaultSupplementDetailViewModel {
    func fetchSupplement(with id: Int) {
        self.supplementNetworkService.requestSupplement(by: id)
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self
                else {
                    return
                }
                
                self.supplementDetailRelay.accept(supplement.result)
                
                
                self.numOfSubMaterialRelay.accept(supplement.result.subMaterial?.count)
                
                let tmp = supplement.result.mainMaterial?.split(separator: ",").map {String($0)}
                
                self.numOfMainMaterialRelay.accept(tmp?.count)
        
                self.material[.main] = (tmp ?? ["없음"]).map { $0.toMaterial(with: .main) }
                
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
                            "\($0) - " + (self.termsRelay.value[$0] ?? "설명 중비중") + "\n"
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
    
    func fetchTerms() {
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

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
    var materialByType: Driver<[MaterialType:[Material]]?> { get }
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
    private let materialByTypeRelay: BehaviorRelay<[MaterialType:[Material]]?> = .init(value: [.main: [], .sub: [], .addictive: []])
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
    
    var materialByType: Driver<[MaterialType:[Material]]?> {
        return self.materialByTypeRelay.asDriver(onErrorJustReturn: nil)
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
            .subscribe(onSuccess: { [weak self] supplementResponse in
                guard let self
                else {
                    return
                }
                
                let supplement = supplementResponse.result
                let mainMaterial = supplement.mainMaterial?.split(separator: ",").map {String($0)}
                let subMaterial = supplement.subMaterial
                
                self.supplementDetailRelay.accept(supplement)
                
                self.numOfMainMaterialRelay.accept(mainMaterial?.count)
                self.numOfSubMaterialRelay.accept(subMaterial?.count)

                self.addMaterialByType(category: .main,
                                       materials: (mainMaterial ?? ["없음"]).map { $0.toMaterial(with: .main) } )
                self.addMaterialByType(category: .sub,
                                       materials: (subMaterial ?? ["없음"]).map { $0.toMaterial(with: .sub) })
                
                self.fetchAdditiveMaterial(with: supplement.additive)
                
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

                let additivesWithTermDescription = self.getAdditivesWithTermDescription(additives: additives)

                self.numOfAdditiveRelay.accept(additives?.count)
                self.addMaterialByType(category: .addictive,
                                       materials: additivesWithTermDescription)

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
                var termsByName: [String: String] = [:]
                terms.forEach { termsByName[$0.name] = $0.description }
                self.termsRelay.accept(termsByName)
            })
            .disposed(by: self.disposeBag)
    }
    
    func addMaterialByType(category: MaterialType, materials: [Material]?) {
        self.material[category] = materials ?? [Material(category: category.rawValue, name: "없음")]
        self.materialByTypeRelay.accept(self.material)
    }
    
    func getAdditivesWithTermDescription(additives: [MaterialDTO]?) -> [Material]? {
        additives?.map {
            $0.toMaterial(
                termDescription: $0.termIds.map {
                    "\($0) - " + (self.termsRelay.value[$0] ?? "설명 중비중") + "\n"
                }.joined(separator: "\n")
            )
        }
    }
}

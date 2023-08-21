//
//  DefaultSupplementDetailViewModel.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import Foundation
import RxSwift
import RxCocoa

class DefaultSupplementDetailViewModel {
    private var id: Int
    private var material: [MaterialType:[Material]]
    private let supplementUseCase: SupplementUseCase
    private let disposeBag = DisposeBag()
    
    private let supplementDetailRelay: PublishRelay<SupplementObject?> = .init()
    private let recommendSupplementRelay: BehaviorRelay<[SupplementObject]?> = .init(value: nil)
    private let materialByTypeRelay: BehaviorRelay<[MaterialType:[Material]]?> = .init(value: [.main: [], .sub: [], .addictive: []])
    private let numOfMainMaterialRelay: PublishRelay<Int?> = .init()
    private let numOfSubMaterialRelay: PublishRelay<Int?> = .init()
    private let numOfAdditiveRelay: PublishRelay<Int?> = .init()
    
    init(id: Int,
         supplementUseCase: SupplementUseCase
    ) {
        self.id = id
        self.material = [:]
        self.supplementUseCase = supplementUseCase
        self.supplementUseCase.fetchTerm()
    }
}

extension DefaultSupplementDetailViewModel: SupplementDetailViewModel {
    var recommendSupplement: Driver<[SupplementObject]?> {
        return self.recommendSupplementRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var supplementDetail: Driver<SupplementObject?> {
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
        self.fetchSupplement(with: String(self.id))
        self.fetchRecommendSupplement(with: String(self.id))
    }
}

private extension DefaultSupplementDetailViewModel {
    func fetchSupplement(with id: String) {
        self.supplementUseCase.fetchSupplement(id: id)
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self
                else {
                    return
                }
                
                let mainMaterial = supplement.mainMaterial
                let subMaterial = supplement.subMaterial
                
                self.supplementDetailRelay.accept(supplement)
                
                self.numOfMainMaterialRelay.accept(mainMaterial?.count)
                self.numOfSubMaterialRelay.accept(subMaterial?.count)

                self.addMaterialByType(category: .main,
                                       materials: (mainMaterial ?? ["없음"]).map { $0.toMaterial(with: .main) } )
                self.addMaterialByType(category: .sub,
                                       materials: (subMaterial ?? ["없음"]).map { $0.toMaterial(with: .sub) })
                
                // 첨가제 데이터 요청
                self.fetchAdditiveMaterial(with: supplement.additive)
                
            }, onFailure: {
                print("Error: Fetch supplementDetail - \($0)")
            })
            .disposed(by: self.disposeBag)
    }
    
    func fetchAdditiveMaterial(with termIDs: [String]?) {
        self.supplementUseCase.fetchMaterials(id: termIDs)
            .subscribe(onSuccess: { [weak self] additives in
                guard let self
                else {
                    return
                }
                
                self.numOfAdditiveRelay.accept(additives?.count)
                self.addMaterialByType(category: .addictive,
                                       materials: additives)

            }, onFailure: {
                print("Error: Fetch Additives - \($0)")
            })
            .disposed(by: self.disposeBag)
    }
    
    func fetchRecommendSupplement(with id: String) {
        self.supplementUseCase.fetchRecommendSupplement(id: id)
            .subscribe(onSuccess: { [weak self] supplements in
                guard let self
                else {
                    return
                }
                
                self.recommendSupplementRelay.accept(supplements)
            })
            .disposed(by: self.disposeBag)
    }
        
    func addMaterialByType(category: MaterialType, materials: [Material]?) {
        self.material[category] = materials ?? [Material(category: category.rawValue, name: "없음")]
        self.materialByTypeRelay.accept(self.material)
    }
}

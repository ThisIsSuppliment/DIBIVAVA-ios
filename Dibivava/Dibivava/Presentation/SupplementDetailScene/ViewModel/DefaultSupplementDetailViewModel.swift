//
//  DefaultSupplementDetailViewModel.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultSupplementDetailViewModel {
    // TODO: - id가 Nil일때 UI 처리하기
    private var id: Int?
    private let supplementUseCase: SupplementUseCase
    
    private let supplementDetailRelay: PublishRelay<SupplementObject?> = .init()
    private let numOfMainMaterialRelay: PublishRelay<Int?> = .init()
    private let numOfSubMaterialRelay: PublishRelay<Int?> = .init()
    private let numOfAdditiveRelay: PublishRelay<Int?> = .init()
    private let recommendSupplementRelay: BehaviorRelay<[SupplementObject]?> = .init(value: nil)
    private let materialByTypeRelay: PublishRelay<[MaterialType:[Material]]?> = .init()
    
    private let isARelay: PublishRelay<Int?> = .init()
    private let isCRelay: PublishRelay<Int?> = .init()
    
    private var material: [MaterialType:[Material]]
    private let disposeBag = DisposeBag()
    
    init(id: Int?,
         supplementUseCase: SupplementUseCase
    ) {
        self.id = id
        self.material = [:]
        self.supplementUseCase = supplementUseCase
        self.supplementUseCase.fetchTerm()
            .subscribe(onError: { error in
                print("ERROR: fetchTerm - ", error)
            })
            .disposed(by: self.disposeBag)
    }
}

extension DefaultSupplementDetailViewModel: SupplementDetailViewModel {
    var isA: RxCocoa.Driver<Int?> {
        self.isARelay.asDriver(onErrorJustReturn: nil)
    }
    
    var isC: RxCocoa.Driver<Int?> {
        self.isCRelay.asDriver(onErrorJustReturn: nil)
    }
    
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
        guard let id = self.id
        else {
            return
        }
        
        self.fetchSupplement(with: String(id))
    }
    
    func showSelectedRecommendSupplement(with indexPath: IndexPath) {
        guard let recommendSupplements: [SupplementObject] = self.recommendSupplementRelay.value,
              indexPath[1] < recommendSupplements.count
        else {
            return
        }
        let index = indexPath[1]
        let supplementID = recommendSupplements[index].supplementID
        
        print(">> showSelectedRecommendSupplement", index)
        
        // TODO: - 화면 전환
//        let vc = SupplementDetailViewController(
//            supplementDetailViewModel: DefaultSupplementDetailViewModel(
//                id: supplementID,
//                supplementUseCase: DefaultSupplementUseCase(supplementRepository: DefaultSupplementRepository(supplementNetworkService: DefaultSupplementNetworkService())))
//        )

//        self.navigationController?.pushViewController(vc, animated: false)
    }
}

private extension DefaultSupplementDetailViewModel {
    func fetchSupplement(with id: String) {
        self.supplementUseCase.fetchSupplement(id: id)
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self,
                      let supplement = supplement
                else {
                    return
                }
                
                let mainMaterial = supplement.mainMaterial
                let subMaterial = supplement.subMaterial
                
                self.supplementDetailRelay.accept(supplement)
                
                self.numOfMainMaterialRelay.accept(mainMaterial?.count)
                self.numOfSubMaterialRelay.accept(subMaterial?.count)

                self.addMaterialByType(category: .main,
                                       materials: mainMaterial?.compactMap { $0.toMaterial(with: .main) } )
                self.addMaterialByType(category: .sub,
                                       materials: subMaterial?.compactMap { $0.toMaterial(with: .sub) })
                
                // 첨가제 데이터 요청
                self.fetchAdditiveMaterial(with: supplement.additive)
                self.fetchRecommendSupplement(with: supplement.keyword)
                
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
                
                self.isARelay.accept(additives?.filter({$0.allergen == 1}).count)
                self.isCRelay.accept(additives?.filter({$0.level != nil && $0.level != ""}).count)

            }, onFailure: {
                print("Error: Fetch Additives - \($0)")
            })
            .disposed(by: self.disposeBag)
    }
    
    func fetchRecommendSupplement(with keyword: String?) {
        guard let keyword = keyword
        else {
            self.recommendSupplementRelay.accept([])
            print("unkn keyword")
            return
        }
        
        self.supplementUseCase.fetchRecommendSupplement(keyword: keyword)
            .subscribe(onSuccess: { [weak self] supplements in
                guard let self,
                      let supplements = supplements
                else {
                    self?.recommendSupplementRelay.accept([])
                    return
                }
                
                self.recommendSupplementRelay.accept(supplements.compactMap{ $0 })
            }, onFailure: { error in
                print("ERROR: fetchRecommendSupplement - ", error)
            })
            .disposed(by: self.disposeBag)
    }
        
    func addMaterialByType(category: MaterialType, materials: [Material]?) {
        self.material[category, default: []] = materials ?? [Material(category: category.rawValue, name: "없음")]
        
        if category == .addictive {
            self.materialByTypeRelay.accept(self.material)
        }
    }
}

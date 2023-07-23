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
    var materialDetailList: Driver<[MaterialDetail]?> { get }
    var component: Driver<[String:[String]]?> { get }
}

protocol SupplementDetailViewModel: SupplementDetailViewModelInput, SupplementDetailViewModelOutput {}

class DefaultSupplementDetailViewModel {
    private let disposeBag = DisposeBag()
    private let supplementDetailRelay = PublishRelay<SupplementDetail?>()
    private let materialDetailRelay = PublishRelay<[MaterialDetail]?>()
    private let componentRelay = PublishRelay<[String:[String]]?>()
    
    private let supplementNetworkService: SupplementNetworkService
    
    private var id: Int
    
    init(id: Int,
         supplementNetworkService: SupplementNetworkService) {
        self.id = id
        self.supplementNetworkService = supplementNetworkService
    }
}

extension DefaultSupplementDetailViewModel: SupplementDetailViewModel {
    var supplementDetail: Driver<SupplementDetail?> {
        return self.supplementDetailRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var materialDetailList: Driver<[MaterialDetail]?> {
        return self.materialDetailRelay.asDriver(onErrorJustReturn: [])
    }
    
    var component: Driver<[String:[String]]?> {
        return self.componentRelay.asDriver(onErrorJustReturn: [:])
    }
    
    func viewWillAppear() {
        self.supplementNetworkService.requestSupplement(by: self.id)
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self
                else {
                    return
                }
                
                self.supplementDetailRelay.accept(supplement.result)
                
                self.supplementNetworkService.requestMaterial(by: supplement.result.additive)
                    .subscribe(onSuccess: { [weak self] additives in
                        guard let self
                        else {
                            return
                        }

                        // component
                        let main = supplement.result.mainMaterial ?? "없음"
                        let subMaterial = supplement.result.subMaterial ?? ["없음"]
                        
                        let tmp = [ "main": main.split(separator: ",").map {String($0)},
                                    "sub": subMaterial,
                                    "add": additives]
                                                
                        self.componentRelay.accept(tmp)
                        
                    }, onFailure: {
                        print("Error: Fetch Additives - \($0)")
                    })
                    .disposed(by: self.disposeBag)
    
            }, onFailure: {
                print("Error: Fetch supplementDetail - \($0)")
            })
            .disposed(by: self.disposeBag)
    }
}

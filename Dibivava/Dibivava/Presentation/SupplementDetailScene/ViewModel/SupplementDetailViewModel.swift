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
    func viewWillAppear(id: Int)
}

protocol SupplementDetailViewModelOutput {
    var supplementDetail: Driver<SupplementDetail?> { get }
    var materialDetailList: Driver<[MaterialDetail]?> { get }
    var component: Driver<[String:[String]]?> { get }
}

protocol SupplementDetailViewModel: SupplementDetailViewModelInput, SupplementDetailViewModelOutput {}

class DefaultSupplementDetailViewModel: SupplementDetailViewModel {
    private let disposeBag = DisposeBag()
    private let supplementDetailRelay = PublishRelay<SupplementDetail?>()
    private let materialDetailRelay = PublishRelay<[MaterialDetail]?>()
    private let componentRelay = PublishRelay<[String:[String]]?>()
    
    private let supplementNetworkService: SupplementNetworkService
    
    init() {
        self.supplementNetworkService = DefaultSupplementNetworkService()
    }
    
    var supplementDetail: Driver<SupplementDetail?> {
        return self.supplementDetailRelay.asDriver(onErrorJustReturn: nil)
    }
    
    var materialDetailList: Driver<[MaterialDetail]?> {
        return self.materialDetailRelay.asDriver(onErrorJustReturn: [])
    }
    
    var component: Driver<[String:[String]]?> {
        return self.componentRelay.asDriver(onErrorJustReturn: [:])
    }
    
    func viewWillAppear(id: Int) {
        self.supplementNetworkService.requestSupplement(by: 12) // id Test
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self
                else {
                    return
                }
            
                self.supplementNetworkService.requestMaterial(by: supplement.result.additive)
                    .subscribe(onSuccess: { [weak self] additives in
                        guard let self
                        else {
                            return
                        }

                        // component
                        let tmp = [ "main": supplement.result.mainMaterial.split(separator: ",").map { String($0) },
                                    "sub": supplement.result.subMaterial,
                                    "add": additives]
                        
                        
                        self.componentRelay.accept(tmp)
                        
                        self.supplementDetailRelay.accept(supplement.result)
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
//self.supplementNetworkService.requestMaterial(by: supplement.result.additive)
//    .subscribe(onSuccess: { [weak self] additives in
//        guard let self
//        else {
//            return
//        }
//        print("22", additives)
//        self.materialDetailRelay.accept(additives)
//    }, onFailure: {
//        print("Error: Fetch Additives - \($0)")
//    })
//    .disposed(by: self.disposeBag)


//func viewWillAppear(id: Int) {
//    self.supplementNetworkService.requestSupplement(by: 10)
//        .subscribe(onCompleted: { [weak self] supplement in
//            guard let self
//            else {
//                return
//            }
//            self.supplementDetailRelay.accept(supplement.result)
//        }, onFailure: {
//            print("Error: Fetch supplementDetail - \($0)")
//        })
//        .disposed(by: self.disposeBag)
//}

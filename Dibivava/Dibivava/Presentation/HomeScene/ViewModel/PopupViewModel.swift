//
//  PopupViewModel.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class PopupViewModel {
    private let supplementNetworkService: SupplementNetworkService
    private let componentRelay = PublishRelay<[String:[String]]?>()
    private let disposeBag = DisposeBag()
    private let supplementDetailRelay = PublishRelay<SupplementDetail?>()

    init() {
        self.supplementNetworkService = DefaultSupplementNetworkService()
    }
    func viewWillAppear(id: Int) {
        self.supplementNetworkService.requestSupplement(by: 5107)
            .subscribe(onSuccess: { [weak self] supplement in
                guard let self,
                      let additive = supplement.result.additive
                else {
                    return
                }
            
                self.supplementNetworkService.requestMaterial(by: additive)
                    .subscribe(onSuccess: { [weak self] additives in
                        guard let self,
                              let subMaterial = supplement.result.subMaterial,
                              let main = supplement.result.mainMaterial
                        else {
                            return
                        }

                        // component
                        let tmp = [ "main": main.split(separator: ",").map { String($0)},
                                    "sub": subMaterial,
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

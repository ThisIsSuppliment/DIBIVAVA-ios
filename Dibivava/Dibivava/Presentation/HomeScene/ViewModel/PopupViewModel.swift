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

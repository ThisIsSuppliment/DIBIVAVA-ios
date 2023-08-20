//
//  SupplementDetailViewModel.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/10.
//

import Foundation
import RxCocoa

protocol SupplementDetailViewModelInput {
    func viewWillAppear()
}

protocol SupplementDetailViewModelOutput {
    /// 건강기능식품의 세부 정보
    var supplementDetail: Driver<SupplementObject?> { get }
    
    /// 건강기능식품의 타입별 재료
    var materialByType: Driver<[MaterialType:[Material]]?> { get }
    
    /// 건강기능식품의 주원료 갯수
    var numOfMainMaterial: Driver<Int?> { get }
    
    /// 건강기능식품의 부원료 갯수
    var numOfSubMaterial: Driver<Int?> { get }
    
    /// 건강기능식품의 첨가제 갯수
    var numOfAddMaterial: Driver<Int?> { get }
}

protocol SupplementDetailViewModel: SupplementDetailViewModelInput, SupplementDetailViewModelOutput {}

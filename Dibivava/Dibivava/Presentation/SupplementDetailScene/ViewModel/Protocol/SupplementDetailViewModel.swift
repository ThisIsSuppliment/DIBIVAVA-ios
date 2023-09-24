//
//  SupplementDetailViewModel.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/10.
//

import Foundation
import RxCocoa

protocol SupplementDetailViewModelInput {
    /// 검색한 건강기능식품에 관한 데이터 요청
    func viewWillAppear()
    
    /// 선택한 추천 건강기능 식품으로 화면 전환
    func showSelectedRecommendSupplement(with indexPath: IndexPath)
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
    
    /// 추천 건강기능 식품
    var recommendSupplement: Driver<[SupplementObject]?> { get }
    
    var isA: Driver<Int?> { get }
    var isC: Driver<Int?> { get }
}

protocol SupplementDetailViewModel: SupplementDetailViewModelInput, SupplementDetailViewModelOutput {}

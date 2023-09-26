//
//  IarcGroup.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/22.
//

import Foundation

enum IarcGroup: String {
    case group1 = "1"
    case group2A = "2A"
    case group2B = "2B"
    case group3 = "3"
    
    var description: String {
        switch self {
        case .group1:
        return "1군의 경우는 정적발암물질로써, 사람 및 동물을 대상으로 한 연구에서 암을 일으킨다는 충분한 증거가 있는 경우입니다. 담배, 술 등이 대표적인 예입니다."
        case .group2A:
            return "2A군의 경우는 발암 추정(Probable)물질로써, 사람 대상의 연구에서 제한적인 증거가 나온경우와 동물 실험에서 충분한 증거가 있을 때 분류되는 등급입니다. "
        case .group2B:
            return "2B군의 경우는 발암 가능(Possible)물질로써, 사람 대상 연구 와 동물 실험에서 제한적인 증거가 있는 경우 분류되는 등급입니다."
        case .group3:
            return "3군은 발암물질로 분류할 수 없어 인체에 암을 유발한다는 과학적 증거가 불충분한 경우입니다."
        }
    }
}

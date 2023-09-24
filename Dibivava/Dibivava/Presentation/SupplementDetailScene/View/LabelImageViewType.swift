//
//  LabelImageViewType.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/24.
//

import Foundation

enum LabelImageViewType {
    case gmp
    case allergy(isSelected: Bool)
    case carcinogens(isSelected: Bool)
    
    var text: String {
        switch self{
        case .gmp:
            return "GMP 인증"
        case .allergy:
            return "알레르기 유발 물질"
        case .carcinogens:
            return "발암 유발(가능) 물질"
        }
    }
    
    var imageName: String {
        switch self{
        case .gmp:
            return "GMP"
        case .allergy(let isSelected):
            return isSelected ? "Allergy1" : "Allergy0"
        case .carcinogens(let isSelected):
            return isSelected ? "Carcinogens1" : "Carcinogens0"
        }
    }
}

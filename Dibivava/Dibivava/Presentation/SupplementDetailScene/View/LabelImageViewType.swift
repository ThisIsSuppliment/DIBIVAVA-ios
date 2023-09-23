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
    
    var imageName: String {
        switch self{
        case .gmp:
            return "GMP"
        case .allergy(let isSelected):
            return isSelected ? "GMP" : "GMP"
        case .carcinogens(let isSelected):
            return isSelected ? "GMP" : "GMP"
        }
    }
}

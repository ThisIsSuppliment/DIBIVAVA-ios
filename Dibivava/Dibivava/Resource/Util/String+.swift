//
//  String+.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/27.
//

import Foundation

extension String {
    func toMaterial(with materialType: MaterialType, termsDescription: String? = nil) -> Material {
        Material(category: materialType.rawValue,
                 name: self,
                 termsDescription: termsDescription)
    }
}

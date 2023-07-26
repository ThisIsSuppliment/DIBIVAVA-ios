//
//  Material.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/27.
//

import Foundation

struct Material: Hashable {
    let id: Int?
    let category: String
    let name: String?
    let terms: [String]?
    let level: String?
    var numberOfLines: Int
    var termsDescription: String?
    
    init(id: Int? = nil,
         category: String,
         name: String? = nil,
         terms: [String]? = nil,
         level: String? = nil,
         termsDescription: String? = nil
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.terms = terms
        self.level = level
        self.numberOfLines = 1
        self.termsDescription = termsDescription
    }
}

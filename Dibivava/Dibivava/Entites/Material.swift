//
//  Material.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/27.
//

import Foundation

struct Material: Hashable {
    let id: String?
    let category: String
    let name: String?
    let termIds: [String]?
    let level: String?
    var numberOfLines: Int
    var termsDescription: String?
    
    init(id: String? = UUID().uuidString,
         category: String,
         name: String? = nil,
         termIds: [String]? = nil,
         level: String? = nil,
         termsDescription: String? = nil
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.termIds = termIds
        self.level = level
        self.numberOfLines = 1
        self.termsDescription = termsDescription
    }
}

extension Material {
    func setTermDescription(_ termDescription: String?) -> Material {
        Material(id: self.id,
                 category: self.category,
                 name: self.name,
                 termIds: self.termIds,
                 level: self.level,
                 termsDescription: termDescription)
    }
}

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
    var termsWithDescription: String?
    let allergen: Int?
    let allergen_description: String?
    
    init(id: String? = UUID().uuidString,
         category: String,
         name: String? = nil,
         termIds: [String]? = nil,
         level: String? = nil,
         termsWithDescription: String? = nil,
         allergen: Int? = nil,
         allergen_description: String? = nil
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.termIds = termIds
        self.level = level
        self.numberOfLines = 1
        self.termsWithDescription = termsWithDescription
        self.allergen = allergen
        self.allergen_description = allergen_description
    }
}

extension Material {
    func setTermsWithDescription(_ termDescription: String?) -> Material {
        guard let termIds = termIds,
              let termDescription = termDescription
        else {
            return self
        }
        
        let terms = termIds.joined(separator: "  ")
        
        return Material(id: self.id,
                 category: self.category,
                 name: self.name,
                 termIds: self.termIds,
                 level: self.level,
                        termsWithDescription: terms + "\n--\n" + termDescription,
                        allergen: self.allergen,
                        allergen_description: self.allergen_description)
    }
}

//
//  MaterialResponse.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/23.
//

import Foundation

struct MaterialResponse: Codable {
    let message: String
    let result: MaterialDTO
}

struct MaterialDTO: Codable {
    let materialId: Int
    let category: String
    let name: String
    let termIds: [String]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case materialId = "material_id"
        case category, name
        case termIds = "term_ids"
        case createdAt, updatedAt
    }
}


extension MaterialDTO {
    func toMaterial() -> Material {
        Material(id: self.materialId,
                 category: self.category,
                 name: self.name,
                 terms: self.termIds)
    }
}

struct Material: Hashable {
    let id: Int?
    let category: String
    let name: String?
    let terms: [String]?
    
    init(id: Int? = nil,
         category: String,
         name: String? = nil,
         terms: [String]? = nil
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.terms = terms
    }
}

//
//  MaterialResponse.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/23.
//

import Foundation

struct MaterialResponse: Decodable {
    let message: String
    let result: MaterialDTO?
}

struct MaterialDTO: Decodable {
    let materialId: Int?
    let category: String?
    let name: String?
    let termIds: [String]?
    let createdAt: String?
    let updatedAt: String?
    let level: String?
    let keyword: String?
    let allergen: Int?
    let allergen_description: String?
    
    enum CodingKeys: String, CodingKey {
        case materialId = "material_id"
        case category, name
        case termIds = "term_ids"
        case createdAt, updatedAt, keyword
        case level = "who_iarc_level"
        case allergen, allergen_description
    }
}

extension MaterialResponse {
    func toDomain() -> Material? {
        guard let result = result,
              let id = result.materialId,
              let category = result.category
        else {
            return nil
        }
        
        return Material(id: String(id),
                        category: category,
                        name: result.name,
                        termIds: result.termIds,
                        level: result.level,
                        termsWithDescription: nil,
                        allergen: result.allergen,
                        allergen_description: result.allergen_description)
    }
}

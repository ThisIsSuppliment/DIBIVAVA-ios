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
    let level: String?
    
    enum CodingKeys: String, CodingKey {
        case materialId = "material_id"
        case category, name
        case termIds = "term_ids"
        case createdAt, updatedAt
        case level = "who_iarc_level"
    }
}

extension MaterialResponse {
    func toDomain() -> Material {
        Material(id: String(result.materialId),
                 category: result.category,
                 name: result.name,
                 termIds: result.termIds,
                 level: result.level,
                 termsDescription: nil)
    }
}

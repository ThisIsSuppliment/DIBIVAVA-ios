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
    
    enum CodingKeys: String, CodingKey {
        case materialId = "material_id"
        case category, name
        case termIds = "term_ids"
        case createdAt, updatedAt, keyword
        case level = "who_iarc_level"
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
                 termsWithDescription: nil)
    }
}
// 고려은단 멀티비타민 이뮨샷
// 루테인 지아잔틴 아스타잔틴
// 보령

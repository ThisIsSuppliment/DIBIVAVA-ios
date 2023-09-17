//
//  RecommendSupplementResponse.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/09/05.
//

import Foundation

struct RecommendSupplementResponse: Decodable {
    let message: String
    let result: [RecommendSupplementDTO]?
}

// MARK: - SupplementDetail
struct RecommendSupplementDTO: Decodable {
    let supplementID: Int?
    let name, company, expireDate, intakeMethod: String?
    let functionality, mainMaterial, subMaterial, additive: String?
    let imageLink: String?
    let gmpCheck: Int?
    let keyword: String?
    let mainMaterialFromOpenAPI: String?
    let createdAt, updatedAt: String?
    let category: String?

    enum CodingKeys: String, CodingKey {
        case supplementID = "supplement_id"
        case name, company
        case expireDate = "expire_date"
        case intakeMethod = "intake_method"
        case functionality
        case mainMaterial = "main_material"
        case subMaterial = "sub_material"
        case additive
        case imageLink = "image_link"
        case gmpCheck = "gmp_check"
        case keyword
        case mainMaterialFromOpenAPI = "main_material_from_open_api"
        case createdAt, updatedAt, category
    }
}

extension RecommendSupplementResponse {
    func toDomain() -> [SupplementObject?]? {
        guard let result = result
        else {
            return nil
        }
        
        return result.map { supplement in
            guard let id = supplement.supplementID
            else {
                return nil
            }
            return SupplementObject(
                supplementID: String(id),
                name: supplement.name,
                company: supplement.company,
                expireDate: supplement.expireDate,
                intakeMethod: supplement.intakeMethod,
                functionality: nil,
                mainMaterial: nil,
                subMaterial: nil,
                additive: nil,
                imageLink: supplement.imageLink,
                gmpCheck: supplement.gmpCheck,
                keyword: supplement.keyword,
                category: supplement.category
            )
        }
    }
}

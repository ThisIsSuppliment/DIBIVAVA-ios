//
//  SupplementResponse.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/18.
//

import Foundation

struct SupplementResponse: Decodable {
    let message: String
    let result: SupplementDTO
}

// MARK: - SupplementDetail
struct SupplementDTO: Decodable {
    let supplementID: Int
    let name, company, expireDate, intakeMethod: String?
    let functionality: [String]?
    let mainMaterial: [String]?
    let subMaterial, additive: [String]?
    let imageLink: String?
    let gmpCheck: Int?
    let keyword: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case supplementID = "supplement_id"
        case name, company
        case expireDate = "expire_date"
        case intakeMethod = "intake_method"
        case functionality
        case mainMaterial = "main_material"
        case subMaterial = "sub_material"
        case additive, createdAt, updatedAt
        case imageLink = "image_link"
        case gmpCheck = "gmp_check"
        case keyword
    }
}

extension SupplementResponse {
    func toDomain() -> SupplementObject {
        SupplementObject(supplementID: String(result.supplementID),
                         name: result.name,
                         company: result.company,
                         expireDate: result.expireDate,
                         intakeMethod: result.intakeMethod,
                         functionality: result.functionality,
                         mainMaterial: result.mainMaterial,
                         subMaterial: result.subMaterial,
                         additive: result.additive,
                         imageLink: result.imageLink,
                         gmpCheck: result.gmpCheck,
                         keyword: result.keyword)
    }
}

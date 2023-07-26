//
//  SupplementResponse.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/18.
//

import Foundation

struct SupplementResponse: Codable {
    let message: String
    let result: SupplementDTO
}

// MARK: - SupplementDetail
struct SupplementDTO: Codable {
    let supplementID: Int
    let name, company, expireDate, intakeMethod: String?
    let functionality: [String]?
    let mainMaterial: String?
    let subMaterial, additive: [String]?
    let imageURL: String?
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
        case imageURL = "image_link"
    }
}
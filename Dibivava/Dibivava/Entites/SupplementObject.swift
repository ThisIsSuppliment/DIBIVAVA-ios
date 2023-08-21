//
//  SupplementObject.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation

struct SupplementObject: Hashable {
    let supplementID: Int
    let name, company, expireDate, intakeMethod: String?
    let functionality: [String]?
    let mainMaterial: [String]?
    let subMaterial, additive: [String]?
    let imageLink: String?
    let gmpCheck: Int?
}

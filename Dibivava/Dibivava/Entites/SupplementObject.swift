//
//  SupplementObject.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation

struct SupplementObject: Hashable {
    let supplementID: String?
    let name, company, expireDate, intakeMethod: String?
    let functionality: [String]?
    let mainMaterial: [String]?
    let subMaterial, additive: [String]?
    let imageLink: String?
    let gmpCheck: Int?
    let keyword: String?
    let category: String?
    
    init(supplementID: String? = UUID().uuidString,
         name: String?,
         company: String?,
         expireDate: String?,
         intakeMethod: String?,
         functionality: [String]?,
         mainMaterial: [String]?,
         subMaterial: [String]?,
         additive: [String]?,
         imageLink: String?,
         gmpCheck: Int?,
         keyword: String?,
         category: String?
    ) {
        self.supplementID = supplementID
        self.name = name
        self.company = company
        self.expireDate = expireDate
        self.intakeMethod = intakeMethod
        self.functionality = functionality
        self.mainMaterial = mainMaterial
        self.subMaterial = subMaterial
        self.additive = additive
        self.imageLink = imageLink
        self.gmpCheck = gmpCheck
        self.keyword = keyword
        self.category = category
    }
}

//
//  Additive.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/21.
//

import Foundation

struct Additive: Codable {
    let term, description: String

    enum CodingKeys: String, CodingKey {
        case term = "Term"
        case description = "Description"
    }
}

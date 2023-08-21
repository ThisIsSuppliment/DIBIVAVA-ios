//
//  URL+.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/22.
//

import Foundation

extension URL {
    func appendQueryItems(_ queries: [URLQueryItem]?) -> URL? {
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = queries
        return components?.url
    }
}

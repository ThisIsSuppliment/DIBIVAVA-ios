//
//  Endpoint.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queries: [URLQueryItem]? { get }
}

extension Endpoint {
    func getURL() -> URL? {
        let url = URL(string: baseURL + path)?
        return url.appendQueryItems(queries)
    }
}

enum EndpointCases: Endpoint {
    case supplement(id: String)
    case material(id: String)
    
    var baseURL: String {
        return "https://nb548yprx4.execute-api.ap-northeast-2.amazonaws.com/production/"
    }
    
    var path: String {
        switch self {
        case .supplement:
            return "getSupplementById?"
        case .material:
            return "getMaterialById?"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .supplement(id: let id):
            return [URLQueryItem(name: "id", value: id)]
        case .material(id: let id):
            return [URLQueryItem(name: "id", value: id)]
        }
    }
}

extension URL {
    func appendQueryItems(_ queries: [URLQueryItem]?) -> URL? {
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = queries
        return components?.url
    }
}

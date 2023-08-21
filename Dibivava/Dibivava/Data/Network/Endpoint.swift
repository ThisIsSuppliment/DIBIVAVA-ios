//
//  Endpoint.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/08/21.
//

import Foundation

protocol Endpoint {
    var url: URL? { get}
    var queries: [URLQueryItem]? { get }
}

extension Endpoint {
    func getURL() -> URL? {
        return url?.appendQueryItems(queries)
    }
}

enum EndpointCases: Endpoint {
    case supplement(id: String)
    case material(id: String)
    case term
    
    var url: URL? {
        switch self {
        case .supplement, .material:
            guard let baseURL = baseURL,
                  let path = path
            else {
                return nil
            }
            return URL(string: baseURL + path)
        case .term:
            return Bundle.main.url(forResource: "TermsDescription",
                                   withExtension: "json")
        }
    }
    
    var baseURL: String? {
        switch self {
        case .supplement, .material:
            return "https://nb548yprx4.execute-api.ap-northeast-2.amazonaws.com/production/"
        case .term:
            return nil
        }
    }
    
    var path: String? {
        switch self {
        case .supplement:
            return "getSupplementById?"
        case .material:
            return "getMaterialById?"
        case .term:
            return nil
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .supplement(id: let id):
            return [URLQueryItem(name: "id", value: id)]
        case .material(id: let id):
            return [URLQueryItem(name: "id", value: id)]
        case .term:
            return nil
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

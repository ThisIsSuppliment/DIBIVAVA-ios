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
    case recommendation(keyword: String, req: Int)
    
    var url: URL? {
        switch self {
        case .supplement, .material, .recommendation:
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
        case .supplement, .material, .recommendation:
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
        case .recommendation:
            return "getRecommendList"
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
        case .recommendation(keyword: let keyword, req: let req):
            return [URLQueryItem(name: "keyword", value: keyword),
                    URLQueryItem(name: "req", value: String(req))]
        }
    }
}

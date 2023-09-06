//
//  RecommandAPI.swift
//  Dibivava
//
//  Created by 최지철 on 2023/09/05.
//

import Foundation
import Alamofire

struct getSupplement: Codable {
    let supplementId: Int
    let name: String
    let company: String
    let expireDate: String
    let intakeMethod: String
    let functionality: String
    let mainMaterial: String
    let subMaterial: String
    let additive: String
    let imageLink: String
    let gmpCheck: Int
    let keyword: String
    let mainMaterialFromOpenApi: String?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case supplementId = "supplement_id"
        case name
        case company
        case expireDate = "expire_date"
        case intakeMethod = "intake_method"
        case functionality
        case mainMaterial = "main_material"
        case subMaterial = "sub_material"
        case additive
        case imageLink = "image_link"
        case gmpCheck = "gmp_check"
        case keyword
        case mainMaterialFromOpenApi
        case createdAt
        case updatedAt
    }
}

struct APIResponse: Codable {
    let message: String
    let result: [getSupplement]
}

class getRecommendList {
    func getRecommendList(keyword: String, req: Int, completion: @escaping (Result<[getSupplement], Error>) -> Void) {
        // URLComponents를 사용하여 URL 생성
        var urlComponents = URLComponents(string: "https://nb548yprx4.execute-api.ap-northeast-2.amazonaws.com/production/getRecommendList")!
        urlComponents.queryItems = [
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "req", value: String(req))
        ]

        // 생성된 URL 사용
        if let url = urlComponents.url {
            AF.request(url, method: .get, parameters: nil).responseDecodable(of: APIResponse.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response.result))
                case .failure(let error):
                    print("실패")
                    print(error)
                }
            }
        }
    }
}

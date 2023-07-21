//
//  SearchAPI.swift
//  Dibivava
//
//  Created by 최지철 on 2023/07/20.
//

import Foundation
import Alamofire

struct Supplement: Codable {
    let supplementId: Int
    let name: String
    let company: String

    enum CodingKeys: String, CodingKey {
        case supplementId = "supplement_id"
        case name
        case company
    }
}

struct SearchAPIResponse: Codable {
    let message: String
    let result: [Supplement]
}
class SearchAPI{
    func getSearchResult(name:String,completion: @escaping (Result<[Supplement], Error>) -> Void){
        let url = APIConstants.baseURL + "search"
        let parameters: Parameters = [
            "name": name,
        ]
        AF.request(url, parameters: parameters).responseDecodable(of: SearchAPIResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      completion(.success(response.result))
                  case .failure(let error):
                      completion(.failure(error))
                      print(error)
                  }
        }    }
}

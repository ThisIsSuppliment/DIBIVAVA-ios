//
//  postSearchLogAPI.swift
//  Dibivava
//
//  Created by 최지철 on 2023/09/21.
//

import Foundation
import Alamofire

struct logResponse: Codable {
    let message: String
    let result: String

}

class postSearchLogAPI {
    func getSearchResult(log:Int,check:String,id:Int,completion: @escaping (Result<logResponse, Error>) -> Void){
        let url = "https://nb548yprx4.execute-api.ap-northeast-2.amazonaws.com/production/postSearchLog"
        let parameters: Parameters = [
            "search_log": log,
            "db_check": check,
            "supplement_id":"345"
        ]
        AF.request(url,method: .post, parameters: parameters,encoding: JSONEncoding.default).responseDecodable(of: logResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      print(response)
                  case .failure(let error):
                      completion(.failure(error))
                      print("로그에러",error)
                  }
        }
    }
}


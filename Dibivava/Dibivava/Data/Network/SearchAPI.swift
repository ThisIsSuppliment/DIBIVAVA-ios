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
    let imagelink: String?
    enum CodingKeys: String, CodingKey {
        case supplementId = "supplement_id"
        case name
        case company
        case imagelink = "image_link"
    }
}
struct SearchAPIResponse: Codable {
    let message: String
    let result: [Supplement]
}
class SearchAPI{
    func getSearchResult(name:String,limit:Int,completion: @escaping (Result<[Supplement], Error>) -> Void){
        let qureyName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://nb548yprx4.execute-api.ap-northeast-2.amazonaws.com/production/search?name=\(qureyName)&limit=\(limit)"
        AF.request(url,method: .get, parameters: nil,headers: nil).responseDecodable(of: SearchAPIResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      completion(.success(response.result))
                      print(response)
                  case .failure(let error):
                      completion(.failure(error))
                      print(error)
                  }
        }
    }
    
    func getSupplementID(id:Int,completion: @escaping (Result<SupplementResponse, Error>) -> Void){
        let url = APIConstants.baseURL + "getSupplementById"
        let parameters: Parameters = [
            "id": id,
        ]
        AF.request(url, parameters: parameters).responseDecodable(of: SupplementResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      completion(.success(response))
                  case .failure(let error):
                      completion(.failure(error))
                      print("/getSupplementById" , error)
                  }
        }
    }
    func getSupplementName(name:String,completion: @escaping (Result<SupplementResponse, Error>) -> Void){
        let url = APIConstants.baseURL + "getSupplementByName"
        let parameters: Parameters = [
            "name": name,
        ]
        AF.request(url, parameters: parameters).responseDecodable(of: SupplementResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      completion(.success(response))
                  case .failure(let error):
                      completion(.failure(error))
                      print("/getSupplementByName" , error)
                  }
        }
    }
}

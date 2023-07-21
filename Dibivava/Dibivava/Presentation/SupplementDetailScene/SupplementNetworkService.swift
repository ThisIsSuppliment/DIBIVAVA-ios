//
//  SupplementNetworkService.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/21.
//

import Foundation
import Alamofire
import RxSwift

protocol SupplementNetworkService {
    func requestSupplement(by id: Int) -> Single<SupplementDTO>
    func requestMaterial(by id: [String]) -> Single<[String]>
}

final class DefaultSupplementNetworkService: SupplementNetworkService {
    func requestSupplement(by id: Int) -> Single<SupplementDTO> {
        Single<SupplementDTO>.create { single in
            let urlString = "https://eurq0k5xej.execute-api.ap-northeast-2.amazonaws.com/dev/getSupplementById?id=\(id)"
            let urlComponent = URLComponents(string: urlString)
            guard let url = urlComponent?.url else { return Disposables.create() }

            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(SupplementDTO.self, from: data)
                        single(.success(decodedData))
                    }catch{
                        single(.failure(NetworkError.invalidStatusCode))
                        return
                    }
                case .failure(let error):
                    single(.failure(NetworkError.invalidResponse))
                    print("ERROR: \(error)")
                    return
                }
            }
            return Disposables.create()
        }
    }
    
    func requestMaterial(by idList: [String]) -> Single<[String]> {
        let result = idList.map { id in
            return request(with: id)
        }
        return Single.zip(result)
            .map { $0 }
    }
    
    func request(with id: String) -> Single<String> {
        return Single<String>.create { single in
            let urlString = "https://eurq0k5xej.execute-api.ap-northeast-2.amazonaws.com/dev/getMaterialById?id=\(id)"
            let urlComponent = URLComponents(string: urlString)
            guard let url = urlComponent?.url else { return Disposables.create() }

            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(MaterialDTO.self, from: data)
                        single(.success(decodedData.result.name))
                    }catch{
                        single(.failure(NetworkError.invalidStatusCode))
                        return
                    }
                case .failure(let error):
                    single(.failure(NetworkError.invalidResponse))
                    print("ERROR: \(error)")
                    return
                }
            }
            return Disposables.create()
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidStatusCode
    case failedDecode
}

struct MaterialDTO: Codable {
    let message: String
    let result: MaterialDetail
}

struct MaterialDetail: Codable {
    let material_id: Int
    let category: String
    let name: String
    let term_ids: [String]
    let createdAt: String
    let updatedAt: String
}


//Single<[MaterialDetail]>.create { single in
//    var decodedMaterialList: [MaterialDetail] = []
//    for id in idList {
//        let urlString = "https://eurq0k5xej.execute-api.ap-northeast-2.amazonaws.com/dev/dev/getMaterialById?id=\(id)"
//        let urlComponent = URLComponents(string: urlString)
//        guard let url = urlComponent?.url else { return Disposables.create() }
//
//        AF.request(url).responseData { response in
//            print("11", response.result)
//            switch response.result {
//            case .success(let data):
//                do{
//                    let decoder = JSONDecoder()
//                    let decodedData = try decoder.decode(MaterialDTO.self, from: data)
//                    print("<><>", decodedData.result.term_ids)
////                            single(.success(decodedData))
//                    decodedMaterialList.append(decodedData.result)
//                }catch{
//                    single(.failure(NetworkError.invalidStatusCode))
//                    return
//                }
//            case .failure(let error):
//                single(.failure(NetworkError.invalidResponse))
//                print("ERROR: \(error)")
//                return
//            }
//        }
//    }
//    print("@@", decodedMaterialList)
//    single(.success(decodedMaterialList))
//
//    return Disposables.create()
//}

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
    func requestMaterial(by id: [String]?) -> Single<[MaterialDTO]?>
}

final class DefaultSupplementNetworkService: SupplementNetworkService {
    func requestSupplement(by id: Int) -> Single<SupplementDTO> {
        Single<SupplementDTO>.create { single in
            let urlString = "https://mp1878zrkj.execute-api.ap-northeast-2.amazonaws.com/dev/getSupplementById?id=\(id)"
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
    
    func requestMaterial(by idList: [String]?) -> Single<[MaterialDTO]?> {
        guard let idList = idList
        else {
            return Single.just(nil)
        }
        
        let result = idList.map { id in
            return request(with: id)
        }
        return Single.zip(result)
            .map { $0 }
    }
    
    func request(with id: String) -> Single<MaterialDTO> {
        return Single<MaterialDTO>.create { single in
            let urlString = "https://mp1878zrkj.execute-api.ap-northeast-2.amazonaws.com/dev/getMaterialById?id=\(id)"
            let urlComponent = URLComponents(string: urlString)
            guard let url = urlComponent?.url else { return Disposables.create() }

            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(MaterialResponse.self, from: data)
                        print("######첨가제 등급", decodedData.result.level)
                        single(.success(decodedData.result))
                    }catch{
                        single(.failure(NetworkError.failedDecode))
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

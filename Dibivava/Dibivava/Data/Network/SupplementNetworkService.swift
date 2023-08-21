//
//  SupplementNetworkService.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/21.
//

import Foundation
import Alamofire
import RxSwift

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case failedDecode
}

protocol SupplementNetworkService {
    func requestSupplement(by id: Int) -> Single<SupplementResponse>
    func requestMaterial(by id: [String]?) -> Single<[MaterialResponse]?>
    func fetchTermDescription() -> Single<[TermDTO]>
}

final class DefaultSupplementNetworkService: SupplementNetworkService {
    func fetchTermDescription() -> Single<[TermDTO]> {
        self.request(with: EndpointCases.term, T: [TermDTO].self)
    }
    
    func requestSupplement(by id: Int) -> Single<SupplementResponse> {
        self.request(with: EndpointCases.supplement(id: id), T: SupplementResponse.self)
    }
    
    func requestMaterial(by idList: [String]?) -> Single<[MaterialResponse]?> {
        guard let idList = idList
        else {
            return Single.just(nil)
        }
        
        let result = idList.map { id in
            return self.request(with: EndpointCases.material(id: id), T: MaterialResponse.self)
        }
        
        return Single.zip(result).map { $0 }
    }
}

private extension DefaultSupplementNetworkService {
    func request<T: Decodable>(with endpoint: Endpoint, T: T.Type) -> Single<T>  {
        Single<T>.create { single in
            guard let requestURL = endpoint.getURL()
            else {
                single(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }

            AF.request(requestURL).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(T.self, from: data)
                        single(.success(decodedData))
                    }catch{
                        single(.failure(NetworkError.failedDecode))
                        return
                    }
                case .failure(_):
                    single(.failure(NetworkError.invalidResponse))
                    return
                }
            }
            return Disposables.create()
        }
    }
}

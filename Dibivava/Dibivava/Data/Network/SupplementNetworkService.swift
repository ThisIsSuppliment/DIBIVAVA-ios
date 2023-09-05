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
    func fetchSupplement(by id: String) -> Single<SupplementResponse>
    func fetchMaterial(by id: [String]?) -> Single<[MaterialResponse]?>
    func fetchTermDescription() -> Single<[Term]>
    func fetchRecommendSupplement(by keyword: String) -> Single<RecommendSupplementResponse>
}

final class DefaultSupplementNetworkService: SupplementNetworkService {
    func fetchTermDescription() -> Single<[Term]> {
        return self.request(with: EndpointCases.term, T: [Term].self)
    }
    
    func fetchSupplement(by id: String) -> Single<SupplementResponse> {
        return self.request(with: EndpointCases.supplement(id: id), T: SupplementResponse.self)
    }
    
    func fetchMaterial(by idList: [String]?) -> Single<[MaterialResponse]?> {
        guard let idList = idList
        else {
            return Single.just(nil)
        }
        
        let result = idList.map { id in
            return self.request(with: EndpointCases.material(id: id), T: MaterialResponse.self)
        }
        
        return Single.zip(result).map { $0 }
    }
    
    func fetchRecommendSupplement(by keyword: String) -> Single<RecommendSupplementResponse> {
        self.request(with: EndpointCases.recommendation(keyword: keyword, req: 1),
                     T: RecommendSupplementResponse.self)
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
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(T.self, from: data)
//                        print(">>requestURL", requestURL, "\n")
                        single(.success(decodedData))
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("++Key '\(key)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
                        print("++requestURL", requestURL, "\n")
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let error {
                        print("Error: DefaultSupplementNetworkService - \(error.localizedDescription)")
                        print("requestURL", requestURL)
                        single(.failure(NetworkError.failedDecode))
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

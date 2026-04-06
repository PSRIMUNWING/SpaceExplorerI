//
//  ADOPRepository.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 29/3/2569 BE.
//

import Foundation
import RxSwift
import Alamofire

protocol ADOPRepositoryProtocol {
    func getADOP(date: String) -> Observable<GetADOPResponse>
}

class ADOPRepository: ADOPRepositoryProtocol {
    private let apiService: APIService
    
    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }
    
    func getADOP(date: String) -> Observable<GetADOPResponse> {
        return Observable.create { observer in
            AF.request(
                "https://api.nasa.gov/planetary/apod",
                parameters: ["api_key": "DEMO_KEY", "date": date]
            )
            .response { response in
                print(">>> data count: \(response.data?.count ?? 0)")
                print(">>> status code: \(response.response?.statusCode ?? 0)")
                if let data = response.data {
                    print(">>> full raw: \(String(data: data, encoding: .utf8) ?? "nil")")
                }
            }
            .responseDecodable(of: GetADOPResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 429:
                            observer.onError(NSError(
                                domain: "APIError",
                                code: 429,
                                userInfo: [NSLocalizedDescriptionKey: "You have exceeded the API limit, \nplease wait a moment"]
                            ))
                        case 401:
                            observer.onError(NSError(
                                domain: "APIError",
                                code: 401,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid API Key"]
                            ))
                        case 500:
                            observer.onError(NSError(
                                domain: "APIError",
                                code: 500,
                                userInfo: [NSLocalizedDescriptionKey: "Server error, \nplease try again later"]
                            ))
                        default:
                            observer.onError(error)
                        }
                    } else {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}

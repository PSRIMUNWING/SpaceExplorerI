//
//  APIService.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 29/3/2569 BE.
//

import Alamofire

class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.nasa.gov"
    
    func get<T: Decodable>(path: String, parameters: Parameters? = nil) async throws -> T {
        return try await AF.request(
            baseURL + path,
            method: .get,
            parameters: parameters
        )
        .serializingDecodable(T.self)
        .value
    }
}

//
//  GetADOPUseCase.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 29/3/2569 BE.
//


//class GetADOPUseCase {
//    private let repository: ADOPRepositoryProtocol
//    
//    init(repository: ADOPRepositoryProtocol = ADOPRepository()) {
//        self.repository = repository
//    }
//    
//    func execute(date: String) async throws -> GetADOPResponse {
//        guard !date.isEmpty else {
//            throw NSError(domain: "InvalidDate", code: 0, userInfo: [NSLocalizedDescriptionKey: "Date must not be empty"])
//        }
//        return try await repository.getADOP(date: date)
//    }
//}

import RxSwift

class GetADOPUseCase {
    private let repository: ADOPRepositoryProtocol
    
    init(repository: ADOPRepositoryProtocol = ADOPRepository()) {
        self.repository = repository
    }
    
    func execute(date: String) -> Observable<GetADOPResponse> {
        return repository.getADOP(date: date)
    }
}

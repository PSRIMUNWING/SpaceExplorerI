//
//  GetADOPResponse.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 29/3/2569 BE.
//

import Foundation

struct GetADOPResponse: Decodable {
    let title: String
    let explanation: String
    let url: String
    let date: String
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case url
        case date
        case mediaType = "media_type"
    }
}

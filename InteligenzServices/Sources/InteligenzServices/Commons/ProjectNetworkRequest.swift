//
//  File.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import ServicesLibrary

struct ProjectNetworkRequest: NetworkRequest {
    let method: NetworkRequestMethod
    let serviceName: String
    let url: String
    let headers: [String: String]
    let body: String?
}

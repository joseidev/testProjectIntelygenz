//
//  File.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation
import InteligenzDomain

struct NewsDTO: Decodable {
    let articles: [ArticleDTO]
}

struct ArticleDTO: Decodable {
    let titleDTO: String?
    let descriptionDTO: String?
    let urlDTO: String?
    let urlToImageDTO: String?
    let publishedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case titleDTO = "title"
        case descriptionDTO = "description"
        case urlDTO = "url"
        case urlToImageDTO = "urlToImage"
        case publishedAt
    }
}

extension ArticleDTO: ArticleRepresentable {
    var title: String {
        return titleDTO ?? ""
    }
    
    var description: String {
        return descriptionDTO ?? ""
    }

    var url: String {
        return urlDTO ?? ""
    }
    
    var urlToImage: String {
        return urlToImageDTO ?? ""
    }
    
    var date: Date? {
        return publishedAt
    }
    
    
}

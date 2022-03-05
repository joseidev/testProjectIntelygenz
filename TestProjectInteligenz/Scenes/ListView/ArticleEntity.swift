//
//  Article.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation

struct ArticleEntity: Identifiable {
    let id: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let date: Date
}

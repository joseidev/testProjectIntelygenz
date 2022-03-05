//
//  Article.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation

struct Article: Identifiable {
    let source: ArticleSource
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    
    var id: String {
        return source.id
    }
}

struct ArticleSource {
    let id: String
    let name: String
}


let demoArticle = Article(
    source: ArticleSource(
        id: "42",
        name: "Engadget"),
    author: "Igor Bonifacic",
    title: "Russia restricts Twitter access amid Ukraine invasion",
    description: "Russia has moved to restrict access to Twitter as its invasion of Ukraine continues. Starting early Saturday morning, internet monitor NetBlocks\r\n saw a nearly complete blackout of the platform across all major domestic telecom providers, including Rostelecom…",
    url: "https://www.engadget.com/russia-restricts-domestic-twitter-access-172821677.html",
    urlToImage: "https://s.yimg.com/os/creatr-uploaded-images/2022-02/4a81a860-9728-11ec-bfdb-f1e372acbcfd",
    publishedAt: Date())

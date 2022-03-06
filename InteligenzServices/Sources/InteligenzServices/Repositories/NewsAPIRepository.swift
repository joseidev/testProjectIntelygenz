//
//  File.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation
import ServicesLibrary
import InteligenzDomain
import Combine

final class NewsApiRepository {
    let networkClientManager: NetworkClientManager
    private let coreDataRepository: CoreDataRepository
    
    init(networkClientManager: NetworkClientManager, coreDataRepository: CoreDataRepository) {
        self.networkClientManager = networkClientManager
        self.coreDataRepository = coreDataRepository
    }
}

private extension NewsApiRepository {

    func getUnkownError() -> AnyPublisher<[ArticleRepresentable], Error> {
        return Fail<[ArticleRepresentable], Error>(error: NetworkError.unknown)
            .eraseToAnyPublisher()
    }
    
    enum Constants {
        static let url = "https://newsapi.org/v2/everything"
        static let queryKey = "q"
        static let queryValue = "ukraine"
        static let apiKey = "apiKey"
        static let apiKeyValue = "83e3ce23dc4e4599ae2995014e1f6414"
        static let pageSizeKey = "pageSize"
        static let pageSizeValue = "100"
    }
}

extension NewsApiRepository: NewsRepository {
    func fetchNews() -> AnyPublisher<[ArticleRepresentable], Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        let queryParams = [Constants.queryKey: Constants.queryValue,
                           Constants.apiKey: Constants.apiKeyValue,
                           Constants.pageSizeKey: Constants.pageSizeValue]
        let request = ProjectNetworkRequest(
            method: .get,
            serviceName: "",
            url: Constants.url,
            headers: [:],
            body: nil)
        guard let requestWithParams = try? NetworkRequestBuilder.addQueryParams(
            request,
            queryParams: queryParams) else {
                return getUnkownError()
            }
        do {
            return try networkClientManager.request(requestWithParams, requestInterceptors: [])
                .map(\.data)
                .mapError { $0 as Error }
                .decode(type: NewsDTO.self, decoder: decoder)
                .tryMap { [unowned self] news in
                    let articles = news.articles.filter { $0.publishedAt != nil }
                    let representables: [ArticleRepresentable] = articles
                    let filteredRepresentables = representables.filter { article in
                        return !article.title.isEmpty
                        && !article.description.isEmpty
                        && !article.url.isEmpty
                        && !article.urlToImage.isEmpty
                    }
                    try self.coreDataRepository.deleteArticles()
                    try self.coreDataRepository.save(articles: filteredRepresentables)
                    return filteredRepresentables
                }
                .tryCatch { [unowned self] error -> AnyPublisher<[ArticleRepresentable], Error> in
                    let articles = try self.coreDataRepository.getArticles()
                    return Just(articles)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()                    
                }
                .eraseToAnyPublisher()
        } catch {
            return getUnkownError()
        }
    }
}

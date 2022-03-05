//
//  FetchNewsUseCase.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Combine
import InteligenzDomain
import Foundation

protocol FetchNewsUseCaseProtocol {
    func fetch() -> AnyPublisher<[ArticleEntity], Error>
}

final class FetchNewsUseCase {
    @Inject var repositoriesProvider: RepositoriesProvider
}

extension FetchNewsUseCase: FetchNewsUseCaseProtocol {
    func fetch() -> AnyPublisher<[ArticleEntity], Error> {
        return repositoriesProvider.newsRepository
            .fetchNews()
            .map { representables in
                return representables.compactMap { representable -> ArticleEntity? in
                    guard let url = URL(string: representable.url),
                          let urlToImage = URL(string: representable.urlToImage) else {
                              return nil
                          }
                    return ArticleEntity(
                        id: UUID().uuidString,
                        title: representable.title,
                        description: representable.description,
                        url: url,
                        urlToImage: urlToImage,
                        date: representable.date ?? Date())
                }
            }
            .map { entities in
                return entities.sorted(by: {
                    return $0.date > $1.date
                })
            }
            .eraseToAnyPublisher()
    }
}

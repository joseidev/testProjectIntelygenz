//
//  MockNewsAPIRepository.swift
//  TestProjectInteligenzTests
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import Foundation
import InteligenzDomain
import Combine

final class MockNewsAPIRepository: NewsRepository {
    func fetchNews() -> AnyPublisher<[ArticleRepresentable], Error> {
        return Just([Article()])
            .delay(for: 1, scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

private extension MockNewsAPIRepository {
    struct Article: ArticleRepresentable {
        let title = "Twitter is pausing ads and recommendations in Ukraine and Russia"
        let description = "Twitter has temporarily paused ads in Ukraine and Russia, one of several steps the company is taking to highlight safety information and minimize “risks associated with the conflict in Ukraine.”“We’re temporarily pausing advertisements in Ukraine and Russia t…"
        let url = "https://www.engadget.com/twitter-is-pausing-ads-and-recommendations-in-ukraine-and-russia-004617413.html"
        let urlToImage = "https://s.yimg.com/os/creatr-uploaded-images/2021-04/6903eb10-9d49-11eb-9ebc-d0c616a3ce25"
        let date = Date()
    }
}

//
//  MockFetchNewsUseCase.swift
//  TestProjectInteligenzTests
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import Foundation
import Combine
@testable import TestProjectInteligenz

final class MockFetchNewsUseCase: FetchNewsUseCaseProtocol {
    func fetch() -> AnyPublisher<[ArticleEntity], Error> {
        let entity = ArticleEntity(
            id: "id",
            title: "title",
            description: "description",
            url: URL(string: "https://www.theverge.com/2022/2/26/22952128/twitter-pauses-ads-ukraine-russia-conflict")!,
            urlToImage: URL(string: "https://cdn.vox-cdn.com/thumbor/wKKSgbRLHB_QxDbI_4dUGoOMyvY=/0x146:2040x1214/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/8966107/acastro_170726_1777_0012.jpg")!,
            date: Date())
        return Just([entity])
            .delay(for: 1, scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

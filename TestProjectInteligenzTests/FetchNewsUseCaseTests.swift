//
//  TestProjectInteligenzTests.swift
//  TestProjectInteligenzTests
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import XCTest
import InteligenzDomain
import Combine
@testable import TestProjectInteligenz

class FetchNewsUseCaseTests: XCTestCase {
    
    var sut: FetchNewsUseCaseProtocol!
    private var cancelableSet = Set<AnyCancellable>()

    override func setUpWithError() throws {
        DependencyResolver.shared.register(type: RepositoriesProvider.self) {
            return MockRepositoriesProvider()
        }
        sut = FetchNewsUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetch_success() throws {
        let expectation = XCTestExpectation(description: "Get news")
        var articles: [ArticleEntity]?
        sut.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail()
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                articles = value
                expectation.fulfill()
            })
            .store(in: &cancelableSet)
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(articles![0].title, "Twitter is pausing ads and recommendations in Ukraine and Russia")
        XCTAssertEqual(articles![0].description, "Twitter has temporarily paused ads in Ukraine and Russia, one of several steps the company is taking to highlight safety information and minimize “risks associated with the conflict in Ukraine.”“We’re temporarily pausing advertisements in Ukraine and Russia t…")
        XCTAssertEqual(articles![0].url.absoluteString, "https://www.engadget.com/twitter-is-pausing-ads-and-recommendations-in-ukraine-and-russia-004617413.html")
        XCTAssertEqual(articles![0].urlToImage.absoluteString, "https://s.yimg.com/os/creatr-uploaded-images/2021-04/6903eb10-9d49-11eb-9ebc-d0c616a3ce25")
    }
}

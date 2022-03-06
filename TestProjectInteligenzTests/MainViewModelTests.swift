//
//  MainViewModelTests.swift
//  TestProjectInteligenzTests
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import Foundation
import XCTest
import Combine
@testable import TestProjectInteligenz

class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    private var cancelableSet = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = MainViewModel(fetchNewsUseCase: MockFetchNewsUseCase())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_initState_isLoading() throws {
        if case .loading = sut.state { } else {
            XCTFail()
        }
    }
    
    func test_viewDidLoad_callsLoaded_success() throws {
        let expectation = XCTestExpectation(description: "Get news")
        sut.$state
            .sink { value in
                if case .resultsLoaded(let isEmpty) = value {
                    XCTAssertFalse(isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancelableSet)
        wait(for: [expectation], timeout: 10)
        let article  = sut.articlesToShow[0]
        XCTAssertEqual(article.id, "id")
        XCTAssertEqual(article.title, "title")
        XCTAssertEqual(article.description, "description")
        XCTAssertEqual(article.url.absoluteString, "https://www.theverge.com/2022/2/26/22952128/twitter-pauses-ads-ukraine-russia-conflict")
        XCTAssertEqual(article.urlToImage.absoluteString, "https://cdn.vox-cdn.com/thumbor/wKKSgbRLHB_QxDbI_4dUGoOMyvY=/0x146:2040x1214/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/8966107/acastro_170726_1777_0012.jpg")
    }

}

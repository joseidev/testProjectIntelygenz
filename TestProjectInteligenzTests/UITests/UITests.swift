//
//  UITests.swift
//  TestProjectInteligenzTests
//
//  Created by Jose Ignacio de Juan Díaz on 7/3/22.
//

import XCTest
import Combine
import SwiftUI
import SnapshotTesting
@testable import TestProjectInteligenz

class UITests: XCTestCase {
    
    func testMainView_initialState_loading() {
        let view = MainView()
        let vc = UIHostingController(rootView: view)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }

    func testDetailView_initialState_entityLoaded() {
        let entity = ArticleEntity(
            id: "id",
            title: "Twitter is pausing ads and recommendations in Ukraine and Russia",
            description: "Twitter has temporarily paused ads in Ukraine and Russia, one of several steps the company is taking to highlight safety information and minimize “risks associated with the conflict in Ukraine.”“We’re temporarily pausing advertisements in Ukraine and Russia t…",
            url: URL(string: "https://www.theverge.com/2022/2/26/22952128/twitter-pauses-ads-ukraine-russia-conflict")!,
            urlToImage: URL(string: "https://cdn.vox-cdn.com/thumbor/wKKSgbRLHB_QxDbI_4dUGoOMyvY=/0x146:2040x1214/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/8966107/acastro_170726_1777_0012.jpg")!,
            date: Date())
        let view = DetailView(article: entity)
        let vc = UIHostingController(rootView: view)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
}

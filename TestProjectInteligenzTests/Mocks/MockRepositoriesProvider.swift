//
//  MockRepositoriesProvider.swift
//  TestProjectInteligenzTests
//
//  Created by Jose Ignacio de Juan Díaz on 6/3/22.
//

import Foundation
import InteligenzDomain

final class MockRepositoriesProvider: RepositoriesProvider {
    var newsRepository: NewsRepository {
        return MockNewsAPIRepository()
    }
}

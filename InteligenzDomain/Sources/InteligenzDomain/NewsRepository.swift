//
//  File.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Combine

public protocol NewsRepository {
    func fetchNews() -> AnyPublisher<[ArticleRepresentable], Error>
}

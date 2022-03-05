//
//  RepositoriesProvider.swift
//  
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation

public protocol RepositoriesProvider {
    var newsRepository: NewsRepository { get }
}

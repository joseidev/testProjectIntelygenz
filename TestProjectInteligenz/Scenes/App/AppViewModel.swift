//
//  AppViewModel.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Foundation
import InteligenzServices
import InteligenzDomain

final class AppViewModel: ObservableObject {
    private let services = Services()
    
    init() {
        setupDependencies()
    }
    
}

private extension AppViewModel {
    func setupDependencies() {
        DependencyResolver.shared.register(type: RepositoriesProvider.self) {
            return self.services
        }
    }
}

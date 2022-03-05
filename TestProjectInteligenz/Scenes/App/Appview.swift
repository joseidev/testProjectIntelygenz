//
//  TestProjectInteligenzApp.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI

@main
struct AppView: App {
    
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

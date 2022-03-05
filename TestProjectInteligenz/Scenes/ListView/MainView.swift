//
//  ContentView.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel(fetchNewsUseCase: FetchNewsUseCase())

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    Spacer()
                    ProgressView("Loading calls...")
                        .foregroundColor(.black)
                    Spacer()
                case .error(let message):
                    Spacer()
                    Text(message)
                    Spacer()
                case .resultsLoaded(let articles):
                    if articles.isEmpty {
                        Text("No articles availble, try later.")
                    } else {
                        ListView(articles: articles)
                    }
                }

            }
            .navigationTitle("Ukraine war news")
        }
    }
}

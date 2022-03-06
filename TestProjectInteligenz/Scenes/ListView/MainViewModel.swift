//
//  ListViewModel.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import Combine
import InteligenzDomain
import Foundation
import SwiftUI

enum MainViewState {
    case loading
    case resultsLoaded(Bool)
    case error(String)
}

final class MainViewModel: ObservableObject {    
    private let fetchNewsUseCase: FetchNewsUseCaseProtocol
    private var cancelableSet = Set<AnyCancellable>()
    @Published var state = MainViewState.loading
    private var articles: [ArticleEntity] = []
    @Published var searchQuery = ""
    @Published var articlesToShow: [ArticleEntity] = []
    
    init(fetchNewsUseCase: FetchNewsUseCaseProtocol) {
        self.fetchNewsUseCase = fetchNewsUseCase
        setObservables()
    }
    
    func reloadData() {
        setNewsObservable()
    }
}


private extension MainViewModel {
    func setObservables() {
        setNewsObservable()
        setSearchObservable()
    }
    
    func setNewsObservable() {
        fetchNewsUseCase.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .failure:
                    self.state = .error("Ups! It looks like we have a problem")
                case .finished:
                    break
                }
            }, receiveValue:  { [unowned self] articles in
                withAnimation {
                    self.articles = articles
                    self.articlesToShow = articles
                    self.state = .resultsLoaded(articles.isEmpty)
                }
            })
            .store(in: &cancelableSet)
    }
    
    func setSearchObservable() {
        $searchQuery
            .sink(receiveValue: { [unowned self] query in
                self.handleSearchQuery(query)
            })
            .store(in: &cancelableSet)
    }
    
    func handleSearchQuery(_ query: String) {
        if query.count > 2 {
            self.articlesToShow = self.articles.filter { article in
                article.title.lowercased().contains(searchQuery.lowercased())
            }
        }
        if query.isEmpty {
            self.articlesToShow = self.articles
        }
    }

}

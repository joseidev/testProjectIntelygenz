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
    case resultsLoaded([ArticleEntity])
    case error(String)
}

final class MainViewModel: ObservableObject {    
    private let fetchNewsUseCase: FetchNewsUseCaseProtocol
    private var cancelableSet = Set<AnyCancellable>()
    @Published var state = MainViewState.loading
    private var articles: [ArticleEntity] = []
    
    init(fetchNewsUseCase: FetchNewsUseCaseProtocol) {
        self.fetchNewsUseCase = fetchNewsUseCase
        setObservables()
    }
}


private extension MainViewModel {
    func setObservables() {
        setNewsObservable()
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
                    self.state = .resultsLoaded(articles)
                    self.articles = articles
                }
            })
            .store(in: &cancelableSet)
    }
}

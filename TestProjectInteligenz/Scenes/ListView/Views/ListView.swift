//
//  ListView.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI
import Kingfisher

struct ListView: View {
    private let articles: [ArticleEntity]
    @State var navigateToDetail = false
    @State var selectedArticle = ArticleEntity(
        id: UUID().uuidString,
        title: "",
        description: "",
        url: URL(string: "https://google.es")!,
        urlToImage: URL(string: "https://google.es")!,
        date: Date())
    
    init(articles: [ArticleEntity]) {
        self.articles = articles
    }
    
    var body: some View {
        NavigationLink(isActive: $navigateToDetail,
                       destination: { DetailView(article: selectedArticle) },
                       label: { EmptyView() })
        List(articles, id: \.id) { item in
            Button(action: {
                selectedArticle = item
                navigateToDetail = true
            }, label: {
                HStack(alignment: .top) {
                    KFImage(item.urlToImage)
                        .cacheMemoryOnly()
                        .placeholder {
                            Image("newsPlaceholder")
                                .resizable()
                                .frame(width: 80, height: 60, alignment: .center)
                        }
                        .resizable()
                        .frame(width: 90, height: 60, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .lineLimit(2)
                        Text(item.description)
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .lineLimit(2)
                        Text(item.date, style: .date)
                            .font(.system(size: 10, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .padding(.top, 4)
                    }
                }
                .frame(height: 80, alignment: .topLeading)
            })
        }
    }
}

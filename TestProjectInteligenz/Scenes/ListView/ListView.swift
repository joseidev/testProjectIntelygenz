//
//  ContentView.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI
import Kingfisher

struct ListView: View {
    @State var navigateToDetail = false
    @State var selectedArticle = Article(
        source: ArticleSource(
            id: "",
            name: ""),
        author: "",
        title: "",
        description: "",
        url: "",
        urlToImage: "",
        publishedAt: Date())
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $navigateToDetail,
                               destination: { DetailView(article: selectedArticle) },
                               label: { EmptyView() })
                List([demoArticle], id: \.id) { item in
                    Button(action: {
                        selectedArticle = item
                        navigateToDetail = true
                    }, label: {
                        HStack(alignment: .center) {
                            KFImage(URL(string: item.urlToImage)!)
                                .cacheMemoryOnly()
                                .resizable()
                                .frame(width: 80, height: 60, alignment: .center)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .foregroundColor(.black)
                                    .lineLimit(2)
                                Text(item.description)
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                    .lineLimit(2)
                            }
                        }
                        .frame(height: 70, alignment: .topLeading)
                    })
                }
            }
            .navigationTitle("Ukraine war news")
        }
    }
}

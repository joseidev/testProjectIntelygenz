//
//  ListView.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI
import Kingfisher

struct ListView: View {
    @State var navigateToDetail = false
    @State var selectedArticle: ArticleEntity?
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        if let selected = selectedArticle {
            NavigationLink(isActive: $navigateToDetail,
                           destination: { DetailView(article: selected) },
                           label: { EmptyView() })

        }
        List(viewModel.articlesToShow, id: \.id) { item in
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
                .frame(height: 85, alignment: .topLeading)
            })
        }
        .refreshable {
            viewModel.reloadData()
        }
        .searchable(text: $viewModel.searchQuery)
    }
}

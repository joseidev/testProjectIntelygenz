//
//  DetailView.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    let article: ArticleEntity
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
                KFImage(article.urlToImage)
                    .cacheMemoryOnly()
                    .resizable()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.width * 0.66,
                        alignment: .center)
                    .padding(.bottom, 16)
                Text(article.description)
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(.black)
                    .padding(.bottom, 50)
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Link("Go to article", destination: article.url)
                    })

                    Spacer()
                }
                Spacer()
            }
            .padding()
        }

    }
}

//
//  DetailView.swift
//  TestProjectInteligenz
//
//  Created by Jose Ignacio de Juan Díaz on 5/3/22.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    let article: Article
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(.black)
                .padding(.bottom, 8)
            KFImage(URL(string: article.urlToImage)!)
                .cacheMemoryOnly()
                .resizable()
                .frame(height: 120, alignment: .center)
                .padding(.bottom, 16)
            Text(article.description)
                .font(.system(size: 12, weight: .regular, design: .default))
                .foregroundColor(.black)
                .padding(.bottom, 50)
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Go to article")
                        .font(.system(size: 14, weight: .regular, design: .default))
                })

                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

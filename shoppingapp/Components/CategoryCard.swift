//
//  CategoriesView.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import SwiftUI

struct CategoryCard: View {
    var category: Category
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image(category.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
            }
        }
        .frame(width: 180, height: 200)
        .shadow(radius: 3)
    }
}

struct CategoryCard_Preview: PreviewProvider {
    static var previews: some View {
        CategoryCard(category: categories[0])
        // products.filter({$0.type == "Books"})
    }
}

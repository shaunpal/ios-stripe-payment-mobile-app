//
//  ProductListView.swift
//  shoppingapp
//
//  Created by shaun on 10/5/24.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var cartManager: CartManager
    @Binding var categoryChosen: String
    
    var columns = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 0.3), spacing: 20)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                let filteredList = categoryChosen == "Sales" ? (productList.filter({$0.onSale == true})) : productList.filter({$0.type == categoryChosen})
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredList, id: \.id){ product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
        }.navigationTitle(categoryChosen)
    }
}

#Preview {
    ProductListView(categoryChosen: .constant("Books"))
        .environmentObject(CartManager())
}

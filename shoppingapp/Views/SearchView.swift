//
//  SearchView.swift
//  shoppingapp
//
//  Created by shaun on 5/5/24.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String

    func body(content: Content) -> some View {
        content
            .overlay {
                Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(.secondary)
                        .padding(.trailing, 30)
                    }
                }
            }
    }
}

extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(fieldText: text))
    }
}

struct SearchView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var searchTerm = ""
    @State var navigated = false
    var body: some View {
        
        NavigationStack {
            List(productList.filter({$0.name.contains(searchTerm)}), id: \.id) { product in
                   NavigationLink {
                       ItemView(product: product)
                           .environmentObject(cartManager)
                   } label: {
                       HStack {
                           Image(product.image)
                               .resizable()
                               .scaledToFit()
                               .frame(width: 20)

                           Text(product.name)
                               .font(.caption)

                           Text(product.type)
                               .font(.caption)
                               .frame(maxWidth: .infinity, alignment: .trailing)
                       }
                   }
                       
           }
            .searchable(text: $searchTerm, prompt: "Search for product..")
            .navigationTitle("Search")
            .toolbar(.hidden, for: .tabBar)
        }
    }
}



struct SearchView_Previews : PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(CartManager())
    }
}

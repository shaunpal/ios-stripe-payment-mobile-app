//
//  CategoriesView.swift
//  shoppingapp
//
//  Created by shaun on 7/5/24.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var currentCategory = ""
    @State var navigated = false
    
    var body: some View {
            VStack(alignment: .leading, spacing: 1) {
                ForEach(categories, id: \.id){ category in
                    ZStack {
                        VStack {
                            Image(category.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
                                .clipped()
                            
                        }
                        Text(category.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .shadow(color: .black, radius: 5, x: 0, y: 0)
                            
                        
                    }
                    .onTapGesture {
                        currentCategory = category.name
                        navigated.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $navigated) {
                ProductListView(categoryChosen: $currentCategory)
                    .environmentObject(cartManager)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink {
                                SearchView()
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink {
                                CartView()
                                    .environmentObject(cartManager)
                            } label: {
                                CartButton(numberOfProducts: cartManager.products.count)
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 10)
                        }
                    }
            }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(CartManager())
    }
}

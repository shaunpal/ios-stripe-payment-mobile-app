//
//  ExploreView.swift
//  shoppingapp
//
//  Created by shaun on 10/5/24.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var receiptManager: ReceiptManager
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    @State var categoryChosen: String = ""
    @State var navigated = false
    var body: some View {
        VStack {
                Text("Explore")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(categories, id: \.id) { category in
                        VStack(alignment: .center) {
                            Image(category.image)
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width * 0.45)
                                .foregroundColor(.white.opacity(0.7))
                                .overlay(alignment: .center){
                                    Text(category.name)
                                        .bold()
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                                        .padding()
                                }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.orange.opacity(0.3), radius: 5, x: 0, y: 0)
                        
                        .onTapGesture {
                            categoryChosen = category.name
                            navigated.toggle()
                        }
                    }
                    .shadow(radius: 3)
                }
            
        }
        .padding()
        .navigationDestination(isPresented: $navigated) {
            ProductListView(categoryChosen: $categoryChosen)
                .environmentObject(cartManager)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink {
                            SearchView()
                                .environmentObject(cartManager)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink {
                            CartView()
                                .environmentObject(cartManager)
                                .environmentObject(receiptManager)
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

#Preview {
    ExploreView()
        .environmentObject(CartManager())
        .environmentObject(ReceiptManager())
}

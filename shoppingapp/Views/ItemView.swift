//
//  ItemView.swift
//  shoppingapp
//
//  Created by shaun on 23/5/24.
//

import SwiftUI

struct ItemView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var scaleSize: Double = 1.0
    
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 280, alignment: .center)
                
                VStack {
                    Text(product.name)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Text("Categories: ")
                            .foregroundColor(.gray)
                        Text(product.type)
                            .bold()
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Text("Quantity: ")
                            .foregroundColor(.gray)
                        Text("\(product.quantity)")
                            .bold()
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    if product.onSale {
                        HStack {
                            Text("Original: ")
                                .foregroundColor(.gray)
                            
                            Text("$\(product.price, specifier: "%.2f") SGD")
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .font(.title3)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .strikethrough(pattern: .solid, color: .red)
                                
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                        .padding(.bottom, 3)
                    }
                    
                    HStack {
                        Text("Price: ")
                            .foregroundColor(.gray)
                        Text("$\(product.getTotalPrice(), specifier: "%.2f") SGD")
                            .bold()
                            .font(.title)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 10)
            
            
            
            Spacer()
            
            HStack {
                Label("Add to Cart", systemImage: "cart")
                    .foregroundColor(.white)
                    .bold()
            }
            .foregroundColor(.black)
            .bold()
            .scaleEffect(scaleSize)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50, alignment: .center)
            .background(Color.orange)
            .padding()
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.15)) {
                    scaleSize = 1.2
                } completion: {
                    withAnimation(.easeOut(duration: 0.15)) {
                        scaleSize = 1.0
                    }
                }
                DispatchQueue.main.async {
                    cartManager.addToCart(product: product)
                }
            }
        }
    }
}

#Preview {
    ItemView(product: productList[2])
        .environmentObject(CartManager())
}

//
//  ProductCard.swift
//  shoppingapp
//
//  Created by shaun on 5/5/24.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    
    var product: Product
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading) {
                    NavigationLink {
                        ItemView(product: product)
                            .environmentObject(cartManager)
                    } label: {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 180, alignment: .center)
                    }
                    
                        
                    
                    VStack {
                        Text(product.name)
                            .bold()
                        
                        if (product.onSale) {
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .opacity(0.6)
                                .strikethrough()
                                .frame(maxWidth: 180)
                            
                            Text("$\(cartManager.computeDiscount(price: product.price, discount: product.discountPercent), specifier: "%.2f")")
                                .font(.callout)
                                .foregroundColor(.brown)
                                .bold()
                                .frame(maxWidth: 180, alignment: .center)
                            
                        } else {
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.callout)
                                .foregroundColor(.brown)
                                .bold()
                                .frame(maxWidth: 180, alignment: .center)
                        }
                    }
                    .frame(width: 180)
                    
                }
                .frame(width: 180, height: 250)
                .padding(.top, 10)
                
                Button {
                    cartManager.addToCart(product: product)
                } label: {
                    Image(systemName: "plus")
                        .padding(10)
                        .foregroundColor(.green)
                        .background(.black)
                        .cornerRadius(50)
                    
                }
                
            }
            if (product.onSale) {
                Image("sale")
                    .resizable()
                    .frame(width: 55, height: 32)
                    .scaledToFit()
                
                Text("\(product.discountPercent)%")
                    .font(.title3)
                    .foregroundColor(.red)
                    .bold()
                    .padding(.leading, 8)
                    .padding(.top, 33)
                    .rotationEffect(Angle(degrees: -11))
                    .frame(maxWidth: 180, alignment: .topLeading)
                
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 3)
        
    }
}

struct ProductCard_Preview: PreviewProvider {
    static var previews: some View {
        ProductCard(product: productList[2])
            .environmentObject(CartManager())
    }
}

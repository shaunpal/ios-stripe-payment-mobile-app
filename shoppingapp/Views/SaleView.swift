//
//  SaleView.swift
//  shoppingapp
//
//  Created by shaun on 10/5/24.
//

import SwiftUI

struct SaleView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        VStack {
            Text("Sale items!!")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    LazyHStack(spacing: 20) {
                        ForEach(productList.filter({ $0.onSale == true }), id: \.id) { product in
                            VStack(alignment: .center) {
                                ZStack(alignment: .topLeading) {
                                    ZStack(alignment: .bottom) {
                                        NavigationLink {
                                            ItemView(product: product)
                                                .environmentObject(cartManager)
                                        } label: {
                                            Image(product.image)
                                                .resizable()
                                                .scaledToFit()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 150)
                                        }
                                    }
                                    
                                    Text("\(product.discountPercent)% \nOFF")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.red)
                                        .rotationEffect(Angle(degrees: -11))
                                        .padding(.leading, 9)
                                        .padding(.top, 5)
                                        .shadow(color: .white, radius: 1, x: 0, y: 0)
                                }
                                
                                Label("\(product.type)", systemImage: "tag")
                                    .bold()
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                                
                                Text(product.name)
                                    .multilineTextAlignment(.center)
                    
                            }
                            .padding()
                            .frame(width: 180, alignment: .center)
                        }
                        .shadow(radius: 3)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    SaleView()
        .environmentObject(CartManager())
}

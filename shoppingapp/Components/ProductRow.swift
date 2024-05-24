//
//  ProductRow.swift
//  shoppingapp
//
//  Created by shaun on 5/5/24.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        HStack(spacing: 20) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .bold()
                
                HStack {
                    Button {
                        cartManager.addToCart(product: product)
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.trailing, 10)
                    
                    
                    Text("\(product.quantity)")
                        
                    Button {
                        cartManager.minusFromCart(product: product)
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.leading, 10)
                }
            }
            Spacer()
            VStack {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .onTapGesture {
                        cartManager.removeFromCart(product: product)
                    }
                
                Text("$\(product.getTotalPrice(), specifier: "%.2f")")
                    .padding(.top, 30)
                    .bold()
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .overlay(Divider(), alignment: .top)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProductRow(product: productList[0])
        .environmentObject(CartManager())
}


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.scaleEffect(configuration.isPressed ? 1.2 : 1)
    }
}

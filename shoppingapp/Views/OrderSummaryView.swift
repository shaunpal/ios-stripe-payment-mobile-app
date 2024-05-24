//
//  OrderSummaryView.swift
//  shoppingapp
//
//  Created by shaun on 14/5/24.
//

import SwiftUI

struct OrderSummaryView: View {
    @EnvironmentObject var cartManager: CartManager
    
    @State var expand = true
    var body: some View {
        VStack {
            HStack {
                Text("Order Summary")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                Spacer()
                Image(systemName: !expand ? "chevron.down" : "chevron.up")
                    .frame(width: 10, height: 10)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            }
            .padding()
            .onTapGesture {
                self.expand.toggle()
            }
            
            Divider()
                .padding(.horizontal, 10)
            
            if expand {
                ScrollView {
                    VStack {
                        ForEach(cartManager.products, id: \.id){ product in
                            VStack {
                                HStack {
                                    Text(product.name)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                }
                                .padding(5)
                                
                                HStack {
                                    Text("X  \(product.quantity)")
                                    Spacer()
                                    Text("$\(product.getTotalPrice(), specifier: "%.2f")")
                                }
                                .padding(5)
                                
                                Spacer()
                            }
                           
                        }
                        HStack {
                            Text("Total items: \(cartManager.computeTotalItemQuantity())")
                        }
                        Divider()
                        HStack {
                            Text("Subtotal: ")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(cartManager.total, specifier: "%.2f")")
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("Delivery: ")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("0.00")
                                .foregroundColor(.gray)
                        }
                        Divider()
                        HStack {
                            Text("Total: ")
                                .bold()
                            Spacer()
                            Text("\(cartManager.total, specifier: "%.2f")")
                                .bold()
                        }
                    }
                    .padding(.horizontal, 10)
                    .background()
                }
            }
        }
        .padding(10)
        .frame(height: expand ? 300 : 50, alignment: .topLeading)
        
    }
}

#Preview {
    OrderSummaryView()
        .environmentObject(CartManager())
}

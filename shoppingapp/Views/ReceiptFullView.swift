//
//  ReceiptFullView.swift
//  shoppingapp
//
//  Created by shaun on 22/5/24.
//

import SwiftUI

struct ReceiptFullView: View {
    var orderReceipt: OrderReceipt
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Spacer()
                    Text("Purchase Receipt")
                        .font(.headline)
                }
                Divider()
                VStack(alignment: .center) {
                    Text("Thank you for your purchase!")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.orange)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    Text("Your ShopCart order has been placed successfully. We'll notify you as soon as the order is packed and shipped")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    Divider()
                }
                
                VStack {
                    Text("Order Summary")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Order id:")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        Text("#\(orderReceipt.id)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Transaction Date:")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        Text("\(orderReceipt.date)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Payment Method:")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        HStack {
                            if orderReceipt.paymentMethod == "creditcard" {
                                Image(systemName: orderReceipt.paymentMethod)
                            } else {
                                Image(uiImage: UIImage(data: Data(base64Encoded: orderReceipt.paymentMethod)!)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50)
                            }
                            Text("ending \(orderReceipt.paymentCardNo)")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Delivery Method:")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        Text("Express shipping (1 to 2 days)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Shipping Address:")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        Text(orderReceipt.address)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Email")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                        Text(orderReceipt.email)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 5)
                }
                Divider()
                
                VStack {
                    Text("Order Details")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    VStack {
                        ForEach(orderReceipt.orders, id: \.id){ product in
                            HStack {
                                Image(product.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.caption)
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                        .padding(.bottom, 5)
                                    
                                    Text("Quantity: \(product.quantity)")
                                        .font(.caption)
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                        
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                                
                                VStack(alignment: .trailing) {
                                    Text("Unit Price: \(product.price, specifier: "%.2f") SGD$")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.bottom, 5)
                                    
                                    Text("Total: \(product.getTotalPrice(), specifier: "%.2f") SGD$")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                        
                                }
                            }
                            .padding(.bottom, 15)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        }
                        .padding(.bottom, 10)
                        Divider()
                        
                        HStack {
                            Label("Download Receipt", systemImage: "arrow.down.doc")
                                .font(.caption)
                                .bold()
                        }
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .center) {
                            HStack {
                                Text("Order Summary")
                                    .bold()
                            }
                            HStack {
                                Text("Subtotal: ")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .bold()
                                Spacer()
                                Text("\(orderReceipt.amount)")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .bold()
                            }
                            HStack {
                                Text("Discount: ")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .bold()
                                Spacer()
                                Text("\(orderReceipt.discountAmount)")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .bold()
                            }
                            HStack {
                                Text("Delivery: ")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .bold()
                                Spacer()
                                Text("FREE")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .bold()
                            }
                            Divider()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            HStack {
                                Text("Total: ")
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                    .bold()
                                Spacer()
                                Text("\(orderReceipt.amount)")
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                    .bold()
                            }
                            
                        }
                        .frame(width: 130)
                        .padding(.bottom, 10)
                        
                        Divider()
                        
                        VStack {
                            Text("Thank you very much for choosing our products!\nDo you want to send us a feedback? Send an email to shopCart@gmail.com\nStay updated on our social media platforms.")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 10)
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ReceiptFullView(orderReceipt: orderReceipts[0])
}

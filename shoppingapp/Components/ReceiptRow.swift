//
//  ReceiptRow.swift
//  shoppingapp
//
//  Created by shaun on 22/5/24.
//

import SwiftUI

struct ReceiptRow: View {
    @EnvironmentObject var receiptManager: ReceiptManager
    @State private var showingPopover = false
    var orderReceipt: OrderReceipt
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Order Id:")
                        .font(.caption)
                        .bold()
                    Spacer()
                    Text("#\(orderReceipt.id)")
                        .font(.caption)
                        .lineLimit(1)
                }
                HStack {
                    Text("Transaction Date:")
                        .font(.footnote)
                        .bold()
                    Spacer()
                    Text(orderReceipt.date)
                        .font(.footnote)
                }
                HStack {
                    Text("Payment Method:")
                        .font(.footnote)
                        .bold()
                    Spacer()
                    if orderReceipt.paymentMethod == "creditcard" {
                        Image(systemName: orderReceipt.paymentMethod)
                    } else {
                        Image(uiImage: UIImage(data: Data(base64Encoded: orderReceipt.paymentMethod)!)!)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                    }
                }
                HStack {
                    Text("Amount:")
                        .font(.footnote)
                        .bold()
                    Spacer()
                    Text(orderReceipt.amount)
                        .font(.footnote)
                }
                
            }
            .padding(10)
            
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.horizontal, 5)
        }
        .popover(isPresented: $showingPopover) {
            VStack {
                
                // Full Receipt
                ReceiptFullView(orderReceipt: orderReceipt)
                
                
                // Close Button
                HStack {
                    Text("Close")
                }
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .cornerRadius(20)
                .background(Color.orange)
                .padding()
                .onTapGesture {
                    showingPopover = false
                    
                    DispatchQueue.main.async {
                        receiptManager.openReceipt(orderReceipt: orderReceipt)
                    }
                }
            }
        }
        .opacity(orderReceipt.isOpen ? 0.4 : 1)
        .onTapGesture {
            showingPopover = true
        }
    }
}

#Preview {
    ReceiptRow(orderReceipt: orderReceipts[0])
        .environmentObject(ReceiptManager())
}

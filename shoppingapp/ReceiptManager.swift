//
//  ReceiptManager.swift
//  shoppingapp
//
//  Created by shaun on 22/5/24.
//

import Foundation
import SwiftUI

class ReceiptManager: ObservableObject {
    @Published private(set) var orderReceipts: [OrderReceipt] = []
    
    
    func addReceipt(cartManager: CartManager){
        let dataString = cartManager.selectedPayMethodType?.pngData()?.base64EncodedString() ?? "Empty"
        let card = cartManager.selectedPayMethodCard
        let amount = String(format: "%.2f", cartManager.total)
        let discount = String(format: "%.2f", cartManager.computeTotalDiscount())
        let address = cartManager.selectedAddress
        let email = cartManager.selectedEmail
        let receipt = OrderReceipt(paymentMethod: dataString, paymentCardNo: card, amount: amount, discountAmount: discount, orders: cartManager.products, address: address, email: email)
        orderReceipts.insert(receipt, at: 0)
    }
    
    func openReceipt(orderReceipt: OrderReceipt) {
        if let index = orderReceipts.firstIndex(where: { $0.id == orderReceipt.id}) {
            orderReceipts[index].openReceipt()
        }
    }
}

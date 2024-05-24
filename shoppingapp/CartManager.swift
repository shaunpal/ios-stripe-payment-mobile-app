//
//  CartManager.swift
//  shoppingapp
//
//  Created by shaun on 5/5/24.
//

import Foundation
import SwiftUI

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    @Published private(set) var orderReceipts: [OrderReceipt] = []
    
    @Published private(set) var total: Float = 0
    
    @Published var paymentStatus = false
    @Published var selectedAddress: String = ""
    @Published var selectedEmail: String = ""
    @Published var selectedPayMethodCard: String = ""
    @Published var selectedPayMethodType: UIImage?
    
    func addToCart(product: Product) {
        let getExistingProduct = products.filter({ $0.name == product.name})
        if (getExistingProduct.isEmpty){
            products.append(product)
        } else {
            if let index = products.firstIndex(where: { $0.id == product.id && $0.name == product.name}) {
                products[index].add()
            }
        }
        computeTotal()
    }
    func minusFromCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id && $0.name == product.name}) {
            if (products[index].quantity > 1) {
                products[index].minus()
            }
        }
        computeTotal()
    }
    
    func removeFromCart(product: Product) {
        products = products.filter({$0.id != product.id})
        computeTotal()
    }
    
    func computeDiscount(price: Float, discount: Int) -> Float {
        let percent: Float = Float(discount) / 100
        return price - (price * percent)
    }
    
    func computeTotal() -> Void {
        var currentTotal: Float = 0
        for product in products {
            currentTotal += product.getTotalPrice()
        }
        total = currentTotal
    }
    
    func computeTotalDiscount() -> Float {
        var currentTotalDiscount: Float = 0
        for product in products {
            currentTotalDiscount += (product.price * (Float(product.discountPercent) / 100)) * Float(product.quantity)
        }
        return currentTotalDiscount
    }
    
    func computeTotalItemQuantity() -> Int {
        var currentTotal: Int = 0
        for product in products {
            currentTotal += product.quantity
        }
        return currentTotal
    }
    
    func resetCart() {
        self.products = []
        self.total = 0
    }
}

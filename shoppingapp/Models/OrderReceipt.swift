//
//  OrderReceipt.swift
//  shoppingapp
//
//  Created by shaun on 22/5/24.
//

import Foundation

struct OrderReceipt: Encodable, Identifiable {
    var id = UUID()
    var paymentMethod: String
    var paymentCardNo: String
    var amount: String
    var discountAmount: String
    var date: String = getCurrentDateTime()
    var orders: [Product] = []
    var isOpen: Bool = false
    var address: String = ""
    var email: String = ""
    
    mutating func openReceipt() {
        self.isOpen = true
    }
}

func getCurrentDateTime() -> String {
    let currentDateTime = Date()

    // initialize the date formatter and set the style
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long
    
//    let dateString = formatter.string(from: currentDateTime)
//    let toArray = dateString.components(separatedBy: "at")
//    let backToString = toArray.joined(separator: "\nat")
    
    return formatter.string(from: currentDateTime)
}

var orderReceipts = [
    OrderReceipt(
    paymentMethod: "creditcard",
    paymentCardNo: "**** 4242",
    amount: "$52.67",
    discountAmount: "$0.00",
    orders: [
        Product(name: "Hidden Potential By Adam Grant",type: "Books", image: "book-1", price: 24.49),
        Product(name: "Stop Overthinking By Nick Trenton", type: "Books", image: "book-2", price: 47.68),
    ],
    address: "123 Bleecker Street",
    email: "rando31@hotmail.com"
    )
]

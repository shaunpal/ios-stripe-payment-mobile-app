//
//  Product.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import Foundation

struct Product: Encodable, Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var image: String
    var price: Float
    var onSale: Bool = false
    var discountPercent: Int = 0
    var quantity: Int = 1
    
    mutating func add() {
        self.quantity += 1
    }
    
    mutating func minus() {
        self.quantity -= 1
    }
    
    func getTotalPrice() -> Float {
        var currentPrice = self.price
        if self.onSale {
            currentPrice = currentPrice - ((currentPrice * Float(self.discountPercent))/100)
            return currentPrice * Float(self.quantity)
        }
        return currentPrice * Float(self.quantity)
    }
}

var productList = [
    Product(name: "Hidden Potential By Adam Grant",type: "Books", image: "book-1", price: 24.49),
    Product(name: "Stop Overthinking By Nick Trenton", type: "Books", image: "book-2", price: 47.68),
    Product(name: "The Mountain Is You By Brianna Wiest",type: "Books", image: "book-3", price: 35.20, onSale: true, discountPercent: 30),
    Product(name: "Adidas originals black",type: "Shoes", image: "shoe-1", price: 58.99, onSale: true, discountPercent: 15),
    Product(name: "Adidas originals green",type: "Shoes", image: "shoe-2", price: 57.79, onSale: true, discountPercent: 15),
    Product(name: "Nike canvas grey striped",type: "Shoes", image: "shoe-3", price: 88.00),
    Product(name: "Vans canvas",type: "Shoes", image: "shoe-4", price: 79.20),
    Product(name: "Nike canvas black striped",type: "Shoes", image: "shoe-5", price: 35.20),
    Product(name: "Vans checkered brown beige",type: "Shoes", image: "shoe-6", price: 35.20),
    Product(name: "Hippee peace tee",type: "Clothing", image: "clothing-1", price: 29.00, onSale: true, discountPercent: 20),
    Product(name: "Motivation tee",type: "Clothing", image: "clothing-2", price: 29.20, onSale: true, discountPercent: 25),
    Product(name: "Nautica polo shirt",type: "Clothing", image: "clothing-3", price: 69.99),
    Product(name: "Vegetable tee",type: "Clothing", image: "clothing-4", price: 38.80),
    Product(name: "Vintage stripe shirt",type: "Clothing", image: "clothing-5", price: 99.00),
    Product(name: "Canon EOS 4000D",type: "Electronics", image: "electronic-1", price: 489.00),
    Product(name: "Playstation 5",type: "Electronics", image: "electronic-2", price: 499.90, onSale: true, discountPercent: 10),
    Product(name: "Samsung 55-inch 4K Smart TV",type: "Electronics", image: "electronic-3", price: 567.00),
]

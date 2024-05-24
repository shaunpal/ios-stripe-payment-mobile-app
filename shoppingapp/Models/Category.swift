//
//  Category.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import Foundation

struct Category: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

var categories = [
  Category(name: "Electronics", image: "electronics"),
  Category(name: "Clothing", image: "clothing"),
  Category(name: "Books", image: "books"),
  Category(name: "Shoes", image: "shoes")
]

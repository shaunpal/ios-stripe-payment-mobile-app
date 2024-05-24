//
//  Tab.swift
//  shoppingapp
//
//  Created by shaun on 12/5/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "house.fill"
    case categories = "list.bullet.clipboard"
    case sales = "percent"
    case receipts = "newspaper"
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .categories:
            return "Categories"
        case .sales:
            return "Sales"
        case .receipts:
            return "Receipts"
        }
    }
}
 
// Animated SF Tab Model
struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}

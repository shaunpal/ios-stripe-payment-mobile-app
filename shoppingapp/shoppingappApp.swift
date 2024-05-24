//
//  shoppingappApp.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import SwiftUI
import Stripe

@main
struct shoppingappApp: App {
    
    init(){
        StripeAPI.defaultPublishableKey = "\(ProcessInfo.processInfo.environment["STRIPE_API_KEY"] ?? "")"
    }
    @StateObject var notificationManager = LocalNotificationManager()
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .environmentObject(notificationManager)
        }
    }
}

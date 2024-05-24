//
//  PaymentConfig.swift
//  shoppingapp
//
//  Created by shaun on 13/5/24.
//

import Foundation

class PaymentConfig: Encodable {
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() {}
}

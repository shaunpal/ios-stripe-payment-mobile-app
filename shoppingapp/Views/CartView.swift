//
//  CartView.swift
//  shoppingapp
//
//  Created by shaun on 5/5/24.
//

import SwiftUI
import Stripe
import StripePaymentSheet
import StripeUICore


struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var receiptManager: ReceiptManager
    @EnvironmentObject var notificationManager: LocalNotificationManager
    @State var isActive: Bool = false
    @State var isCheckedOut: Bool = false
    
    private func startCheckout(completion: @escaping (String?) -> Void) {
        isCheckedOut.toggle()
        let url = URL(string: "\(ProcessInfo.processInfo.environment["STRIPE_SERVER_API_HOSTNAME"] ?? "")/create-payment-intent")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(cartManager.products)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil,
                      (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(nil)
                return
            }
            
            let checkoutIntentResponse = try?
                JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            
            completion(checkoutIntentResponse?.clientSecret)
            
        }.resume()
    }
    
    var body: some View {
        ScrollView {
            if cartManager.paymentStatus {
                Text("Thanks for your purchase! You'll receive an email notification shortly.")
            } else {
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id){ product in
                        ProductRow(product: product)
                    }
                    
                    VStack {
                        Divider()
                        HStack(alignment: .center) {
                            Text("Subtotal")
                                .foregroundColor(.gray)
                                .opacity(0.7)
                            Spacer()
                            Text("$\(cartManager.total, specifier: "%.2f")")
                                .foregroundColor(.gray)
                                .opacity(0.7)
                        }
                        
                        HStack(alignment: .center) {
                            Text("Shipping")
                                .foregroundColor(.gray)
                                .opacity(0.7)
                            Spacer()
                            Text("Free")
                                .foregroundColor(.gray)
                                .opacity(0.7)
                        }
                        Divider()
                        
                        HStack(alignment: .center) {
                            Text("Total:")
                            Spacer()
                            Text("$\(cartManager.total, specifier: "%.2f")")
                                .bold()
                        }
                    }
                    .padding()
                    
                    Button("Checkout"){
                        startCheckout { clientSecret in
                            PaymentConfig.shared.paymentIntentClientSecret = clientSecret
                            
                            DispatchQueue.main.async {
                                isActive = true
                                isCheckedOut = false
                            }
                            
                        }
                    }
                    .padding()
                    .buttonStyle(CheckoutButton())
                    .disabled(isCheckedOut)
                    
                    if isCheckedOut {
                        ProgressView()
                    }
                    
                } else {
                    Text("Your cart is empty")
                }
            }
        }
        .navigationTitle(Text("My Cart"))
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented:  $isActive) {
            CheckoutView()
                .environmentObject(cartManager)
        }
        .padding(.top)
        .onDisappear {
            if cartManager.paymentStatus {
                cartManager.resetCart()
                cartManager.paymentStatus = false
            }
        }
        .task {
            if cartManager.paymentStatus {
                receiptManager.addReceipt(cartManager: cartManager)
                await triggerNotification(cart: cartManager)
            }
        }
        
    }
    
    
    private func triggerNotification(cart: CartManager) async {
        // get the current date and time
        let currentDateTime = Date()

        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        
        
        let title = "Payment Successful"
        let body = """
        Successful transaction of $\(String(format: "%.2f", cart.total)) taken on card ending \(cart.selectedPayMethodCard), on \(formatter.string(from: currentDateTime))
        """
        let notification = LocalNotification(identifier: UUID().uuidString, title: title, body: body, timeInterval: 2, repeats: false)
        
        await notificationManager.schedule(localNotification: notification)
    }
}




struct CartView_Preview: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
            .environmentObject(ReceiptManager())
    }
}

struct CheckoutButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
    }
}

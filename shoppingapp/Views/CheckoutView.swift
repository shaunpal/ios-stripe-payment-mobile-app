//
//  CheckoutView.swift
//  shoppingapp
//
//  Created by shaun on 13/5/24.
//

import SwiftUI
import Stripe
import StripePaymentSheet
import AVFoundation


struct CheckoutView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var completePayment = false
    @State private var isConfirmingPayment: Bool = false

    @ObservedObject var model = PaymentBackendFlowModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    OrderSummaryView()
                        .environmentObject(cartManager)

                    Spacer()
                    VStack {
                        HStack {
                            Text("Payment Method")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        }
                        .padding()
                        Spacer()
                        Divider()
                            .padding(.horizontal, 10)
                        
                        // paymentFlow
                        VStack {
                            if let paymentSheetFlowController = model.paymentSheetFlowController {
                                PaymentSheet.FlowController.PaymentOptionsButton(
                                    paymentSheetFlowController: paymentSheetFlowController,
                                    onSheetDismissed: model.onOptionsCompletion
                                ) {
                                    ExamplePaymentOptionView(
                                        paymentOptionDisplayData: paymentSheetFlowController.paymentOption)
                                    
                                }
                                Button(action: {
                                    // If you need to update the PaymentIntent's amount, you should do it here and
                                    // set the `isConfirmingPayment` binding after your update completes.
                                    isConfirmingPayment = true
                                }) {
                                    if isConfirmingPayment {
                                        ExampleLoadingView()
                                    } else {
                                        ExamplePaymentButtonView()
                                    }
                                }
                                .paymentConfirmationSheet(
                                    isConfirming: $isConfirmingPayment,
                                    paymentSheetFlowController: paymentSheetFlowController,
                                    onCompletion: model.onCompletion
                                )
                                .disabled(paymentSheetFlowController.paymentOption == nil || isConfirmingPayment)
                                
                            } else {
                                ProgressView()
                                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                            }
                            
                            
                            if let result = model.paymentResult {
                                
                                switch result {
                                case .completed:
                                    VStack(alignment: .center) {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                        Text("Success!")
                                    }
                                    .onAppear {
                                        
                //                                AudioServicesPlaySystemSound(1026)
                                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                                            completePayment = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3, execute: {
                                                cartManager.paymentStatus = true
                                                dismiss()
                                            })
                                        }
                                    
                                case .failed(let error):
                                  Text("Payment failed: \(error.localizedDescription)")
                                        .onAppear {
                                            completePayment = true
                                            dismiss()
                                        }
                                case .canceled:
                                  Text("Payment canceled.")
                                        .onAppear {
                                            completePayment = true
                                            dismiss()
                                        }
                                }
                            }
                        }
                        .onAppear { model.preparePaymentSheet() }
                        
                    }
                    .padding(10)
                    .frame(height: 200, alignment: .topLeading)
                    .frame(maxWidth: .infinity)
                }
                .padding(10)
            }
            .navigationTitle("Payment")
            .toolbar(.hidden, for: .bottomBar)
        }
        
    }
}

#Preview {
    CheckoutView()
        .environmentObject(CartManager())
}

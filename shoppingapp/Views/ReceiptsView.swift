//
//  ReceiptsView.swift
//  shoppingapp
//
//  Created by shaun on 22/5/24.
//

import SwiftUI

struct ReceiptsView: View {
    @EnvironmentObject var receiptManager: ReceiptManager
    
    var body: some View {
        ScrollView {
            VStack {
                if receiptManager.orderReceipts.isEmpty {
                    Text("No Receipts to show")
                        .padding(.top, 300)
                } else {
                    ForEach(receiptManager.orderReceipts, id: \.id) { receipt in
                        ReceiptRow(orderReceipt: receipt)
                            .environmentObject(receiptManager)
                    }
                }
            }
            
        }
    }
}

#Preview {
    ReceiptsView()
        .environmentObject(ReceiptManager())
}

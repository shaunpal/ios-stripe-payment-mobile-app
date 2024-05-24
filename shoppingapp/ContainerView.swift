//
//  ContainerView.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import SwiftUI

struct ContainerView: View {
    
    @State private var isSplashViewPresented = true
    @EnvironmentObject var notificationManager: LocalNotificationManager
    var body: some View {
        if !isSplashViewPresented {
            ContentView()
                .environmentObject(notificationManager)
        } else {
            SplashUIView(isPresented: $isSplashViewPresented)
                .environmentObject(notificationManager)
        }
    }
}

#Preview {
    ContainerView()
        .environmentObject(LocalNotificationManager())
}

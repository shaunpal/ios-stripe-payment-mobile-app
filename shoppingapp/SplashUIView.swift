//
//  SplashUIView.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import SwiftUI

struct SplashUIView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject var notificationManager: LocalNotificationManager
    private let bgColor: Color = Color(red: 246/255,green: 205/255,blue: 125/255)
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 250)
                .background(bgColor)
                .padding()
            
            Button(action: {}) {
                Text("Get Started")
                    .padding()
                    .bold()
                    .font(.title2)
                    .foregroundColor(.orange)
                    .background(.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
    }
}

#Preview {
    SplashUIView(isPresented: .constant(true))
        .environmentObject(LocalNotificationManager())
}

//
//  SideBarView.swift
//  shoppingapp
//
//  Created by shaun on 5/5/24.
//

import SwiftUI

struct SideBarView: View {
    @Binding var isSidebarVisible: Bool
    @Binding var categoryChosen: String
    @State var isCategories = false
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    var bgColor: Color =
    Color(red: 246/255,green: 205/255,blue: 125/255)
    
    var body: some View {
        ZStack(alignment: .top) {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(.black.opacity(0.6))
                .opacity(isSidebarVisible ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
                content
            }
            .edgesIgnoringSafeArea(.all)
        
    }

        var content: some View {
            HStack(alignment: .top) {
                ZStack(alignment: .top) {
                    bgColor
                    MenuChevron
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Divider()
                        VStack(alignment: .leading) {
                            HStack(alignment: .bottom) {
                                Image(systemName: "house")
                                
                                Text("Home")
                            }
                            .padding()
                            .onTapGesture {
                                categoryChosen = ""
                                isSidebarVisible = false
                            }
                            
                            HStack(alignment: .bottom) {
                                Image(systemName: "list.bullet.clipboard")
                                
                                Text("Categories")
                            }
                            .padding()

                            
                            HStack(alignment: .bottom) {
                                Image("shoppingbag")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                
                                Text("Sale")
                            }
                            .padding()
                            .onTapGesture {
                                categoryChosen = "Sales"
                                isSidebarVisible = false
                            }
                        }
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 40)
                }
                .frame(width: sideBarWidth)
                .offset(x: isSidebarVisible ? 0 : -sideBarWidth-100)
                .animation(.default, value: isSidebarVisible)

                Spacer()
            }
        }
    
    
    var MenuChevron: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(bgColor)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: isSidebarVisible ? -18 : -10)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
            
            Image(systemName: "chevron.right")
                .rotationEffect(
                    isSidebarVisible ?
                    Angle(degrees: 180) : Angle(degrees: 0))
                .offset(x: isSidebarVisible ? -4 : 8)
                .foregroundColor(.black)
        }
        .offset(x: sideBarWidth / 2, y: 80)
        .animation(.default, value: isSidebarVisible)
    }
}

#Preview {
    SideBarView(isSidebarVisible: .constant(true), categoryChosen: .constant(""))
}

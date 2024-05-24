//
//  ContentView.swift
//  shoppingapp
//
//  Created by shaun on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        let opaqueBackground = UITabBarAppearance()
        opaqueBackground.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = opaqueBackground
    }
    @StateObject var cartManager = CartManager()
    @StateObject var receiptManager = ReceiptManager()
    
    @State var categoryChosen = ""
    
    @State private var activeTab: Tab = .home
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab ->
        AnimatedTab? in
        return .init(tab: tab)
    }

    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $activeTab){
                
                // Home
                NavigationStack {
                    VStack {
                        ScrollView {
                            VStack {
                                ExploreView()
                                    .environmentObject(cartManager)
                                    .environmentObject(receiptManager)
                                
                                SaleView()
                                    .environmentObject(cartManager)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink(destination: SearchView().environmentObject(cartManager), label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                            })
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink {
                                CartView()
                                    .toolbar(.hidden, for: .tabBar)
                                    .environmentObject(cartManager)
                                    .environmentObject(receiptManager)
                                
                            } label: {
                                CartButton(numberOfProducts: cartManager.products.count)
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
                .tabItem {
                    Label("Menu", systemImage: "house.fill")
                }
               
                
                
                
                // Categories
                NavigationStack {
                    CategoriesView()
                        .environmentObject(cartManager)
                }
                .tabItem {
                    Label("Categories", systemImage: "list.bullet.clipboard")
                }
                
                
                // Sale
                NavigationStack {
                    
                    ProductListView(categoryChosen: .constant("Sales"))
                        .environmentObject(cartManager)
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing){
                                NavigationLink {
                                    SearchView()
                                        .environmentObject(cartManager)
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.black)
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing){
                                NavigationLink {
                                    CartView()
                                        .toolbar(.hidden, for: .tabBar)
                                        .environmentObject(cartManager)
                                        .environmentObject(receiptManager)
                                        
                                } label: {
                                    CartButton(numberOfProducts: cartManager.products.count)
                                        .foregroundColor(.black)
                                }
                                .padding(.bottom, 10)
                            }
                        }
                        .navigationTitle(activeTab.title)
                    
                }
                .tabItem {
                    Label("Sale", systemImage: "percent")
                }
                
                
                // Receipts
                NavigationStack {
                    ReceiptsView()
                        .environmentObject(receiptManager)
                        .navigationTitle("Receipts")
                }
                .tabItem {
                    Label("Receipts", systemImage: "newspaper")
                }
                .badge(receiptManager.orderReceipts.filter({ $0.isOpen == false }).count)
            }
            
        }
        .accentColor(Color.orange)
        
    }
    
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                        .symbolEffect(.bounce.down.byLayer, value: animatedTab.isAnimating)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .foregroundColor(activeTab == tab ? Color.orange : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction){
                            animatedTab.isAnimating = nil
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .tag(tab)
    }
}

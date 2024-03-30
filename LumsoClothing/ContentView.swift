//
//  ContentView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-13.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var cartManager = CartManager() // Create a single instance of CartManager
    @State private var isAppLaunchedBefore = false // Track whether the app has been launched before
    
    var body: some View {
        Group {
            if isAppLaunchedBefore {
                // If the app has been launched before, show the ContentView
                TabView(selection: $selectedTab) {
                    HomeView() // Pass the shared cartManager instance
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(0)
                    
                    ExploreView(cartManager: cartManager) // Pass the shared cartManager instance
                        .tabItem {
                            Label("Explore", systemImage: "magnifyingglass")
                        }
                        .tag(1)
                    
                    CartView(cartManager: cartManager) // Pass the same cartManager instance
                        .tabItem {
                            Label("Cart", systemImage: "cart")
                        }
                        .tag(2)
                    
                    UserView() // Pass the same cartManager instance
                        .tabItem {
                            Label("User", systemImage: "person")
                        }
                        .tag(3)
                }
            } else {
                // If the app is launched for the first time, show the WelcomeView as splash screen
                WelcomeView(isAppLaunchedBefore: $isAppLaunchedBefore)
            }
        }
    }
}


#Preview {
    ContentView()
}

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
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExploreView(cartManager: cartManager) // Pass the shared cartManager instance
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            CartView(cartManager: cartManager) // Pass the same cartManager instance
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}

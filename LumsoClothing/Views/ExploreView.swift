//
//  ExploreView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-18.
//

import SwiftUI

// Define a Clothing struct to hold attributes
struct ExploreView: View {
    @State private var searchString: String = ""
    @State private var filteredItems: [ClothingItem] = []
    @State private var isAscendingOrder: Bool = false
    @State private var isSorted: Bool = false
    @State private var selectedItem: ClothingItem? = nil
    @State private var isModalPresented: Bool = false // New state for the presenting modal
    @ObservedObject var cartManager: CartManager // Injecting CartManager from here
    
    // Sample search items
    let searchItems: [ClothingItem] = [
        ClothingItem(title: "Polo", description: "High-quality polo shirt", colors: ["Red", "Blue", "Green"], sizes: ["S", "M", "L"], price: 29.99, images: ["polo_red", "polo_blue", "polo_green"]),
        ClothingItem(title: "Pants", description: "Comfortable pants", colors: ["Black", "Brown", "Gray"], sizes: ["S", "M", "L"], price: 49.99, images: ["pants_black", "pants_brown", "pants_gray"]),
        ClothingItem(title: "Dresses", description: "Elegant dresses", colors: ["White", "Pink", "Yellow"], sizes: ["S", "M", "L"], price: 59.99, images: ["dress_white", "dress_pink", "dress_yellow"]),
        ClothingItem(title: "Shoes", description: "Stylish shoes", colors: ["Black", "Brown", "Blue"], sizes: ["8", "9", "10"], price: 79.99, images: ["shoes_black", "shoes_brown", "shoes_blue"]),
        ClothingItem(title: "Accessories", description: "Fashion accessories", colors: ["Gold", "Silver", "Rose Gold"], sizes: ["One Size"], price: 19.99, images: ["accessories_gold", "accessories_silver", "accessories_rosegold"])
    ]
    
    var sortedItems: [ClothingItem] {
        if isAscendingOrder {
            return filteredItems.sorted { $0.price < $1.price }
        } else {
            return filteredItems.sorted { $0.price > $1.price }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Explore")
                        Spacer()
                    }
                    SearchArea(searchString: $searchString)
                    
                    HStack {
                        Button(action: {
                            isAscendingOrder.toggle()
                            isSorted = true
                            filterItems()
                        }) {
                            Text("Sort by Price \(isAscendingOrder ? "Low to High" : "High to Low")")
                                .padding()
                                .background(isSorted ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    ScrollView{
                        // Filtered search items
                        SearchItemsView(searchItems: isSorted ? sortedItems : filteredItems, selectedItem: $selectedItem, isModalPresented: $isModalPresented, cartManager: cartManager)
                            .transition(.opacity)
                        
                        Spacer()
                    }
                }
                .padding()
            }
            .onAppear {
                filterItems()
            }
            .onChange(of: searchString) { _ in
                filterItems()
            }
            .navigationTitle("Explore")
        }
        .sheet(isPresented: $isModalPresented, onDismiss: {
            // Reset selected item when modal dismissed
            selectedItem = nil
        }) {
            if let item = selectedItem {
                DetailView(clothingItem: item, cartManager: cartManager)
            }
        }
    }
    
    private func filterItems() {
        if searchString.isEmpty {
            filteredItems = searchItems
        } else {
            filteredItems = searchItems.filter { $0.title.lowercased().contains(searchString.lowercased()) }
        }
    }
}

struct SearchItemsView: View {
    let searchItems: [ClothingItem]
    @Binding var selectedItem: ClothingItem?
    @Binding var isModalPresented: Bool
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Search Items")
                .font(.headline)
                .padding(.bottom, 5)
            
            // To display two columns
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(searchItems) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.blue)
                            .frame(height: 180)
                            .overlay(
                                Text(item.title)
                                    .foregroundColor(Color.white)
                            )
                            .onTapGesture {
                                // Present modal when item tapped
                                selectedItem = item
                                isModalPresented = true
                            }
                        Text("Price: $\(item.price)")
                        Text("Size: \(item.sizes.joined(separator: ", "))")
                    }
                }
            }
        }
        .padding(.top)
    }
}

struct SearchArea: View {
    @Binding var searchString: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchString)
            Spacer()
            Image(systemName: "magnifyingglass")
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        .padding(.top)
    }
}


#Preview {
    let cartManager = CartManager()
    return ExploreView(cartManager: cartManager)
}

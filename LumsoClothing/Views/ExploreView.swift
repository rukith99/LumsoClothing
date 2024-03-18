//
//  ExploreView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-18.
//

import SwiftUI

// Define a Clothing struct to hold attributes
struct Clothing: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let size: String
}

struct ExploreView: View {
    @State private var searchString: String = ""
    @State private var filteredItems: [Clothing] = []
    @State private var isAscendingOrder: Bool = false
    @State private var isSorted: Bool = false
    
    // Sample search items
    let searchItems: [Clothing] = [
        Clothing(name: "Polo", price: 29.99, size: "M"),
        Clothing(name: "Pants", price: 49.99, size: "L"),
        Clothing(name: "Dresses", price: 59.99, size: "S"),
        Clothing(name: "Shoes", price: 79.99, size: "10"),
        Clothing(name: "Accessories", price: 19.99, size: "One Size")
    ]
    
    var sortedItems: [Clothing] {
        if isAscendingOrder {
            return filteredItems.sorted { $0.price < $1.price }
        } else {
            return filteredItems.sorted { $0.price > $1.price }
        }
    }
    
    var body: some View {
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
                    SearchItemsView(searchItems: isSorted ? sortedItems : filteredItems)
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
    }
    
    private func filterItems() {
        if searchString.isEmpty {
            filteredItems = searchItems
        } else {
            filteredItems = searchItems.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    }
}

struct SearchItemsView: View {
    let searchItems: [Clothing]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Search Items")
                .font(.headline)
                .padding(.bottom, 5)
            
            // Display two columns
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(searchItems) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.blue)
                            .frame(height: 180)
                            .overlay(
                                Text(item.name)
                                    .foregroundColor(Color.white)
                            )
                        Text("Price: $\(item.price)")
                        Text("Size: \(item.size)")
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
    ExploreView()
}

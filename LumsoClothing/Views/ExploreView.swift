//
//  ExploreView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-18.
//

import SwiftUI
import Kingfisher


struct ExploreView: View {
    @State private var searchString: String = ""
    @StateObject var clothingViewModel = ClothingViewModel()
    @State private var isAscendingOrder: Bool = false
    @State private var isSorted: Bool = false
    @State private var selectedItem: ClothingItem? = nil
    @ObservedObject var cartManager: CartManager
    
    // Selected category
    @State private var selectedCategory: String? = nil
    
    // Categories
    let categories = ["All", "Tops", "Shorts", "Pants", "Accessories"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    SearchArea(searchString: $searchString)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                    filterItems()
                                }) {
                                    Text(category)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(selectedCategory == category ? Color.blue : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            isAscendingOrder.toggle()
                            isSorted = true
                            filterItems()
                        }) {
                            Text("Sort by Price \(isAscendingOrder ? "Low to High" : "High to Low")")
                                .padding(5)
                                .padding(.horizontal)
                                .background(isSorted ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    ScrollView{
                        // Filtered search items
                        SearchItemsView(searchItems: isSorted ? sortedItems : filteredItems, cartManager: cartManager)
                            .transition(.opacity)
                        
                        Spacer()
                    }
                }
                .padding()
            }
            .onAppear {
                clothingViewModel.fetchData() // Fetching data when view appears
            }
            .onChange(of: searchString) { _ in
                filterItems()
            }
            .navigationTitle("Explore")
        }
        .tint(.black)
    }
    
    private func filterItems() {
        if searchString.isEmpty {
            clothingViewModel.fetchData() // Refetching data when search string is empty
        } else {
            clothingViewModel.clothingItems = clothingViewModel.clothingItems.filter { $0.title.lowercased().contains(searchString.lowercased()) }
        }
    }
    
    var sortedItems: [ClothingItem] {
        if isAscendingOrder {
            return clothingViewModel.clothingItems.sorted { $0.price < $1.price }
        } else {
            return clothingViewModel.clothingItems.sorted { $0.price > $1.price }
        }
    }
    
    var filteredItems: [ClothingItem] {
        if let category = selectedCategory, category != "All" {
            return clothingViewModel.clothingItems.filter { $0.category == category }
        } else {
            return clothingViewModel.clothingItems
        }
    }
}

struct SearchItemsView: View {
    let searchItems: [ClothingItem]
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(searchItems) { item in
                    NavigationLink(destination: DetailView(clothingItem: item, cartManager: cartManager)) {
                        VStack {
                            if let imageUrlString = item.images.first, let imageUrl = URL(string: imageUrlString) {
                                KFImage(imageUrl) // Use KFImage instead of Image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                                    .cornerRadius(20)
                            } else {
                                // Placeholder if image URL is invalid or missing
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 180)
                                    .cornerRadius(20)
                                    .overlay(
                                        Text(item.title)
                                            .foregroundColor(Color.white)
                                    )
                            }
                            HStack{
                                Text("\(item.title)")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack{
                                Text("Rs \(String(format: "%.2f", item.price))")
                                    .padding(.bottom)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            
                        }
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
        .padding(.bottom)
    }
}



#Preview {
    let cartManager = CartManager()
    return ExploreView(cartManager: cartManager)
}

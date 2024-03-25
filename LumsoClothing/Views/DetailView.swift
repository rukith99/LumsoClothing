//
//  DetailView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-25.
//

import SwiftUI

struct DetailView: View {
    var clothingItem: ClothingItem
    @State private var selectedColorIndex = 0
    @ObservedObject var cartManager: CartManager // Injecting CartManager
    
    var selectedColor: String {
        clothingItem.colors[selectedColorIndex]
    }
    
    var selectedImage: String {
        clothingItem.images[selectedColorIndex]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(clothingItem.title)
                .font(.title)
            
            Text(clothingItem.description)
                .font(.body)
                .foregroundColor(.gray)
            
            // Display color options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<clothingItem.colors.count, id: \.self) { index in
                        ColorButton(color: clothingItem.colors[index], isSelected: index == selectedColorIndex, action: {
                            selectedColorIndex = index
                        }, clothingItem: clothingItem) // Pass clothingItem here
                    }
                }
            }
            
            // Display selected image
            Image(selectedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // Display size options
            HStack(spacing: 8) {
                ForEach(clothingItem.sizes, id: \.self) { size in
                    Button(action: {
                        // Handle size selection
                    }) {
                        Text(size)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            
            // Display price
            Text("$\(clothingItem.price)")
                .font(.title)
                .foregroundColor(.green)
            
            Spacer()
            
            // Add to cart button
            Button(action: {
                // Handle adding item to cart
                let newItem = CartItem(title: clothingItem.title, size: clothingItem.sizes[0], color: clothingItem.colors[selectedColorIndex], price: clothingItem.price)
                cartManager.addToCart(item: newItem)
            }) {
                Text("Add to Cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle(Text("Product Detail"), displayMode: .inline)
    }
}

struct ColorButton: View {
    var color: String
    var isSelected: Bool
    var action: () -> Void
    var clothingItem: ClothingItem // Add clothingItem as a parameter
    
    var body: some View {
        Button(action: {
            // Call the action provided
            action()
            
            // Optionally, you can handle adding item to cart here if needed
            let newItem = CartItem(title: clothingItem.title, size: clothingItem.sizes[0], color: color, price: clothingItem.price)
            print("Item added to cart: \(newItem)")
        }) {
            Text(color)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(isSelected ? .white : .black)
                .background(isSelected ? Color.blue : Color.gray)
                .cornerRadius(8)
        }
    }
}

struct ClothingItem: Identifiable {
    var id = UUID() // Add an id property conforming to Identifiable
    var title: String
    var description: String
    var colors: [String]
    var sizes: [String]
    var price: Double
    var images: [String]
}

#Preview {
    let cartManager = CartManager()
    return DetailView(clothingItem: ClothingItem(title: "Sample Item", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", colors: ["Red", "Green", "Blue"], sizes: ["S", "M", "L"], price: 7888, images: ["red_shirt", "green_shirt", "blue_shirt"]), cartManager: cartManager)
}

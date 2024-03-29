//
//  DetailView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-25.
//

import SwiftUI
import Kingfisher


struct DetailView: View {
    var clothingItem: ClothingItem
    @State private var selectedColorIndex = 1
    @State private var selectedSize: String? = nil
    @ObservedObject var cartManager: CartManager
    
    var selectedColor: String {
        clothingItem.colors[selectedColorIndex]
    }
    
    var selectedImage: String {
        clothingItem.images[selectedColorIndex]
    }
    
    private func isSizeSelected(_ size: String) -> Bool {
        return selectedSize == size
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
           
            KFImage(URL(string: selectedImage))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 400)
            HStack{
                Spacer()
                HStack(spacing: 3) {
                    ForEach(0..<clothingItem.colors.count, id: \.self) { index in
                        ColorButton(color: clothingItem.colors[index], isSelected: index == selectedColorIndex) {
                            selectedColorIndex = index
                        }
                    }
                }
                Spacer()

            }
            
            Text(clothingItem.title)
                .font(.title)
            
            Text(clothingItem.description)
                .font(.body)
                .foregroundColor(.gray)
            
           
            
            HStack {
                HStack(spacing: 8) {
                    ForEach(clothingItem.sizes, id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text(size)
                                .padding()
                                .foregroundColor(isSizeSelected(size) ? .white : .black)
                                .background(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 2)
                                        .background(isSizeSelected(size) ? Color.black : Color.clear)
                                )
                                .clipShape(Circle())
                        }
                    }
                }
                Spacer()
                
            }
            
            
            Text("Rs \(String(format: "%.2f", clothingItem.price))")
                .font(.system(size: 30))
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                guard let selectedSize = selectedSize else { return }
                let newItem = CartItem(title: clothingItem.title, size: selectedSize, color: clothingItem.colors[selectedColorIndex], price: clothingItem.price)
                cartManager.addToCart(item: newItem)
            }) {
                Text("Add to Cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(100)
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
    
    var body: some View {
        Button(action: action) {
            VStack {
                Circle()
                    .foregroundColor(Color(color))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: isSelected ? 3 : 0)
                    )
                    .padding(8)
                
            }
           
        }
    }
}

#Preview {
    let cartManager = CartManager()
    let sampleItem = ClothingItem(title: "Sample Item", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", colors: ["red", "green", "blue"], sizes: ["S", "M", "L"], price: 7888, images: ["testImg 3", "testImg 2", "testImg"], dateAdded: Date(), gender: "Male", category: "top")
    return DetailView(clothingItem: sampleItem, cartManager: cartManager)
}

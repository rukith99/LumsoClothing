//
//  CartView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-24.
//

import SwiftUI


class CartManager: ObservableObject {
    @Published var items: [CartItem] = [] {
        didSet {
            saveCartData()
        }
    }
    
    init() {
        loadCartData()
    }
    
    private let cartKey = "CartItems"
    
    private func saveCartData() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: cartKey)
        } catch {
            print("Error saving cart data: \(error.localizedDescription)")
        }
    }
    
    private func loadCartData() {
        guard let data = UserDefaults.standard.data(forKey: cartKey) else { return }
        do {
            items = try JSONDecoder().decode([CartItem].self, from: data)
        } catch {
            print("Error loading cart data: \(error.localizedDescription)")
        }
    }
    
    func addToCart(item: CartItem) {
        items.append(item)
    }
    
    func removeFromCart(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
}

struct CartView: View {
    @ObservedObject var cartManager: CartManager
    
    var totalPrice: Double {
        // Calculate the total price by summing up the prices of all items
        cartManager.items.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(cartManager.items, id: \.title) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.headline)
                        Text("Size: \(item.size)")
                        Text("Color: \(item.color)")
                        Text(String(format: "Price: $%.2f", item.price))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete { indexSet in
                    cartManager.removeFromCart(at: indexSet)
                }
            }
            .navigationBarTitle("Cart")
            
            // Display total price at the bottom
            HStack {
                Spacer()
                Text("Total: $\(totalPrice, specifier: "%.2f")")
                    .font(.headline)
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            // Reload the data when the view appears
            // This ensures that the view updates when the data changes
            DispatchQueue.main.async {
                cartManager.objectWillChange.send()
            }
            
            print("Items in the cart:")
            for item in cartManager.items {
                print("- \(item.title), Size: \(item.size), Color: \(item.color), Price: \(item.price)")
            }
        }
    }
}


#Preview {
    let cartManager = CartManager()
           cartManager.addToCart(item: CartItem(title: "Sample Item", size: "M", color: "Red", price: 29.99))
           return CartView(cartManager: cartManager)
}

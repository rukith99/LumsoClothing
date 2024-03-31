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
    
    func removeAllItems() {
            items.removeAll()
        }
}


struct CartView: View {
    @ObservedObject var cartManager: CartManager
    
    var totalPrice: Double {
        cartManager.items.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        NavigationView { // Embedding CartView in a NavigationView
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
                .navigationBarTitle("My Cart")
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Total: Rs \(totalPrice, specifier: "%.2f")")
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    NavigationLink(destination: CheckoutView(cartManager: cartManager, totalPrice: Int(totalPrice))) { // Passing cartManager and totalPrice
                        Text("Go to Checkout")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom)
                            .padding(.horizontal)
                    }
                }
                .background(Color.black)
                .foregroundColor(.white)
            }
            .onAppear {
                
                    cartManager.objectWillChange.send()
               
                
                print("Items in the cart:")
                for item in cartManager.items {
                    print("- \(item.title), Size: \(item.size), Color: \(item.color), Price: \(item.price)")
                }
            }
        }
    }
}



#Preview {
    let cartManager = CartManager()
           cartManager.addToCart(item: CartItem(title: "Sample Item", size: "M", color: "Red", price: 29.99))
           return CartView(cartManager: cartManager)
}

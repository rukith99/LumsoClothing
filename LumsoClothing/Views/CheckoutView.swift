//
//  CheckoutView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-31.
//

import SwiftUI


struct CheckoutView: View {
    @State private var fullName = ""
    @State private var address = ""
    @State private var cardNumber = ""
    @State private var exp = ""
    @State private var vcc = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var showingAlert = false
    @State private var paymentCompleted = false
    @ObservedObject var cartManager: CartManager

    let totalPrice: Int
    
    var body: some View {
        VStack {
            VStack(alignment: .leading
            ){
                Text("Customer Delivery Details")
                    .font(.system(size: 20))
                    .padding(.vertical, 8)
                TextField("Full Name", text: $fullName)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                TextField("Address", text: $address)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                TextField("Email", text: $email)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                TextField("Phone", text: $phone)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.numberPad)
                    .padding(.bottom,24)
                
                Text("Payment Details")
                    .font(.system(size: 20))
                    .padding(.vertical, 8)
                TextField("Card Number", text: $cardNumber)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                HStack{
                    TextField("Expr. Date", text: $exp)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    TextField("CVV", text: $vcc)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                }
            }
            
            
            
            Spacer()
            HStack{
            Text("Total Price: Rs. \(totalPrice)")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            }
            Button(action: {
                               
                cartManager.removeAllItems()
                                // Show payment done alert
                                self.showingAlert = true
                                // Set paymentCompleted to true
                                self.paymentCompleted = true
                            }, label: {
                                VStack {
                                    Text("Pay Now")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(100)
                            })
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Payment done"), message: nil, dismissButton: .default(Text("OK")))
                            }
                            
                            // Navigation link to go back to HomeView upon payment completion
                            NavigationLink(
                                destination: HomeView(),
                                isActive: $paymentCompleted,
                                label: { EmptyView() }
                            )
                            .hidden() // Hide the link, it will navigate programmatically
        }
        .padding()
        .navigationBarTitle("Checkout")
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Payment done ✅\n Thank you !"), message: nil, dismissButton: .default(Text("OK")))
                }
    }
}


#Preview {
    CheckoutView(cartManager: CartManager(), totalPrice: 8900)
}

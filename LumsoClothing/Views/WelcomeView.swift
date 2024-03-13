//
//  WelcomeView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-14.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("AppBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("LumSo")
                    .foregroundColor(.white)
                    .font(.system(size: 55,weight: .bold))
                Text("Lumiere & Sombre")
                    .foregroundColor(.white)
                Spacer()
                
                Text("Embrace the Contrast \nWhere Light and Dark \nMeet in Style")
                    .foregroundColor(.white)
                    .font(.system(size: 27,weight: .regular))
                    .multilineTextAlignment(.center)
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 40)
                            .foregroundColor(.clear)
                            .shadow(radius: 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 2.5)
                            )
                        
                        Text("Get Started")
                            .foregroundColor(.white)
                            .font(.system(size: 17,weight: .bold))
                        
                    }
                })
            }
            .padding(.vertical,100)
            .padding(.horizontal)
            
        }
    }
}



#Preview {
    WelcomeView()
}

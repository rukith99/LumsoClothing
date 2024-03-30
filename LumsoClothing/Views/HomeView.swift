//
//  HomeView.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-15.
//

import SwiftUI


// Main View
struct HomeView: View {
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                Spacer()
                RoundedRectangle(cornerRadius: 25.0)
                    .padding(.top , -80)
                    .ignoresSafeArea()
                    .colorInvert()
                    .overlay {
                        VStack{
                            CategoryView()
                            TrendingView()
                            Spacer()
                        }
                        .padding(.top , -60)
                        
                    }
            }
        }
    }
}

// Sub View
struct HeaderView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                VStack{
                    SearchItem()

                    HStack {
                        VStack(alignment: .leading){
                            Text("New")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .opacity(0.6)

                            Text("Winter")
                                .font(.system(size: 38))
                                .fontWeight(.bold)

                            Text("Collection")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                            HStack{
                                Group{
                                    Circle()
                                        .colorInvert()
                                    Circle()
                                    Circle()
                                    
                                }
                                .frame(width: 11 ,height: 11)
                                .colorInvert()
                            }
                        }
                        .padding(.leading , 30)
                        Spacer()
                    }
                }

            }
        }
        .frame(height: 300)
        .background(Color.black)
    }
}

struct CategoryView: View {
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Categories")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.leading,30)
                    ScrollView(.horizontal,  showsIndicators: false){
                        HStack(spacing: 15){
                            CategoryItem(imageName: "Men")
                            CategoryItem(imageName: "Women")
                            CategoryItem(imageName: "Kids")
                            CategoryItem(imageName: "Shoes")
                        }
                        .padding(.leading)
                    }
                }
            }
            .padding(0)
            
        }
    }
}


struct TrendingView: View {
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Trending")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.leading,30)
                    ScrollView(.horizontal,  showsIndicators: false){
                        HStack(spacing : 15){
                            TrendingItem(imageName: "Trending01", itemName: "Basic B&W Stipes top", price: "2500.00")
                            TrendingItem(imageName: "Trending02", itemName: "Men Oversized Hoodie", price: "3900.00")
                            TrendingItem(imageName: "Trending03", itemName: "Men Jogging Pants", price: "3500.00")
                            TrendingItem(imageName: "Trending04", itemName: "Basic Plain T-Shirt", price: "1100.00")
                         
                            
                        }
                        .padding(.leading)
                        
                    }
                }
                
                
            }
            .padding(0)
            
        }
    }
}


// Search bar
struct SearchItem: View{
    var body: some View{
            HStack {
                Text("Search Item here...")
                Spacer()
                Image(systemName: "magnifyingglass")
            }
            .opacity(0.5)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.7))
            .cornerRadius(10)
            .padding()
            .padding(.horizontal)

            

       
    }
}

import SwiftUI

struct CategoryItem: View {
    
    @State var imageName : String
    
    var body: some View {
        ZStack {
            // Adding background Image
            VStack{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 100)
                Text(imageName)
                    .padding(.top,5)
                    .fontWeight(.semibold)
                    .opacity(0.7)
            }
            
            
            .padding(10)
        }

    }
}


struct TrendingItem: View {
    @State var imageName : String
    @State var itemName : String
    @State var price : String



    var body: some View{
        VStack(alignment : .leading){
            VStack{
                
            }
            .frame(width: 150, height: 180)
            .background(Color.gray)
            .cornerRadius(15)
            Text(itemName)
                .lineLimit(2)
                .padding(.trailing)
                .frame(width: 150)
                .opacity(0.6)
            Text("Rs.\(price)")
                .font(.system(size: 20))
                .bold()
            
            
        }
    }
}


#Preview {
    HomeView()
}

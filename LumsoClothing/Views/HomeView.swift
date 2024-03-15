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

// Sub Views
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
                            Text("Winter")
                            Text("Collection")
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
                        .padding(.horizontal)
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
                    ScrollView(.horizontal,  showsIndicators: false){
                        HStack{
                            CategoryItem()
                            CategoryItem()
                            CategoryItem()
                            CategoryItem()
                            
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
                    ScrollView(.horizontal,  showsIndicators: false){
                        HStack(spacing : 15){
                            TrendingItem()
                            TrendingItem()
                            TrendingItem()
                            TrendingItem()
                            
                        }
                        .padding(.leading)
                        
                    }
                }
                
                
            }
            .padding(0)
            
        }
    }
}


//Components
struct SearchItem: View{
    var body: some View{
            HStack {
                Text("Search Item here...")
                Spacer()
                Image(systemName: "magnifyingglass")
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.7))
            .cornerRadius(10)
            .padding()
            

       
    }
}

struct CategoryItem: View {
    var body: some View{
        VStack(alignment : .center){
            Circle()
                .frame(height: 100)
            Text("Women")
            
        }
    }
}

struct TrendingItem: View {
    var body: some View{
        VStack(alignment : .leading){
            VStack{
                
            }
            .frame(width: 150, height: 180)
            .background(Color.gray)
            .cornerRadius(15)
            Text("Women")
            Text("Rs 12000")
            
            
            
        }
    }
}



#Preview {
    HomeView()
}

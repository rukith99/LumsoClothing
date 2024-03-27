//
//  ClothingViewModel.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-27.
//

import Foundation
import Alamofire

class ClothingViewModel: ObservableObject {
    @Published var clothingItems = [ClothingItem]()

    func fetchData() {
        AF.request("https://product-api-7xv7.onrender.com/product").responseJSON { response in
            switch response.result {
            case .success(let data):
                if let jsonArray = data as? [[String: Any]] {
                    self.clothingItems = jsonArray.map { item in
                        let id = UUID()
                        let title = item["title"] as? String ?? ""
                        let description = item["description"] as? String ?? ""
                        let colors = item["colors"] as? [String] ?? []
                        let sizes = item["sizes"] as? [String] ?? []
                        let price = item["price"] as? Double ?? 0.0
                        let images = item["images"] as? [String] ?? []
                        let dateString = item["dateAdded"] as? String ?? ""
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let dateAdded = dateFormatter.date(from: dateString) ?? Date()
                        let gender = item["gender"] as? String ?? ""
                        
                        return ClothingItem(id: id, title: title, description: description, colors: colors, sizes: sizes, price: price, images: images, dateAdded: dateAdded, gender: gender)
                    }
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

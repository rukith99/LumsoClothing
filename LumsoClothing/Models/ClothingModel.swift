//
//  ClothingModel.swift
//  LumsoClothing
//
//  Created by Rukith Ranasinghe on 2024-03-28.
//

import Foundation

struct ClothingItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var colors: [String]
    var sizes: [String]
    var price: Double
    var images: [String]
    var dateAdded: Date
    var gender: String
}

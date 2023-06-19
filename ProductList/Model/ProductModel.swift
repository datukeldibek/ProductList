//
//  ProductModel.swift
//  ProductList
//
//  Created by Jarae on 19/6/23.
//

import Foundation
// MARK: - Product
struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - ProductElement
struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let rating: Double
    let brand, category: String
    let thumbnail: String
}

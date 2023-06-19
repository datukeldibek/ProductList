//
//  NetworkService.swift
//  ProductList
//
//  Created by Jarae on 19/6/23.
//

import Foundation
class NetworkService {
    func requestProducts() async throws -> Products {
        let request = URLRequest(url: Constants.API.baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

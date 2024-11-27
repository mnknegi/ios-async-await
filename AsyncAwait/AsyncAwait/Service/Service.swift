//
//  Networking.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 26/10/24.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case decodingError
}

final class Service {

    func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw NetworkError.badResponse
        }

        guard let decoder = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }

        return decoder
    }
}

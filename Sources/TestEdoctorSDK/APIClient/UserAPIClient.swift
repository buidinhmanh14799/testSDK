//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 07/08/2023.
//

import Foundation

public struct UserAPIClient {
    private let baseURL: URL
    private let accessToken: String
    
    public init(baseURL: URL, accessToken: String) {
        self.baseURL = baseURL
        self.accessToken = accessToken
    }
    
    public func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("user") // Replace "user" with your API endpoint
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Set AccessToken in the request header
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    public func fetchUser() async throws -> User {
        let url = baseURL.appendingPathComponent("user")
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(User.self, from: data)
        
        return decoded
    }
}

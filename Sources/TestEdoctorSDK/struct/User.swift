//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 07/08/2023.
//

import Foundation

public struct User: Codable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

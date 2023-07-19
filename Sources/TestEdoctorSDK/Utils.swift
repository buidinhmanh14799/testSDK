//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 19/07/2023.
//
import Foundation

let defaultURL = "https://edoctor.io/pk/chat-room"


func createURL(url: String?, endpoint: String) -> URL {
    let url = URL(string: url ?? defaultURL + endpoint)!
    return url
}

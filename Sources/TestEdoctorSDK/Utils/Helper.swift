//
//  Helper.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 16/08/2023.
//

import Foundation

public func extractTokenFromData(deviceToken:Data) -> String {
    let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    return token.uppercased();
}

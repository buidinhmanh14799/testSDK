//
//  UserData.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 16/08/2023.
//

import Foundation

public class VoIpTokenManager {
    private static let voIpTokenKey = "voIpTokenKey"
    
    static func saveToken(voIpToken: Data) {
        UserDefaults.standard.set(voIpToken, forKey: voIpTokenKey)
    }
    
    static func getToken() -> Data? {
        if let data = UserDefaults.standard.data(forKey: voIpTokenKey) {
            return UserDefaults.standard.data(forKey: voIpTokenKey)
        }
        return nil
    }
    
    static func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: voIpTokenKey)
    }
}

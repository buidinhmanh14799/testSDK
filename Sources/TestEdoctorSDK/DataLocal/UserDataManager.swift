//
//  UserData.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 16/08/2023.
//

import Foundation

public class UserDataManager {
    private static let userInfoKey = "userInfoKey"
    
    static func saveUserInfo(userInfo: UserInfo) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(userInfo)
            UserDefaults.standard.set(data, forKey: userInfoKey)
        } catch {
            print("Lỗi khi lưu dữ liệu: \(error)")
        }
    }
    
    static func getUserInfo() -> UserInfo? {
        if let data = UserDefaults.standard.data(forKey: userInfoKey) {
            do {
                let decoder = PropertyListDecoder()
                let userInfo = try decoder.decode(UserInfo.self, from: data)
                return userInfo
            } catch {
                print("Lỗi khi đọc dữ liệu: \(error)")
            }
        }
        return nil
    }
    
    static func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: userInfoKey)
    }
}

struct UserInfo: Codable {
    var appId: String
    var userId: String
    var accessToken: String
    var voIpToken: Data?
}

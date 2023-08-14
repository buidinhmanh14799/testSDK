//
//  Funtion.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 09/08/2023.
//

import Foundation
import SwiftUI
import SendBirdCalls

public func startVideoCallLayout(calleeId: String) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    SendBirdCallManager.shared.makeCall(calleeId: calleeId)
    
    
    let startCallLayout = StartCallLayout()
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: startCallLayout)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}


public func inCommingCall(call: DirectCall) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    DirectCallManager.shared.setDirectCall(directCall: call)
    DirectCallManager.shared.callStatus = .comming
    
    let inCommingCall = IncommingCall()
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: inCommingCall)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}

public func logOut() {
    SendBirdCall.removeAllDelegates()
    SendBirdCall.deauthenticate { error in
            if let error = error {
                // Xử lý khi có lỗi đăng xuất
                print("Error logging out from SendBird Calls: \(error.localizedDescription)")
            } else {
                // Xử lý khi đăng xuất thành công
                print("Logged out from SendBird Calls successfully")
            }
        }
}

public func logInSendbird() {
    SendBirdCallManager.shared.login(userId: "134", accessToken: "abd9a6f14e53e60da58d7bcd04da19e6bd78612c")
}





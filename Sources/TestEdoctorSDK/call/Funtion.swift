//
//  Funtion.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 09/08/2023.
//

import Foundation
import SwiftUI
import SendBirdCalls

public func startVideoCallLayout(calleeId: String, isVideoCall: Bool) {
    requestPermissions()
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    SendBirdCallManager.shared.makeCall(calleeId: calleeId, isVideoCall: isVideoCall)
    
    
    let startCallScreen = StartCallScreen()
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: startCallScreen)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}


public func inCommingCall(call: DirectCall, isPushNoti: Bool?) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    DirectCallManager.shared.setDirectCall(directCall: call)
    if isPushNoti != true {
        CallStatusManager.shared.setCallStatus(value: .comming)
    }
    
    let inCommingCall = IncommingCallScreen()
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: inCommingCall)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}

public func logOut() {
    SendBirdCallManager.shared.removeVoIPPushToken()
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
    UserDataManager.deleteUserInfo()
}

public func logInSendbird() {
    SendBirdCallManager.shared.login(userId: "manh", accessToken: "d02c6f8cc55c77ea179a70c800853c98b60a03a7")
}

public func logInSendbird(userId: String, accessToken: String) {
    
    
    SendBirdCallManager.shared.login(userId: userId, accessToken: accessToken)
}





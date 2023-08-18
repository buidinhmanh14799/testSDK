//
//  sdkMain.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 08/08/2023.
//

import SwiftUI
import WebKit
import SendBirdCalls

public func openWebView(withURL urlString: String) {


    if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            let customWebViewController = CustomWebViewController(urlString: urlString)
            topViewController.present(customWebViewController, animated: true, completion: nil)
   }
}

public func showFullScreenWebView(withURL urlString: String) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    let fullScreenWebView = FullScreenWebView(urlString: urlString)
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: fullScreenWebView)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}

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
    SendBirdCallManager.shared.login(userId: "134", accessToken: "abd9a6f14e53e60da58d7bcd04da19e6bd78612c")
}

public func logInSendbird(userId: String, accessToken: String) {
    
    
    SendBirdCallManager.shared.login(userId: userId, accessToken: accessToken)
}


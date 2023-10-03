//
//  sdkMain.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 08/08/2023.
//

import SwiftUI
import WebKit
import SafariServices
import Foundation
import SendBirdCalls

public func openModalWebView(currentViewController: UIViewController? = nil, withURL urlString: String? = nil) {
    let customWebViewController = CustomWebViewController(urlString: urlString ?? urlDefault)
    if (currentViewController != nil) {
        currentViewController!.present(customWebViewController, animated: true)
    } else if let currentViewController2 = UIApplication.shared.windows.first?.rootViewController {
            currentViewController2.present(customWebViewController, animated: true, completion: nil)
    }
}

public func openWebViewTest() {
    let webview = WebViewController(urlString: urlDefault, onClose: nil)
    webview.modalPresentationStyle = .fullScreen

    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        currentViewController.present(webview, animated: true)
    }
    

}

public func openWebView(currentViewController: UIViewController? = nil, withURL urlString: String? = nil) {

    let fullScreenWebView = FullScreenWebView(urlString: urlString ?? urlDefault)
    

    let hostingController = UIHostingController(rootView: fullScreenWebView)
    hostingController.modalPresentationStyle = .fullScreen

    if currentViewController != nil {
        currentViewController!.present(hostingController, animated: true, completion: nil)
    } else if let currentViewController2 = UIApplication.shared.windows.first?.rootViewController {
        currentViewController2.present(hostingController, animated: true, completion: nil)
    }
}

public func requestPermission() {
    requestPermissions()
}

public func logOutSendBird() {
    SendBirdCallManager.shared.removeVoIPPushToken()
    SendBirdCall.removeAllDelegates()
    SendBirdCall.deauthenticate { error in
            if let error = error {
                print("Error logging out from SendBird Calls: \(error.localizedDescription)")
            } else {
                print("Logged out from SendBird Calls successfully")
            }
        }
    UserDataManager.deleteUserInfo()
}

public func logInSendBird(userId: String, accessToken: String) {
    SendBirdCallManager.shared.login(userId: userId, accessToken: accessToken)
}

public func configAppId(appId: String) {
    SendBirdCallManager.shared.configure(appId: appId)
}

public func configAppIdAndLogin(appId: String, userId: String, accessToken: String) {
    SendBirdCallManager.shared.configure(appId: appId, userId: userId, accessToken: accessToken)
}

public func startCall(userId: String, isVideoCall: Bool) {
    startVideoCallLayout(calleeId: userId, isVideoCall: isVideoCall)
}

public func addDirectCallSounds(dialingName: String? = nil, reconnectingName: String? = nil, reconnectedName: String? = nil) {
    // SendBirdCall.setDirectCallSound("Ringing.mp3", forKey: .ringing)
    if (dialingName != nil) {
        SendBirdCall.addDirectCallSound("Dialing.mp3", forType: .dialing)
    }

    if (reconnectingName != nil) {
        SendBirdCall.addDirectCallSound("ConnectionLost.mp3", forType: .reconnecting)
    }

    if (reconnectedName != nil) {
        SendBirdCall.addDirectCallSound("ConnectionRestored.mp3", forType: .reconnected)
    }

    // If you want to remove added DirectCall sounds,
    // Use `SendBirdCall.removeDirectCallSound(forType:)`
}

@objc public class DlvnSdk: NSObject {
    @objc public func openWebViewOC(currentViewController: UIViewController? = nil) {
        openWebView(currentViewController: currentViewController)
    }

    @objc public func openModalWebViewOC(currentViewController: UIViewController? = nil) {
        openModalWebView(currentViewController: currentViewController)
    }

    @objc public func sampleFuncOC(data: String) -> String{
         return "data của bạn gửi là \(data)"
    }

    @objc public func requestPermissionOC() {
        requestPermission()
    }

    @objc public func logOutSendBirdOC() {
        logOutSendBird()
    }

    @objc public func LogInSendBirdOC(userId: String, accessToken: String) {
        logInSendBird(userId: userId, accessToken: accessToken)
    }

    @objc public func ConfigAppIdOC(appId: String) {
        SendBirdCallManager.shared.configure(appId: appId)
    }

    @objc public func ConfigAppIdAndLoginOC(appId: String, userId: String, accessToken: String) {
        SendBirdCallManager.shared.configure(appId: appId, userId: userId, accessToken: accessToken)
    }

    @objc public func addDirectCallSoundsOC(dialingName: String? = nil, reconnectingName: String? = nil, reconnectedName: String? = nil) {
        addDirectCallSounds(dialingName: dialingName, reconnectingName: reconnectingName, reconnectedName: reconnectedName)
    }

    @objc public func startCall(userId: String, isVideoCall: Bool) {
        startVideoCallLayout(calleeId: userId, isVideoCall: isVideoCall)
    }

}


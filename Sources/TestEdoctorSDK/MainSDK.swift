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
import AVFoundation
import Photos


public func openWebView(currentViewController: UIViewController? = nil, withURL urlString: String? = nil) {

    let webview = WebViewController(urlString: urlString ?? urlDefault, onClose: nil)
    webview.modalPresentationStyle = .fullScreen
    
    if currentViewController != nil {
        currentViewController!.present(webview, animated: true)
    } else if let currentViewController2 = UIApplication.shared.windows.first?.rootViewController {
        currentViewController2.present(webview, animated: true)
    }
}



public func requestPermissions() {
    requestPhotoPermission()
    requestCameraPermission()

}

public func requestCameraPermission() {
    AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
            print("Camera permission granted.")
        } else {
            print("Camera permission denied.")
        }
    }
}

public func requestPhotoPermission() {
    print("vao")
    PHPhotoLibrary.requestAuthorization { status in
        switch status {
        case .authorized:
            print("authorized")
        case .denied, .restricted:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        @unknown default:
            print("default")
            break
        }
    }
}




@objc public class DlvnSdk: NSObject {
    @objc public func openWebViewOC(currentViewController: UIViewController? = nil, withURL urlString: String? = nil) {
        openWebView(currentViewController: currentViewController, withURL: urlString)
    }
    
    @objc public func requestPermissions() {
        requestCameraPermission()
    }
    
}


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

public func openWebView(currentViewController: UIViewController? = nil, withURL urlString: String) {
    let customWebViewController = CustomWebViewController(urlString: urlString)
    if (currentViewController != nil) {
        currentViewController!.present(customWebViewController, animated: true)
    } else if let currentViewController2 = UIApplication.shared.windows.first?.rootViewController {
            currentViewController2.present(customWebViewController, animated: true, completion: nil)
    }
}

public func showFullScreenWebView(currentViewController: UIViewController? = nil, withURL urlString: String) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    let fullScreenWebView = FullScreenWebView(urlString: urlString)
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: fullScreenWebView)
    
    // Hiển thị UIHostingController fullscreen
    if currentViewController != nil {
        currentViewController!.present(hostingController, animated: true, completion: nil)
    } else if let currentViewController2 = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController2.present(hostingController, animated: true, completion: nil)
    }
}


import SwiftUI
import WebKit


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


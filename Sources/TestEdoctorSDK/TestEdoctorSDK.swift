import SwiftUI
import WebKit


public func openWebView(withURL urlString: String) {
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        return
    }

    if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            let customWebViewController = CustomWebViewController(urlString: urlString)
            topViewController.present(customWebViewController, animated: true, completion: nil)
   }
}

func showFullScreenWebView(urlString: String) {
    // Tạo một SwiftUI View chứa WebView và nút "Close"
    let fullScreenWebView = FullScreenWebView(isPresented: .constant(true), urlString: urlString)
    
    // Tạo một UIHostingController chứa fullScreenWebView
    let hostingController = UIHostingController(rootView: fullScreenWebView)
    
    // Hiển thị UIHostingController fullscreen
    if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
        hostingController.modalPresentationStyle = .fullScreen
        currentViewController.present(hostingController, animated: true, completion: nil)
    }
}


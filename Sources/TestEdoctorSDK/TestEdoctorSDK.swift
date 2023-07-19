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


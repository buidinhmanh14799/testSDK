import SwiftUI
import WebKit


public class TestEdoctorSDK {
    public static func openWebView(withURL urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }

        let webView = WKWebView()
        let viewController = UIViewController()
        viewController.view = webView
        viewController.modalPresentationStyle = .fullScreen

        let navigationController = UINavigationController(rootViewController: viewController)

        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            topViewController.present(navigationController, animated: true) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
}


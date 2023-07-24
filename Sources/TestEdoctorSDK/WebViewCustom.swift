import UIKit
import WebKit

class CustomWebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var urlString: String
    var activityIndicator: UIActivityIndicatorView!

    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)

        // Khởi tạo và cấu hình activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // MARK: WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Bắt đầu load trang web, hiển thị activity indicator
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Load trang web thành công, ẩn activity indicator
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Lỗi load trang web, ẩn activity indicator
        activityIndicator.stopAnimating()
    }
}



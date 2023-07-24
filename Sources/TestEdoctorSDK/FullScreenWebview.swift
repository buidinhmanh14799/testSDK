import SwiftUI
import WebKit

struct FullScreenWebView: View {
    @Environment(\.presentationMode) var presentationMode
    let urlString: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            
            WebView(urlString: urlString)
                .edgesIgnoringSafeArea(.all)
            
            Spacer()
        }
        .onDisappear {
            // Đóng hosting controller khi SwiftUI view biến mất
            if let presentingViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                presentingViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}


struct WebView: UIViewRepresentable {
    let urlString: String
    @State private var isLoading = true // Thêm State để theo dõi trạng thái tải trang
    
    func makeUIView(context: Context) -> UIView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        // Tạo UIActivityIndicatorView và điều khiển hiển thị dựa vào trạng thái isLoading
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        
        // Đưa UIActivityIndicatorView lên trên WKWebView
        let stackView = UIStackView(arrangedSubviews: [webView, activityIndicator])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
        
        return webView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Không cần thực hiện gì trong updateUIView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Khi tải trang xong, ẩn spinner bằng cách cập nhật trạng thái isLoading
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            // Xử lý lỗi tải trang ở đây nếu cần
            print("Web loading failed with error: \(error.localizedDescription)")
            parent.isLoading = false
        }
    }
}

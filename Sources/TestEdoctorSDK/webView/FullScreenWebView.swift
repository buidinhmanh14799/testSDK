import SwiftUI
import WebKit

struct FullScreenWebView: View {
    @Environment(\.presentationMode) var presentationMode
    let urlString: String
    
    var body: some View {
        WebViewLayout(onClose: onClose, urlString: urlString)
            .edgesIgnoringSafeArea(.bottom)
        .onDisappear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let currentViewController = windowScene.windows.first?.rootViewController {
                currentViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func onClose () {
        presentationMode.wrappedValue.dismiss()
    }
}

struct WebViewLayout: View, Equatable {
    static func == (lhs: WebViewLayout, rhs: WebViewLayout) -> Bool {
        return true
    }
    
    let onClose: (() -> Void)
    let urlString: String
    private let webView = MyWebView()
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    onClose()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 24))
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                }
                .padding()
                Spacer()
                VStack {
                    Text("DNVL")
                        .font(
                        Font.custom("Mulish", size: 16)
                        .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 161, alignment: .top)
                    Text("\(urlString)")
                        .font(Font.custom("Mulish", size: 10))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.55, green: 0.56, blue: 0.62))
                        .frame(width: 191, alignment: .top)
                }
                Spacer()
                
                Button(action: {
                    isLoading = true
                    webView.reload()
                }) {
                    Image(systemName: "goforward")
                        .font(.system(size: 20))
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .rotationEffect(.degrees(50))
                }.padding()
                
            }.padding(.top, -15)
            ZStack {

                WebView(webView: webView, urlString: urlString, isLoading: $isLoading).padding(.top, -10)
                if isLoading {
                    if #available(iOS 14.0, *) {
                        ProgressView("Đang tải...").padding()
                    } else {
                        Text("Đang tải...").padding().foregroundColor(.gray)
                    }
                }
            }

        }
    }
}

struct WebView: UIViewRepresentable {
    var webView: MyWebView
    var urlString: String
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if urlString != "" {
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
//            request.cachePolicy = .reloadIgnoringLocalCacheData
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // Xử lý các sự kiện liên quan đến quá trình tải WebView ở đây
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false // Ẩn activityIndicator khi tải hoàn thành
            
            webView.evaluateJavaScript("javascript:window.sessionStorage.setItem('manh', '{\"company\":\"DLVN\", \"partnerid\":\"123sd\"}')")
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false // Ẩn activityIndicator nếu có lỗi xảy ra
        }
    }
}

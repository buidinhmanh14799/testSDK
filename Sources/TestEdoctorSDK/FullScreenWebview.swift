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
    
    func makeUIView(context: Context) -> WKWebView {
        let webView =
        if let url = URL(string: urlString) {
            CustomWebViewController(urlString: url)
        }
        return null
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Không cần thực hiện gì trong updateUIView
    }
}

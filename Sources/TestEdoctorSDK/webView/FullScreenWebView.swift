import SwiftUI
import WebKit

struct FullScreenWebView: View {
    @Environment(\.presentationMode) var presentationMode
    let urlString: String
    private let webView = WKWebView()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
                    Text("BTH")
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
                    webView.reload()
                }) {
                    Image(systemName: "goforward")
                        .font(.system(size: 20))
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                }.padding()
                
            }.padding(.top, 30)
            
            WebView(urlString: urlString, webView: webView)
                .edgesIgnoringSafeArea(.all)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
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
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Không cần thực hiện gì trong updateUIView
    }
}

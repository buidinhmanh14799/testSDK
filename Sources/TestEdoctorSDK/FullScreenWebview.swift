//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 24/07/2023.
//

import SwiftUI
import WebKit

struct FullScreenWebView: View {
    @State private var isPresented: Bool = true
    let urlString: String
    
    var body: some View {
        Group {
            if isPresented {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented = false
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
                .transition(.move(edge: .bottom))
            }
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
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Không cần thực hiện gì trong updateUIView
    }
}

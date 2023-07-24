//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 24/07/2023.
//

import SwiftUI
import WebKit

struct FullScreenWebView: View {
    @Binding var isPresented: Bool
    let urlString: String
    
    var body: some View {
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

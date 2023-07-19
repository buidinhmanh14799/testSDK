//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 19/07/2023.
//
import SwiftUI
import WebKit

struct WebViewCustom: UIViewRepresentable {
    let url: String?
    let token: String?
    let userName: String?
    
    init(url: String = defaultURL, token: String? = nil, userName: String? = nil) {
        self.url = url
        self.token = token
        self.userName = userName
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        let endpoint = "/token?=\(String(describing: token))/userName?=\(String(describing: userName))"
        let urlResult = createURL(url: url, endpoint: endpoint)
        let webView = WKWebView()
        
        let request = URLRequest(url: urlResult)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
}

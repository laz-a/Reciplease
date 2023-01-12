//
//  WebView.swift
//  Reciplease
//
//  Created by laz on 24/12/2022.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let navDelegate = WebViewNavDelegate()
        let webview = WKWebView()
        webview.navigationDelegate = navDelegate
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

class WebViewNavDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinishNavigation")
    }
        
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webviewDidCommit")
    }
}

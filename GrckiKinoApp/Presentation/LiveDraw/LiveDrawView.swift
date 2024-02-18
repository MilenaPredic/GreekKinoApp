//
//  LiveDrawView.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import SwiftUI
import WebKit

struct LiveDrawView: View {
    var body: some View {
        VStack{
            WebView(url: URL(string: WebViewConstants.webViewUrl)!)
                .edgesIgnoringSafeArea(.all)
            Spacer()
        }.blackBackground()
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    LiveDrawView()
}

import SwiftUI
import WebKit

public struct TestEdoctorSDK {
    public static func openWebView(withURL url: String) -> some View {
        WebViewCustom(url: url)
    }
}



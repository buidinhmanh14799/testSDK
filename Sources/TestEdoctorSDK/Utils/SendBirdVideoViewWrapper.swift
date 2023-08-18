//
//  SendBirdVideoViewWrapper.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 14/08/2023.
//

import SwiftUI
import SendBirdCalls

struct SendBirdVideoViewWrapper: UIViewRepresentable {
    let sendBirdVideoView: SendBirdVideoView

    func makeUIView(context: Context) -> UIView {
        return sendBirdVideoView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Không cần cập nhật gì trong trường hợp này
    }
}


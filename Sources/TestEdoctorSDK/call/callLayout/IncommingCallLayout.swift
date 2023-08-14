//
//  test.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 11/08/2023.
//

import SwiftUI

struct IncommingCallLayout: View {
    @EnvironmentObject var directCallManager : DirectCallManager
    @State private var isMuted = false
    @State private var isCamera = false
    
    var onClose: (() -> Void)
    var body: some View {
        VStack {
            Spacer()
            
            Text("Incoming Call")
                .font(.headline)
            
            Spacer()
            
            Circle()
                .frame(width: 120, height: 120)
    //                .overlay(callerAvatar)
            
            Text(directCallManager.directCall?.caller?.nickname ?? "")
                .font(.title)
                .padding(.top, 10)
            
            Spacer()
            
            HStack(spacing: 50) {
                Button(action: {
                    // Xử lý khi bấm nút mute
                    isMuted.toggle()
                }) {
                    Image(systemName: isMuted ? "mic.slash.fill" : "mic.fill")
                        .font(.title)
                }
                
                Button(action: {
                    // Xử lý khi bấm nút toggle loa
                    isCamera.toggle()
                }) {
                    Image(systemName: isCamera ? "speaker.wave.2.fill" : "speaker.wave.2")
                        .font(.title)
                }
                
                Button(action: {
                    // Xử lý khi bấm nút tắt cuộc gọi
                    directCallManager.endCall()
                    onClose()
                }) {
                    Image(systemName: "phone.down.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    // Xử lý khi bấm nút chấp nhận cuộc gọi
                    DispatchQueue.main.async {
                        directCallManager.acceptCall(isMicOn: isMuted, isCamOn: isCamera)
                    }

                    
                }) {
                    Image(systemName: "phone.fill.arrow.up.right")
                        .font(.title)
                        .foregroundColor(.green)
                }
                
            }
            .padding(.bottom, 20)
        }
    }
}


//
//  VideoCallWithChatLayout.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 23/08/2023.
//

import SwiftUI

struct VideoCallWithChatLayout: View {
    
    @EnvironmentObject var directCallManager : DirectCallManager
    
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var dragOffset: CGSize = .zero
    @State private var isScaled = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WebViewLayout(onClose: onClose, urlString: "https://e-doctor.dev/tu-van-suc-khoe")
                
                ZStack {
                    SendBirdVideoViewWrapper(sendBirdVideoView: (directCallManager.remoteVideoView))
                    
                }
                .frame(width: 157, height: 157).background(Color.gray)
                .cornerRadius(18)
                .scaleEffect(isScaled ? 8 : 1.0)
                .animation(.easeInOut)
                .position(location)
                .gesture(
                    simpleDrag
                )
                .gesture(
                    TapGesture()
                        .onEnded {
                            onClick()
                        }
                )
                 
                
            }.onAppear {
                location = CGPoint(x: geometry.size.width - 90, y: 200)
                isScaled = false
            }
            
        }.edgesIgnoringSafeArea(.all)
        
        
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
            }
    }
    
    func onClose() {
        CallStatusManager.shared.setCallStatus(value: .videoCalling)
    }
    
    func onClick() {
        isScaled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            CallStatusManager.shared.setCallStatus(value: .videoCalling)
        }
        
    }
}
    
    
//
//    struct VideoCallWithChatLayout_Previews: PreviewProvider {
//        static var previews: some View {
//            VideoCallWithChatLayout()
//        }
//    }


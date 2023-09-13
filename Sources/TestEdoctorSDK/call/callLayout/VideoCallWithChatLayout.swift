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
    
    @ObservedObject var counDownManager = CountDownManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WebViewLayout(onClose: onClose, urlString: "https://e-doctor.dev/tu-van-suc-khoe").equatable().padding(.top, 45)
                
                ZStack {
                    BackgroundImage(UrlString: directCallManager.directCall?.caller?.profileURL, blur: 2)
                        .frame(minWidth:157, minHeight: 240)
                    
                    if directCallManager.directCall?.isRemoteVideoEnabled == true {
                        SendBirdVideoViewWrapper(sendBirdVideoView: (directCallManager.remoteVideoView))
                    }
                }
                .onChange(of: counDownManager.remainingTime) { newValue in
                    if newValue == 0 {
                        directCallManager.endCall()
                    }
                }
                .frame(width: 157, height: 240).background(Color.gray)
                .cornerRadius(18)
                .scaleEffect(isScaled ? 4 : 1.0)
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
                location = CGPoint(x: geometry.size.width - 90, y: 250)
                isScaled = false
            }
            
        }.edgesIgnoringSafeArea(.bottom)
        
        
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.location.x < UIScreen.main.bounds.width - 157/2 && value.location.y <  UIScreen.main.bounds.height - 240/2 && value.location.x > 157/2 && value.location.y > 240/2{
                    self.location = value.location
                }

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


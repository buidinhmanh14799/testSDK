//
//  SendBirdCallManager.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 08/08/2023.
//

import Foundation
import UIKit
import CallKit
import SendBirdCalls

public class SendBirdCallManager: NSObject {

    public static let shared = SendBirdCallManager()

    private override init() {
        super.init()
    }

    public func configure(appId: String, userId: String, accessToken: String) {
        SendBirdCall.configure(appId: appId)
        login(userId: userId, accessToken: accessToken)
    }
    
    public func configure(appId: String) {
        SendBirdCall.configure(appId: appId)
    }
    
    public func login( userId: String, accessToken: String) {

        let params = AuthenticateParams(userId: userId, accessToken: accessToken)
        SendBirdCall.authenticate(with: params) { (user, error) in
            print("okoko authenticate")
            guard let voIpToken = VoIpTokenManager.getToken() else {return}
            
            SendBirdCall.registerVoIPPush(token: voIpToken, unique: true) { (error) in
                guard error == nil else { return }
            }

        }
        SendBirdCall.addDelegate(self, identifier: "com.edoctor.AppTestSDK")
    }

//    deinit {
//        SendBirdCall.removeDelegate(identifier: "com.edoctor.AppTestSDK")
//    }
    
    public func makeCall(calleeId: String, isVideoCall: Bool) {
        CallStatusManager.shared.setCallStatus(value: .waiting)

        let callOptions = CallOptions(isAudioEnabled: true, isVideoEnabled: true, localVideoView: DirectCallManager.shared.localVideoView, remoteVideoView: DirectCallManager.shared.remoteVideoView, useFrontCamera: true)
        let dialParams = DialParams(calleeId: calleeId, isVideoCall: true, callOptions: callOptions, customItems: [:])
        
        SendBirdCall.dial(with: dialParams) { call, error in
            
            DispatchQueue.main.async {
                DirectCallManager.shared.directCall = call
                DirectCallManager.shared.directCall?.updateLocalVideoView(DirectCallManager.shared.localVideoView)
                DirectCallManager.shared.directCall?.updateRemoteVideoView(DirectCallManager.shared.remoteVideoView)
                DirectCallManager.shared.directCall?.delegate = self
            }


        }
    }
    
    public func removeVoIPPushToken() {
        
        guard let voIpToken = VoIpTokenManager.getToken() else {return}
        
        SendBirdCall.unregisterVoIPPush(token : voIpToken) { (error) in
     
        }
    }
    
}





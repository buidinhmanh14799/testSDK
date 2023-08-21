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
        
        let params = AuthenticateParams(userId: userId, accessToken: accessToken)
        SendBirdCall.authenticate(with: params) { (user, error) in
            
            print("okoko authenticate")
            
            let userInfo = UserInfo(appId: appId, userId: userId, accessToken: accessToken)
            UserDataManager.saveUserInfo(userInfo: userInfo)
            
            _ = PushRegistryHandler.shared

        }
        SendBirdCall.addDelegate(self, identifier: "com.edoctor.AppTestSDK")
    }
    
    public func login( userId: String, accessToken: String) {
        SendBirdCall.configure(appId: "44745875-6069-46A9-A1A6-0B2A318E4632")
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
        let directCall = DirectCallManager.shared.startCall(calleeId: calleeId, isVideoCall: isVideoCall)
        directCall.delegate = self
    }
    
    public func removeVoIPPushToken() {
        
        guard let voIpToken = VoIpTokenManager.getToken() else {return}
        
        SendBirdCall.unregisterVoIPPush(token : voIpToken) { (error) in
     
        }
    }
    
}





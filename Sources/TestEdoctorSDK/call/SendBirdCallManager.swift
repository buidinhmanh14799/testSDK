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
            _ = AppStatusManager.shared
            

        }
        SendBirdCall.addDelegate(self, identifier: "com.edoctor.AppTestSDK")
    }
    
    public func login( userId: String, accessToken: String) {
        SendBirdCall.configure(appId: "44745875-6069-46A9-A1A6-0B2A318E4632")
        let params = AuthenticateParams(userId: userId, accessToken: accessToken)
        SendBirdCall.authenticate(with: params) { (user, error) in
            print("okoko authenticate")

        }
        SendBirdCall.addDelegate(self, identifier: "com.edoctor.AppTestSDK")
    }

    deinit {
        SendBirdCall.removeDelegate(identifier: "com.edoctor.AppTestSDK")
    }
    
    public func makeCall(calleeId: String, isVideoCall: Bool) {
        let directCall = DirectCallManager.shared.startCall(calleeId: calleeId, isVideoCall: isVideoCall)
        directCall.delegate = self
    }
    
    public func removeVoIPPushToken() {
        
        guard let userInfo = UserDataManager.getUserInfo() else {return}
        
        SendBirdCall.unregisterVoIPPush(token : userInfo.voIpToken) { (error) in
     
        }
    }
    
}





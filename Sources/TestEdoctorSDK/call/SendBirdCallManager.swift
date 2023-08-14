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

public class SendBirdCallManager: NSObject, SendBirdCallDelegate {

    public static let shared = SendBirdCallManager()

    private override init() {
        super.init()
    }

    public func configure(appId: String, userId: String, accessToken: String, deviceToken: Data) {
        SendBirdCall.configure(appId: appId)
        
        let params = AuthenticateParams(userId: userId, accessToken: accessToken)
        SendBirdCall.authenticate(with: params) { (user, error) in
            print("okoko authenticate")
            
                    SendBirdCall.registerVoIPPush(token: deviceToken) { error in
                                        if let error = error {
                                            print("Error registering VoIP push:", error.localizedDescription)
                                        } else {
                                            print("Successfully registered VoIP push")
                                        }
                                    }
        }
        _ = PushRegistryHandler.shared
        SendBirdCall.addDelegate(self, identifier: "com.edoctor.AppTestSDK")
    }
    
    public func login( userId: String, accessToken: String) {
        let params = AuthenticateParams(userId: userId, accessToken: accessToken)
        SendBirdCall.authenticate(with: params) { (user, error) in
            print("okoko authenticate")
        }
        SendBirdCall.addDelegate(self, identifier: "com.edoctor.AppTestSDK")
    }

//    deinit {
//        SendBirdCall.removeDelegate(identifier: "com.edoctor.AppTestSDK")
//    }
    
    public func makeCall(calleeId: String) {
        let params = DialParams(calleeId: calleeId, callOptions: CallOptions())

        let directCall = SendBirdCall.dial(with: params) { directCall, error in
            // The call was successfully made to calleeId.
            DirectCallManager.shared.setDirectCall(directCall: directCall!);
            
        }

       
    }
    
    //even

    public func didStartRinging(_ call: DirectCall) {
        DispatchQueue.main.async {
            inCommingCall(call: call)
        }
        print("Incoming call from \(call.caller?.userId ?? "")")
    }
    
    public func didEstablish(_ call: DirectCall) {
        print("Incoming call from didEstablish\(call.caller?.userId ?? "")")
    }
    
    public func didConnect(_ call: DirectCall) {
        print("Incoming call from didConnect\(call.caller?.userId ?? "")")
    }
    
    public func didRemoteAudioSettingsChange(_ call: DirectCall) {
        print("Incoming call from didRemoteAudioSettingsChange\(call.caller?.userId ?? "")")
    }
    
    public func didEnd(_ call: DirectCall) {
        print("Incoming call from didEnd\(call.caller?.userId ?? "")")
    }
    
}





//
//  File.swift
//  
//
//  Created by Bùi Đình Mạnh on 04/08/2023.
//

import Foundation
import SendBirdCalls

public class SendBirdCallManager: NSObject, SendBirdCallDelegate {
    public static let shared = SendBirdCallManager()

    private override init() {
        super.init()
    }

    public func configure(appId: String, userId: String, accessToken: String) {
        SendBirdCall.configure(appId: appId)
        
        let params = AuthenticateParams(userId: userId, accessToken: accessToken)
        SendBirdCall.authenticate(with: params) { (user, error) in
            
        }
        SendBirdCall.addDelegate(self, identifier: "SendBirdCallManager")
    }

    deinit {
        SendBirdCall.removeDelegate(identifier: "SendBirdCallManager")
    }

    public func didStartRinging(_ call: DirectCall) {
        print("Incoming call from \(call.caller?.userId ?? "")")
    }
}









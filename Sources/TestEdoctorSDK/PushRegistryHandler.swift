//
//  PushRegistryHandler.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 09/08/2023.
//

import PushKit
import SendBirdCalls

class PushRegistryHandler: NSObject, PKPushRegistryDelegate {
    static let shared = PushRegistryHandler()

    private override init() {
        super.init()
        // Khởi tạo PKPushRegistry và đăng ký delegate
        let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
        pushRegistry.delegate = self
        pushRegistry.desiredPushTypes = [.voIP]
    }

    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        
        
        SendBirdCall.registerVoIPPush(token: credentials.token, unique: true) { (error) in
            guard error == nil else { return }
            
            VoIpTokenManager.saveToken(voIpToken: credentials.token)
        }
    }
    

    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        // Xử lý khi push token bị vô hiệu hóa
        print("push token đã bị vô hiệu hóa")
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        // Xử lý khi nhận được push notification
        SendBirdCall.pushRegistry(registry, didReceiveIncomingPushWith: payload, for: type, completionHandler: { callUUID in
            print("callUUID\(String(describing: callUUID))")
        })
    }
}



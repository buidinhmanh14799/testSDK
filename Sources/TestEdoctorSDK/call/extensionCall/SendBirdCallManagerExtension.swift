//
//  SendBirdCallManagerExtension.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 16/08/2023.
//

import Foundation
import SendBirdCalls
import CallKit
import UIKit

extension SendBirdCallManager: SendBirdCallDelegate, DirectCallDelegate {
    
    public func didStartRinging(_ call: DirectCall) {
        call.delegate = self // To receive call event through `DirectCallDelegate`
        
        guard let uuid = call.callUUID else { return }
        guard CXCallManager.shared.shouldProcessCall(for: uuid) else { return }  // Should be cross-checked with state to prevent weird event processings
        
        let name = call.caller?.userId ?? "Unknown"
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: name)
        update.hasVideo = call.isVideoCall
        update.localizedCallerName = call.caller?.userId ?? "Unknown"
        
        if SendBirdCall.getOngoingCallCount() > 1 {
            // Allow only one ongoing call.
            CXCallManager.shared.reportIncomingCall(with: uuid, update: update) { _ in
                CXCallManager.shared.endCall(for: uuid, endedAt: Date(), reason: .declined)
            }
            call.end()
        } else {
            print("\(AppStatusManager.shared.state.rawValue) va \(UIApplication.State.active.rawValue)")
            // Report the incoming call to the system
            if AppStatusManager.shared.state == UIApplication.State.active{
                DispatchQueue.main.async {
                    inCommingCall(call: call, isPushNoti: false)
                }
            } else {
                CXCallManager.shared.reportIncomingCall(with: uuid, update: update)
            }
        }
        
        

        print("Incoming call from \(AppStatusManager.shared.state.rawValue )")
    }
    
    public func didEstablish(_ call: DirectCall) {
        print("Incoming call from didEstablish\(call.caller?.userId ?? "")")
    }
    
    public func didConnect(_ call: DirectCall) {
        print("Incoming call from didConnect\(call.caller?.userId ?? "")")
        DispatchQueue.main.async {
            if call.isVideoCall {
                CallStatusManager.shared.setCallStatus(value: .videoCalling)
            } else {
                CallStatusManager.shared.setCallStatus(value: .calling)
            }
        }

    }
    
    public func didRemoteAudioSettingsChange(_ call: DirectCall) {
        print("Incoming call from didRemoteAudioSettingsChange\(call.caller?.userId ?? "")")
    }
    
    public func didEnd(_ call: DirectCall) {
        print("Incoming call from didEnd\(call.caller?.userId ?? "")")
        
        var callId: UUID = UUID()
        if let callUUID = call.callUUID {
            callId = callUUID
        }
        
        CXCallManager.shared.endCall(for: callId, endedAt: Date(), reason: call.endResult)
        
        CallStatusManager.shared.setCallStatus(value: .finish)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            CallStatusManager.shared.setCallStatus(value: .none)
        }

    }
    
    
}

//
//  DirectCallManager.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 09/08/2023.
//

import Foundation
import SendBirdCalls
import UIKit

public class DirectCallManager: UIViewController, ObservableObject {
    
    public func didConnect(_ call: SendBirdCalls.DirectCall) {
        if call.isVideoCall {
            CallStatusManager.shared.setCallStatus(value: .videoCalling)
        } else {
            CallStatusManager.shared.setCallStatus(value: .calling)
        }
    }
    
    public func didEnd(_ call: SendBirdCalls.DirectCall) {
        CallStatusManager.shared.setCallStatus(value: .finish)
    }
    
    
    
    static let shared = DirectCallManager()

    @Published var directCall: DirectCall?
    
    
    public var localVideoView = SendBirdVideoView(frame: CGRect(x: 0, y: 0, width: 150, height: 300))
    public var remoteVideoView = SendBirdVideoView(frame: CGRect(x: 0, y: 0, width: 60, height: 80))
    
    
    
    public func setDirectCall(directCall: DirectCall) {
        self.directCall = directCall
    }
    
    public func resetDirectCall() {
        self.directCall = nil
        CallStatusManager.shared.setCallStatus(value: .none)
    }
    
    public func endCall() {
        directCall?.end()
        resetDirectCall()
    }
    
    public func acceptCall(isMicOn: Bool, isCamOn: Bool) {
        let callOption = CallOptions(isAudioEnabled: isMicOn, isVideoEnabled: isCamOn, localVideoView: localVideoView, remoteVideoView: remoteVideoView)
        
        localVideoView = SendBirdVideoView(frame: CGRect(x: 0, y: 0, width: 120, height: 160))
        remoteVideoView = SendBirdVideoView(frame: CGRect(x: 0, y: 0, width: 240, height: 320))
        
        let param = AcceptParams(callOptions: callOption)
        directCall?.accept(with: param)
        
        CallStatusManager.shared.setCallStatus(value: .waiting)
        
        directCall?.updateLocalVideoView(localVideoView)
        directCall?.updateRemoteVideoView(remoteVideoView)
    }
    
    public func startCall(calleeId: String,  isVideoCall: Bool) -> DirectCall{
        let callOption = CallOptions(isAudioEnabled: true, isVideoEnabled: true, localVideoView: localVideoView, remoteVideoView: remoteVideoView)
        
        localVideoView = SendBirdVideoView(frame: CGRect(x: 0, y: 0, width: 120, height: 160))
        remoteVideoView = SendBirdVideoView(frame: CGRect(x: 0, y: 0, width: 240, height: 320))
        
        let params = DialParams(calleeId: calleeId, callOptions: callOption)
        
        CallStatusManager.shared.setCallStatus(value: .waiting)
        
        let directCall = SendBirdCall.dial(with: params) { directCall, error in
            

        }
        
        
        directCall?.updateLocalVideoView(localVideoView)
        directCall?.updateRemoteVideoView(remoteVideoView)
        
        return directCall!
    }
    
}


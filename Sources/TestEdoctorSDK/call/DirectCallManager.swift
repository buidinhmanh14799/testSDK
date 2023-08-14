//
//  DirectCallManager.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 09/08/2023.
//

import Foundation
import SendBirdCalls

public class DirectCallManager: ObservableObject {
    
    
    static let shared = DirectCallManager()

    @Published var directCall: DirectCall?
    @Published var callStatus: CallStatus = .none
    
    public func setDirectCall(directCall: DirectCall) {
        self.directCall = directCall
    }
    
    public func resetDirectCall() {
        self.directCall = nil
        callStatus = .none
    }
    
    public func endCall() {
        directCall?.end()
        resetDirectCall()
    }
    
    public func acceptCall(isMicOn: Bool, isCamOn: Bool) {
        let callOption = CallOptions(isAudioEnabled: isMicOn, isVideoEnabled: isCamOn)
        let param = AcceptParams(callOptions: callOption)
        directCall?.accept(with: param)
        if isCamOn {
            callStatus = .videoCalling
        } else {
            callStatus = .calling
        }
    }
    
}

extension DirectCallManager: DirectCallDelegate {
    public func didConnect(_ call: DirectCall) {
        print("===> didConnect")
//        if call.isRemoteVideoEnabled {
//            callStatus = .videoCalling
//        } else {
//            callStatus = .calling
//        }
    }
    
    public func didEnd(_ call: DirectCall) {
        print("===> didEnd")
        callStatus = .finish
    }
    
//    func remoteVideoViewChanged(_ call: DirectCall) {
//        remoteVideoView = call.remoteView
//    }
}

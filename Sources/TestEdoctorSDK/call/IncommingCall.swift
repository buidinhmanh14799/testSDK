//
//  IncommingCallLayout.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 09/08/2023.
//

import SwiftUI

struct IncommingCall: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var directCallManager = DirectCallManager.shared
    
    
    var body: some View {
        VStack {
            if directCallManager.callStatus == .comming {
                IncommingCallLayout(onClose: onClose).environmentObject(directCallManager)
            }else {
                VideoCallScreen(onClose: onClose).environmentObject(directCallManager)
            }
            
        }
        .padding()
        .onDisappear {
            // Đóng hosting controller khi SwiftUI view biến mất
            if let presentingViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                presentingViewController.dismiss(animated: true, completion: nil)
            }
            requestPermissions()
            
        }
    }
    
    func onClose () {
        presentationMode.wrappedValue.dismiss()
    }
}

//
//  Permistion.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 11/08/2023.
//

import AVFoundation
import UserNotifications

public func requestPermissions() {
    requestCameraPermission()
    requestMicrophonePermission()
    requestNotificationPermission()
}

public func requestCameraPermission() {
    AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
            print("Camera permission granted.")
        } else {
            print("Camera permission denied.")
        }
    }
}

public func requestMicrophonePermission() {
    AVCaptureDevice.requestAccess(for: .audio) { granted in
        if granted {
            print("Microphone permission granted.")
        } else {
            print("Microphone permission denied.")
        }
    }
}

public func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Notification permission granted.")
        } else {
            print("Notification permission denied.")
        }
    }
}

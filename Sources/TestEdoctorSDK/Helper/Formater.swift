//
//  Fomater.swift
//  AppTestSDK
//
//  Created by Bùi Đình Mạnh on 29/08/2023.
//

import Foundation

public func timeFormatted(secondsElapsed: TimeInterval) -> String {
    let hours = Int(secondsElapsed) / 3600
    let minutes = (Int(secondsElapsed) % 3600) / 60
    let seconds = Int(secondsElapsed) % 60
    if hours == 0 {
        return String(format: "%02d:%02d", minutes, seconds)
    }
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

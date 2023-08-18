import Foundation
import SwiftUI

class AppStatusManager: ObservableObject {
    static let shared = AppStatusManager()
    
    @Published var state: UIApplication.State = .inactive
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appBecameActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }

    @objc func appMovedToBackground() {   

    }
    
    @objc func appBecameActive() {
        print("active")
        state = .active
    }
    
    @objc func appDidEnterBackground() {
        state = .background
        print("background")
    }
    
    @objc func appWillEnterForeground() {
        state = .inactive
        print("inactive")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

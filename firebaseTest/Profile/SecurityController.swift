//
//  SecurityController.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 29/03/2023.
//

import Foundation
import SwiftUI
import LocalAuthentication

//https://medium.com/@williewilson99/app-lock-with-swiftui-9d573aa2d040

@MainActor
class SecurityController: ObservableObject {
    
    
    var error: NSError?
    
    @Published var isLocked = false
    @Published var isAppLockEnabled: Bool = UserDefaults.standard.object(forKey: "isAppLockEnabled") as? Bool ?? false
    @Published var showSheet = false
    
}

extension SecurityController {
    
    func authenticate() {
        let context = LAContext()
        let reason = "Authenticate yourself to unlock app"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                        self.showSheet = false
                    }
                }
            }
        }
    }
    
}

extension SecurityController {
    
    func appLockStateChange(_ isEnabled: Bool) {
        let context = LAContext()
        let reason = "Authenticate to toggle App Lock"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                        self.isAppLockEnabled = isEnabled
                        UserDefaults.standard.set(self.isAppLockEnabled, forKey: "isAppLockEnabled")
                        print("successfully set user default as \(self.isAppLockEnabled)")
                    }
                }
            }
        }
    }
        
}

extension SecurityController {
    
    func showLockedViewIfEnabled(first: Int) {
        print("currently islocked = \(isLocked)")
        if isAppLockEnabled {
            if first == 0{
                isLocked = true
                showSheet = true
                authenticate()
            }
            else{
                showSheet = false
            }
            
            
        } else {
            isLocked = false
        }
    }
    
    func lockApp() {
        print("detected isAppLockEnabled is \(isAppLockEnabled)")
        if isAppLockEnabled {
            isLocked = true
            print("locked app, lock enabled")
        } else {
            isLocked = false
            print("not locked app, else")
        }
    }
    
}

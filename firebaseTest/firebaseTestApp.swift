//
//  firebaseTestApp.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 17/01/2023.
//



//final class AppDelegate: NSObject, UIApplicationDelegate {
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//
//            FirebaseApp.initialize()
//            FirebaseApp.configure()
//
//        return true
//    }
//}

import SwiftUI
import Firebase
import LocalAuthentication
import UserNotifications
import UIKit

@main
struct firebaseTestApp: App {
    
    init(){
//        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
            FirebaseApp.configure()
          
    }
    
    @StateObject var sessionService = SessionServiceImp()
    //use state from sessionService to decide which view should appear
    //whenever the state property changes, swiftui will call redraw and change between either login or mainapp
    
    @StateObject var securityController = SecurityController()
    @Environment(\.scenePhase) var scenePhase
    
    @State private var firstInApp = 0
    @State private var outsideApp = true

    var body: some Scene {
        WindowGroup {
            NavigationView{
                switch sessionService.state{
                case .loggedIn:
                            MainView(securityController: securityController)
                                .environmentObject(sessionService)
//                                .environmentObject(securityController)
                                .onChange(of: scenePhase) { phase in
                                    if phase == .active {
                                        print("on change works for main view")
                                        if firstInApp == 0{
    //                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        print("is app enabled \(securityController.isAppLockEnabled)")
                                                securityController.showLockedViewIfEnabled(first: firstInApp)
                                                firstInApp = firstInApp + 1
                                                print("first in app \(firstInApp)")
    //                                            showSheet = securityController.isLocked
    //                                        }
                                            
                                        }
                                    }
                                }
                                .sheet(isPresented: $securityController.showSheet) {
                                    
                                        LockView()
                                            .environmentObject(securityController)
                                            .interactiveDismissDisabled()
                                            .onAppear {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    outsideApp = false
                                                }
                                                print("sheet show because is locked is \($securityController.isLocked)")
                                            }
                                }
                    
                case .loggedOut:
                    LoginView()
                    
                }
            }
            .onAppear{
                NotificationManager.instance.requestAuthorization()
            }
        }
        .onChange(of: scenePhase, perform: { phase in
            switch phase {
            case .background:
                outsideApp = true
                firstInApp = 0
                securityController.lockApp()
                print("now it is background")
            case .inactive:
                outsideApp = true
                print("now it is inactive")
            case .active:
                print("now it is active")
            default:
                break
            }
            
        })

        
    }
}

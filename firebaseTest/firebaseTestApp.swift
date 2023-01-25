//
//  firebaseTestApp.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 17/01/2023.
//

import SwiftUI
import Firebase


final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct firebaseTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImp()
    //use state from sessionService to decide which view should appear
    //whenever the state property changes, swiftui will call redraw and change between either login or mainapp

    var body: some Scene {
        WindowGroup {
            NavigationView{
                switch sessionService.state{
                case .loggedIn:
                    MainView()
                        .environmentObject(sessionService)
                case .loggedOut:
                    LoginView()
                    
                }
            }
        }
    }
}

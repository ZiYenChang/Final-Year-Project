//
//  NotificationManager.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 09/03/2023.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success,error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    

    
    
    func scheduleDateNotification(title: String, subtitle: String, dateHour: Int, dateMinute: Int) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1
        
        
        //calendar
        var dateComponents = DateComponents()
        dateComponents.hour = dateHour
        dateComponents.minute = dateMinute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleTimeNotification(title: String, subtitle: String, minutes: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = 1
        
        //time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: minutes * 60.0 , repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

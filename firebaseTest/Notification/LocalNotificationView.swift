//
//  LocalNotificationView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 09/03/2023.
//

import SwiftUI
import UserNotifications

struct LocalNotificationView: View {
    var body: some View {
        VStack {
            Button("Request Permission"){
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification"){
//                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification"){
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
    }
}

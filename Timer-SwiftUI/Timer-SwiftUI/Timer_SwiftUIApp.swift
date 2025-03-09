//
//  Timer_SwiftUIApp.swift
//  Timer-SwiftUI
//
//  Created by Begüm Arıcı on 9.03.2025.
//

import SwiftUI
import UserNotifications

@main
struct Timer_SwiftUIApp: App {
    init() {
        let center = UNUserNotificationCenter.current()
        center.delegate = NotificationDelegate()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

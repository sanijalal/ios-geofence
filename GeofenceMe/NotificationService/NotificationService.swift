//
//  NotificationService.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 01/09/2021.
//

import Foundation
import UserNotifications
import UIKit

class NotificationService {
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { isAuthorised, error in
        }
    }
    
    func clearNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func sendLocalNotification(text: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.body = text
        notificationContent.sound = .default
        notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "location_change", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
          if let error = error {
            print("Error: \(error)")
          }
        }
    }
}

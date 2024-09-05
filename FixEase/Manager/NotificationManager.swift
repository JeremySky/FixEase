//
//  NotificationManager.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 9/4/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    func removeDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().setBadgeCount(0)
        print("Remove All Delivered Notifications")
    }
    
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS!")
            }
        }
    }
    
    func scheduleNotification(for upkeep: Upkeep) {
        
        let content = UNMutableNotificationContent()
        content.title = "Tasks Due"
        content.subtitle = upkeep.description
        content.sound = .default
        content.badge = 1
        
        var dateComponents: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: upkeep.dueDate)
        dateComponents.hour = 9
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: upkeep.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelUpkeepNotification(_ upkeep: Upkeep) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [upkeep.id.uuidString])
    }
    
    func cancelItemNotifications(_ item: Item) {
        let arrayOfUpkeepIDs: [String] = item.upkeeps.map({ $0.id.uuidString })
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: arrayOfUpkeepIDs)
    }
    
    func deleteAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

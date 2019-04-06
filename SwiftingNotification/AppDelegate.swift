//
//  AppDelegate.swift
//  SwiftingNotification
//
//  Created by Constantine Loutas on 20/01/2017.
//  Copyright © 2017 Constantine Loutas. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        let action = UNNotificationAction(identifier: NotificationIdentifier.reply.description, title: "reply")
        let category = UNNotificationCategory(identifier: NotificationIdentifier.category.description, actions: [action], intentIdentifiers: [])
        center.setNotificationCategories([category])
        
        // MARK: Request Authorization for Notifications
        center.requestAuthorization(options: [.badge, .alert, .sound]) { (_, error) in
            if error != nil { print("\(#function) error:", String(describing: error)) }
        }
        
        // MARK: Registering for Remote Notifications
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Silent notification (content-available tag) received.")
        Helpers.logPushDeliveryToServer()
        completionHandler(.newData)
    }
    
    // MARK: - Remote Notification Registration Handling
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs device token: \(token)")
    }
    
    // MARK: - Notification Error Handling
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("\(#function) error: \(error)")
    }
    
}

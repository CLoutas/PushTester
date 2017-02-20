//
//  ViewController.swift
//  SwiftingNotification
//
//  Created by Constantine Lutas on 20/01/2017.
//  Copyright © 2017 Constantine Lutas. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

final class ViewController: UIViewController {
    override func viewDidLoad() {
        UNUserNotificationCenter.current().delegate = self
    }
}

// MARK: - UNUserNotificationCenterDelegate Conformance
extension ViewController: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler( [.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print("Tapped in notification")
        Helpers.logPushDeliveryToServer()
    }
}

// MARK: - Notification Management
extension ViewController {
    
    @IBAction func showSimpleLocalNototification() {
        let content = NotificationContent(title: "SwiftingNotifications", subTitle: "Swifting.io presents", body: "Rich notifications")
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request.description, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                //handle here
            }
        }
    }
    
    @IBAction func showCustomActionsLocalNototification() {
        let content = NotificationContent(title: "SwiftingNotifications", subTitle: "Swifting.io presents", body: "Actionable notifications")
        content.categoryIdentifier = NotificationIdentifier.category.description
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request.description, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                //handle here
            }
        }
    }
    
    @IBAction func showMediaAttachememnt() {
        
        let content = NotificationContent(title: "SwiftingNotifications", subTitle: "Swifting.io presents", body: "Media notifications")
        
        guard let url = Helpers.saveImage(name: "skrzypce.jpg") else {
            return
        }
        
        let attachment = try? UNNotificationAttachment(identifier: NotificationIdentifier.image.description,
                                                       url: url,
                                                       options: [:])
        
        if let attachment = attachment {
            content.attachments.append(attachment)
        }
        
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request.description, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                //handle here
            }
        }
    }
    
    @IBAction func showCustomContentNotification() {
        
        let content = NotificationContent(title: "SwiftingNotifications", subTitle: "Swifting.io presents", body: "Custom notifications")
        
        content.categoryIdentifier = NotificationIdentifier.customContent.description
        
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request.description, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                //handle here
            }
        }
    }
    
    @IBAction func showDelayedNotification() {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let content = NotificationContent(title: "SwiftingNotifications", subTitle: "Swifting.io presents", body: "Delayed notifications")
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request.description, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                //handle here
            }
        }
    }
    
}

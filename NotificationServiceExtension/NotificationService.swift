//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Konstantinos Loutas on 07/02/2017.
//  Copyright © 2017 roche. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            logPushDeliveryOnServer()
            
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}

// MARK: - Server logging
extension NotificationService {
    
    func logPushDeliveryOnServer() {
        let url = URL(string: "http://10.0.0.100/~dbilios/dimitris/log_echo.php")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard error == nil else { print(error?.localizedDescription ?? "Delivery logging dataTask failed!"); return }
        }
        task.resume()
    }
    
}

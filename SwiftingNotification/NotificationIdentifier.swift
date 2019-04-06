//
//  NotificationIdentifier.swift
//  SwiftingNotification
//
//  Created by Constantine Loutas on 20/01/2017.
//  Copyright © 2017 Constantine Loutas. All rights reserved.
//

import Foundation

enum NotificationIdentifier {
    case request
    case reply
    case category
    case image
    case customContent
}

extension NotificationIdentifier: CustomStringConvertible {
    var description: String {
        switch self {
        case .request:
            return "requestIdentifier"
        case .reply:
            return "replyIdentifier"
        case .category:
            return "catgeoryIdentifier"
        case .image:
            return "imageIdentifier"
        case .customContent:
            return "customContentIdentifier"
        }
    }
}

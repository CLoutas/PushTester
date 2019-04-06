//
//  NotificationButton.swift
//  SwiftingNotification
//
//  Created by woroninb on 15/08/16.
//  Copyright © 2017 Constantine Loutas. All rights reserved.
//

import UIKit

final class NotificationButton: UIButton {
    
    private var pressedAction: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.pressedAction = action
        super.init(frame: .zero)
        self.setTitleColor(UIColor.blue, for: .normal)
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped(sender: AnyObject) {
        pressedAction()
    }
}

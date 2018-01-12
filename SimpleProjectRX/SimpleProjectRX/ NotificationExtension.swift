//
//   NotificationExtension.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

// 5. In the Observer Design pattern, one object notifies other objects of any state changes. The objects involved don't need to know about one another ,This pattern's most often used to notify interested objects when a property has changed.
// Cocoa implements the observer pattern in two ways: Notifications and Key-Value Observing (KVO).
// For example, when the keyboard is shown/hidden the system sends a UIKeyboardWillShow/UIKeyboardWillHide, respectively. When your app goes to the background, the system sends a UIApplicationDidEnterBackground notification
extension Notification.Name {
    static let BLDownloadImage = Notification.Name("BLDownloadImageNotification")
}

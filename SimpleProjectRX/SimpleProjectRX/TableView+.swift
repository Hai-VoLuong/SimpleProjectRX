//
//  TableView+.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit

    extension UITableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        }
    }

#elseif os(OSX)
    import Cocoa

    extension NSTableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return make(withIdentifier: String(describing: T.self), owner: self) as! T
        }
    }

#endif

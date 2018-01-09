//
//  Storyboard+.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

#if os(iOS)
    import UIKit

    extension UIStoryboard {
        func instantiateViewController<T>(ofType type: T.Type) -> T {
            return instantiateViewController(withIdentifier: String(describing: type)) as! T
        }
    }
#elseif os(OSX)
    import Cocoa

    extension NSStoryboard {
        func instantiateViewController<T>(ofType type: T.Type) -> T {
            return instantiateController(withIdentifier: String(describing: type)) as! T
        }
    }
#endif

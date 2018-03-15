//
//  UserDefaults+Helpers.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/15/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

extension UserDefaults {

    enum UserDefaultskeys: String {
        case isLoggedIn
    }

    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultskeys.isLoggedIn.rawValue)
        synchronize()
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultskeys.isLoggedIn.rawValue)
    }
}

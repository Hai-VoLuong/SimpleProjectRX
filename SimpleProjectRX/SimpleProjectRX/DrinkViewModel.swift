//
//  DrinkViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import MVVM

class DrinkViewModel: MVVM.ViewModel {

    enum Section: Int {
        case coffee = 0
        case drink

        var name: String {
            switch self {
            case .coffee:
                return "coffee"
            case .drink:
                return "drink"
            }
        }
    }

    // MARK: - Properties
}

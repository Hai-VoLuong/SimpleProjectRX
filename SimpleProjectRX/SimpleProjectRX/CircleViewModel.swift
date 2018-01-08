//
//  CircleViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/8/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ChameleonFramework

final class CircleViewModel {

    // MARK: - Properties
    var centerVariable = Variable<CGPoint?>(.zero)
    var backgroundColorObservable: Observable<UIColor>!

    // MARK: - Life Cycle
    init() {
        setup()
    }

    // MARK: - Private Func
    private func setup() {
        backgroundColorObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else { return UIColor.flatten(.black)() }

                let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0) / 255.0)
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0

                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
            }
    }

}

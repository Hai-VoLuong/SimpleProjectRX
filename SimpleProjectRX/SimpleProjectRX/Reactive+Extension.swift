//
//  Reactive+Extension.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/31/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD

public extension ObservableType {
    public func HUD() -> Observable<Self.E> {
        return self.do(onNext: nil, onError: { error in
            DispatchQueue.main.async {
                SVProgressHUD.showInfo(withStatus: error.localizedDescription)
            }
        }, onCompleted: {
            dismisssHUD()
        }, onSubscribe: nil, onSubscribed: {
            showHUD()
        }, onDispose: {
            dismisssHUD()
        })
    }
}

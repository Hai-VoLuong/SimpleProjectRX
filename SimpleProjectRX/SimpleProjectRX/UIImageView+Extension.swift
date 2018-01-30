//
//  UIImageView+Extension.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/30/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum MyErrors: Int, Error {
    case PathNil = 404
    case NoInternet = 401

    var localizedDescription: String {
        switch self {
        case .PathNil:
            return NSLocalizedString("Path is nil", comment: "")
        case .NoInternet:
            return NSLocalizedString("Need internet", comment: "")
        }
    }

    var code: Int {
        return self.rawValue
    }
}

extension UIImageView {
    func setImage(path: String?) -> Observable<UIImage> {
        return Observable<UIImage>.create({ (observer) -> Disposable in

            guard let url = URL(string: path ?? "") else {
                let error = MyErrors.PathNil
                observer.onError(error)
                return Disposables.create()
            }
            let disposable = URLSession.shared.rx.data(request: URLRequest(url: url))
                .observeOn(MainScheduler.instance)
                .subscribe({ (event) in
                    switch event {
                    case .next(let data):
                        if let image = UIImage(data: data) {
                            self.image = image
                            observer.onNext(image)
                        } else {
                            observer.onError(RxError.unknown)
                        }
                    case .error(let error):
                        observer.onError(error)
                    case .completed:
                        observer.onCompleted()
                    }
                })
            return disposable
        })
    }
}


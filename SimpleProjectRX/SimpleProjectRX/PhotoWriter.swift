//
//  PhotoWriter.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/23/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift

class PhotoWriter {
    typealias Callback = (NSError?) -> Void

    private let callback: Callback
    static let bag = DisposeBag()

    init(callback: @escaping Callback) {
        self.callback = callback
    }

    static func save(_ image: UIImage) -> Observable<Void> {
        return Observable<Void>.create { observer -> Disposable in
            let writer = PhotoWriter(callback: { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            })
            UIImageWriteToSavedPhotosAlbum(image, writer, nil, nil)
            return Disposables.create()
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo info: UnsafeRawPointer) {
        callback(error)
    }
}

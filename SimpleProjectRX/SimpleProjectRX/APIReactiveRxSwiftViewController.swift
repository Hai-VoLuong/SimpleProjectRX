//
//  APIReactiveRxSwiftViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/10/18.
//  Copyright © 2018 Hai Vo L. All rights reserved. APIReactiveRxSwiftViewController
//

import UIKit
import RxSwift

import RxSwift

class APIReactiveRxSwiftViewController: UIViewController {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "API Reactive RxSwift Moya"
        // Cách thông thường
        BookService.getBook(id: 100, completion: { (data, error) in
            // Thao tác với data và error
        })

        // Reactive Style
        BookService.getBookRx(id: 100)
            // Làm gì đó hay ho với các operator của RxSwift
            // ...
            // Sau đó:
            .subscribe(onNext: { book in
                // Xử lý book object
            }, onError: { error in
                // Xử lý nếu gặp lỗi
            }, onCompleted: {
                // Xử lý khi complete
            }, onDisposed: {
                // Xử lý khi dispose
            }).disposed(by: disposeBag)
    }
}

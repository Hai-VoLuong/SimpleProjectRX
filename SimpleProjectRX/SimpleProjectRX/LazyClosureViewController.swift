//
//  LazyClosureViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/10/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class LazyClosureViewController: UIViewController {

    // var myCustomView = UIView()
    lazy var myCustomView: UIView = {
        var view = UIView()
        view = UIView(frame: CGRect(x: 50, y: 50, width: 100.0, height: 100.0))
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lazy Closures"
        view.addSubview(myCustomView)
    }

}

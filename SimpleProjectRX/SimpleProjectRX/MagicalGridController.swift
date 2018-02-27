//
//  MagicalGridController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/27/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class MagicalGridController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Magical Grid to Tinde"
        let redView = UIView()
        redView.backgroundColor = .red
        redView.frame = CGRect(x: 0, y: 64, width: 100, height: 100)
        view.addSubview(redView)
    }
}

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

        let numViewPerRow = 15
        let width = view.frame.width / CGFloat(numViewPerRow)

        for i in 0...numViewPerRow {
            let redView = UIView()
            redView.backgroundColor = randomColor()
            redView.frame = CGRect(x: CGFloat(i) * width , y: 64, width: width , height: width)
            view.addSubview(redView)
        }
    }

    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

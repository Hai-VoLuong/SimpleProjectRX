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

        for j in 0...30 {
            for i in 0...numViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width , y: 64 + (CGFloat(j) * width), width: width , height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)

                view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
            }
        }
    }

    func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        print(location)
    }

    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

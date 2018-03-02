//
//  MagicalGridController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/27/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class MagicalGridController: UIViewController {

    private let numViewPerRow = 15
    private var cells = [String: UIView]()
    private var seletedView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Magical Grid to Tinde"

        let width = view.frame.width / CGFloat(numViewPerRow)

        for j in 0...15 {
            for i in 0...numViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width , y: 64 + CGFloat(j) * width, width: width , height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)

                let key = "\(i)\(j)"
                cells[key] = cellView
            }
        }

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }

    func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)

        let width = view.frame.width / CGFloat(numViewPerRow)

        let i = Int(location.x / width)
        let j = Int(location.y / width)

        let key = "\(i)\(j)"
        guard let cellView = cells[key] else { return }

        if seletedView != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.seletedView?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }

        seletedView = cellView

        view.bringSubview(toFront: cellView)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)

        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: { (_) in

            })
        }
    }

    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

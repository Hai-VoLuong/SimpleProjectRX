//
//  LiveStreamController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/7/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift

final class LiveStreamController: UIViewController {

    @IBOutlet private weak var tapButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .yellow
        view.addSubview(curvedView)
    }
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    let endPoint = CGPoint(x: 400, y: 200)
    let cp1 = CGPoint(x: 100, y: 100)
    let cp2 = CGPoint(x: 200, y: 300)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
}

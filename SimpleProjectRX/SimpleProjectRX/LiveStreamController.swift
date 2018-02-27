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
        title = "live stream like faceBook"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    func handleTap() {
        // số lượng image muốn hiển thị : ví dụ 10 icon
        (0...10).forEach({ (_) in
            generateAnimationViews()
        })
    }

    fileprivate func generateAnimationViews() {
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "heart") : #imageLiteral(resourceName: "like")
        let imageView = UIImageView(image: image)

        // random kích thước image
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 300, width: dimension, height: 30)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        // random thời gian
        animation.duration = 2 + drand48() * 3

        // biết mất hình sau khi animation
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        // animation nhanh sau đó chậm dần
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    let endPoint = CGPoint(x: 400, y: 200)

    // random độ cao và độ thấp của image
    let randomY = 200 + drand48() * 300
    let cp1 = CGPoint(x: 100, y: 100 - randomY)
    let cp2 = CGPoint(x: 200, y: 300 + randomY)
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

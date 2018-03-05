//
//  AnimatedCircleProgressBar.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class AnimatedCircleProgressBar: UIViewController, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finish download ")
    }

    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animated Circle Progress Bar"

        let center = view.center

        // create my track layer
        let trackLayer = CAShapeLayer()

        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath

        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        view.layer.addSublayer(trackLayer)


        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound

        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2

        // nhìn thấy trạng thái cuối cùng của animation
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false

        shapeLayer.add(basicAnimation, forKey: "urlSoBasic")
    }

     let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"

    fileprivate func beginDownloadFile() {
        print("begin download")
        let configuration = URLSessionConfiguration.default
        let operation = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operation)
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }

    func handleTap() {
        animateCircle()
        beginDownloadFile()
    }
}

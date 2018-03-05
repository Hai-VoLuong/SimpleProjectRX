//
//  AnimatedCircleProgressBar.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class AnimatedCircleProgressBar: UIViewController, URLSessionDownloadDelegate {
    let shapeLayer = CAShapeLayer()

    let percentTargeLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animated Circle Progress Bar"

        view.addSubview(percentTargeLabel)
        percentTargeLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentTargeLabel.center = view.center
        // create my track layer
        let trackLayer = CAShapeLayer()

        let circularPath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath

        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)


        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)

        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }


    func handleTap() {
        //animateCircle()
        beginDownloadFile()
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

    fileprivate func beginDownloadFile() {
        print("begin download")
        let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
        shapeLayer.strokeEnd = 0
        let configuration = URLSessionConfiguration.default
        let operation = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operation)
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print(percentage)
        DispatchQueue.main.async {
            self.percentTargeLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = CGFloat(percentage)
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finish download ")
    }
}

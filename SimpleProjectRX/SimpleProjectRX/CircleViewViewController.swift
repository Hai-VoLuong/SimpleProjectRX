//
//  CircleViewViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/8/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class CircleViewViewController: UIViewController {

    // MARK: Properties
    var circleView: UIView!
    let circleViewModel = CircleViewModel()
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Circle View"
        setupUI()
    }

    //MARK: - Private Func
    private func setupUI() {
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)

        circleView.rx.observe(CGPoint.self, "center")
        .bind(to: circleViewModel.centerVariable)
        .addDisposableTo(disposeBag)

        setupBackgroundViewModel()

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }

    private func setupBackgroundViewModel() {
        circleViewModel.backgroundColorObservable
            .subscribe(onNext: { [weak self] backgroundColor in
                UIView.animate(withDuration: 0.1, animations: {
                    guard let this = self else { return }
                    this.circleView.backgroundColor = backgroundColor

                    let viewBackGroundColor = UIColor(complementaryFlatColorOf: backgroundColor)
                    if viewBackGroundColor != backgroundColor {
                        this.view.backgroundColor = viewBackGroundColor
                    }
                })
            }).addDisposableTo(disposeBag)
    }

    @objc fileprivate func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1, animations: {
            self.circleView.center = location
        })
    }
}

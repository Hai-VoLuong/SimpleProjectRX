//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Hai Vo L. on 1/15/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "hello"
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        animateTextLabels()
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else {
            self.preferredContentSize = CGSize(width: view.frame.width, height: 150)
        }
    }

    private func animateTextLabels() {
        let isExpandedMode = self.extensionContext?.widgetLargestAvailableDisplayMode == .expanded
        let scaleText: CGFloat = isExpandedMode ? 3 : 0.3
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let this = self else { return }
            this.textLabel.transform = .init(scaleX: scaleText, y: scaleText)
            this.dateLabel.transform = isExpandedMode ? .init(translationX: 0, y: 20) : .identity
            }, completion: { finished in
                UIView.animate(withDuration: 0.3, animations: {
                    self.textLabel.transform = .identity
                })
            })
    }
}

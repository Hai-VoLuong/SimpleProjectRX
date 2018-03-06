//
//  AutoLayoutThroughExtensions.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/6/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class AutoLayoutThroughExtensions: UIViewController {

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(redView)
        title = "auto layout extension"
        // enable auto layout
        if #available(iOS 11.0, *) {
            redView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
        trailingAnchor.constraint(equalTo: trailing).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
    }
}

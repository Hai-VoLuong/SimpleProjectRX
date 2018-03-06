//
//  TinderImageView.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/6/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class TinderImageView: UIImageView {

    let labelName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "text"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowOffset = .zero
        return label
    }()

    @IBInspectable
    var imageIndex: NSNumber! {
        didSet {
            let imageName = "Bill_Gates\(imageIndex.stringValue)"
            self.image = UIImage(named: imageName)
            layer.cornerRadius = 10
            labelName.text = imageIndex.stringValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    }
}

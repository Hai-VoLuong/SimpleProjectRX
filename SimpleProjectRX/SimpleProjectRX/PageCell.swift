//
//  PageCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    var page: Page? {
        didSet {
            guard let page = page else { return }

            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape {
                imageName += "_landscape"
            }

            imageView.image = UIImage(named: imageName)
            textView.text = page.title + "\n\n" + page.message

            let color = UIColor(white: 0.2, alpha: 1)

            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: color]))

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))

            textView.attributedText = attributedText
        }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "page1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.text = "Samle Text"
        return tv
    }()

    let lineSeparatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)

        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: textView.topAnchor, trailing: trailingAnchor)

        textView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .zero)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true


        lineSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: textView.topAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 1))

    }

}

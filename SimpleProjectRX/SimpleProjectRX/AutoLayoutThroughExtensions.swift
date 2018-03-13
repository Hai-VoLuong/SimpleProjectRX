//
//  AutoLayoutThroughExtensions.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/6/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class AutoLayoutThroughExtensions: UIViewController {

    let background: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.font = UIFont.preferredFont(forTextStyle: .headline)
        tv.text = ""
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "auto layout extension"
        [background,redView, blueView, greenView, whiteView].forEach({view.addSubview($0)})

        if #available(iOS 11.0, *) {
            background.fillSuperView()

            redView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 100, height: 0))
            redView.heightAnchor.constraint(equalTo: redView.widthAnchor).isActive = true

            blueView.anchor(top: redView.bottomAnchor, leading: nil, bottom: nil, trailing: redView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
            blueView.anchorSize(to: redView)

            greenView.anchor(top: redView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: blueView.bottomAnchor, trailing: redView.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))

            whiteView.anchor(top: blueView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: blueView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 0, height: 200))

            whiteView.addSubview(textView)
            textView.anchor(top: whiteView.topAnchor, leading: whiteView.leadingAnchor, bottom: nil, trailing: whiteView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))

            textView.delegate = self
            textView.isScrollEnabled = false
            textViewDidChange(textView)
        } else {

        }
    }
}

extension AutoLayoutThroughExtensions: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: whiteView.frame.width, height: .infinity)
        let estimateSize = textView.sizeThatFits(size)

        textView.constraints.forEach({ contraint in
            if contraint.firstAttribute == .height {
                contraint.constant = estimateSize.height
            }
        })
    }
}

extension UIView {

    func fillSuperView() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        // fix warning in console
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func anchorLayout(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({$0.isActive = true})

        return anchors
    }
}



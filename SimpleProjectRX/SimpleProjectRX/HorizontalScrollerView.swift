//
//  HorizontalScrollerView.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

protocol HorizontalScrollerViewDataSource: class {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView
}

protocol HorizontalScrollerViewDelegate: class {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int)
}

// Adapter Design Pattern: An Adapter allows classes with incompatible interfaces to work together. It wraps itself around an object and exposes a standard interface to interact with that object.
// Apple uses protocols to do the job. You may be familiar with protocols like UITableViewDelegate, UIScrollViewDelegate, NSCoding and NSCopying. As an example, with the NSCopying protocol, any class can provide a standard copy method.

class HorizontalScrollerView: UIView {

    weak var dataSource: HorizontalScrollerViewDataSource?
    weak var delegate: HorizontalScrollerViewDelegate?

    private enum ViewConstants {
        static let Padding: CGFloat = 10
        static let Dimensions: CGFloat = 100
        static let Offsets: CGFloat = 100
    }

    private let scroller = UIScrollView()

    private var contentViews = [UIView]()

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func initializeScrollView() {
        addSubview(scroller)

        scroller.translatesAutoresizingMaskIntoConstraints = false
        scroller.delegate = self

        NSLayoutConstraint.activate([
            scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scroller.topAnchor.constraint(equalTo: self.topAnchor),
            scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollerTapped(getture:)))
        scroller.addGestureRecognizer(tapRecognizer)
    }

    func scrollToView(at index: Int, animated: Bool = true) {
        let centralView = contentViews[index]
        let targetCenter = centralView.center
        let targetOffSetX = targetCenter.x - (scroller.bounds.width / 2)
        scroller.setContentOffset(CGPoint(x: targetOffSetX, y: 0), animated: animated)

    }

    @objc func scrollerTapped(getture: UITapGestureRecognizer) {
        let location = getture.location(in: scroller)
        guard let index = contentViews.index(where: { $0.frame.contains(location)}) else { return }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
        scrollToView(at: index)
    }

    func view(at index :Int) -> UIView {
        return contentViews[index]
    }

    func reload() {
        guard let dataSource = dataSource else { return }

        contentViews.forEach { $0.removeFromSuperview() }

        var xValue = ViewConstants.Offsets

        contentViews = (0..<dataSource.numberOfViews(in: self)).map { index in
            xValue += ViewConstants.Padding
            let view = dataSource.horizontalScrollerView(self, viewAt: index)
            view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.Padding, width: ViewConstants.Dimensions, height: ViewConstants.Dimensions)
            scroller.addSubview(view)
            xValue += ViewConstants.Dimensions + ViewConstants.Padding
            return view
        }
        scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.Offsets), height: frame.size.height)
    }

    fileprivate func centerCurrentView() {
        let centerRect = CGRect(
            origin: CGPoint(x: scroller.bounds.midX - ViewConstants.Padding, y: 0),
            size: CGSize(width: ViewConstants.Padding, height: bounds.height)
        )

        guard let selectedIndex = contentViews.index(where: { $0.frame.intersects(centerRect) })
            else { return }
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)

        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
    }
}

extension HorizontalScrollerView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}

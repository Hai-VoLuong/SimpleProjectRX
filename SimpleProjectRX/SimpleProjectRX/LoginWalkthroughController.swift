//
//  LoginWalkthroughController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

protocol LoginWalkthroughDelegate: class {
    func finishLoggingIn()
    func finishlogOut()
}

final class LoginWalkthroughController: UIViewController, LoginWalkthroughDelegate {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    let pages: [Page] = {
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipient's first book is on us.", imageName: "page1")

        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")

        let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
        return [firstPage, secondPage, thirdPage]
    }()

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()

    lazy var skipButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Skip", for: .normal)
        bt.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
         bt.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
        return bt
    }()

    @objc private func skipPage() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }

    lazy var nextButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Next", for: .normal)
        bt.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        bt.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return bt
    }()

    @objc private func nextPage() {
        // last page
        if pageControl.currentPage == pages.count {
            return
        }

        if pageControl.currentPage == pages.count - 1 {
            moveControlContraintOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }

    func finishLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNaviController else { return }
        mainNavigationController.viewControllers = [TabbarController()]
        UserDefaults.standard.setIsLoggedIn(value: true)
        dismiss(animated: true, completion: nil)
    }

    func finishlogOut() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let _ = rootViewController as? MainNaviController else { return }
        UserDefaults.standard.setIsLoggedIn(value: false)
        let login = LoginWalkthroughController()
        present(login, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observekeyboardNotification()
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        setupCollectionview()
    }

    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipAnchor: NSLayoutConstraint?
    var nextAnchor: NSLayoutConstraint?

    fileprivate func setupCollectionview() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)

        pageControlBottomAnchor = pageControl.anchorLayout(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]

        skipAnchor = skipButton.anchorLayout(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first

        nextAnchor = nextButton.anchorLayout(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first

       collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        regiseterCell()
    }

    fileprivate func regiseterCell() {
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: "loginCell")
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func observekeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHire), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc private func keyboardHire() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    @objc private func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    // Tracking Current Page
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageCurrent = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageCurrent
        if pageCurrent == pages.count {
           moveControlContraintOffScreen()
        } else {
            pageControlBottomAnchor?.constant = 0
            nextAnchor?.constant = 16
            skipAnchor?.constant = 16
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }

    private func moveControlContraintOffScreen() {
        pageControlBottomAnchor?.constant = 40
        nextAnchor?.constant = -80
        skipAnchor?.constant = -80
    }

    // Tracking when Landscape and portrait device
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        DispatchQueue.main.async { [weak self] in
            guard let this = self else { return }
            this.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            this.collectionView.reloadData()
        }
    }
}

extension LoginWalkthroughController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginCell", for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

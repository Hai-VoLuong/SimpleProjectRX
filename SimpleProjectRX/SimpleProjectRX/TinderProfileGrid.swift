//
//  TinderProfileGrid.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class TinderProfileGrid: UIViewController {

    @IBOutlet private weak var collectionview: UICollectionView!

    let headerId = "headerId"
    let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tinder Profile Grid"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
        }
        collectionview.register(UINib(nibName: "Header", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.backgroundColor = .yellow
        collectionview.dataSource = self
        collectionview.delegate = self

    }
}

extension TinderProfileGrid: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
}


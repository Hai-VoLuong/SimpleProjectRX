//
//  AlbumViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/22/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import Photos
import RxSwift

final class AlbumViewController: UIViewController {

    // MARK: - @IBoutlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - private properties
    fileprivate lazy var images = AlbumViewController.loadImages()
    fileprivate lazy var imageManager = PHCachingImageManager()

    fileprivate let selectedImageSubject = PublishSubject<UIImage>()


    // MARK: - Public properties
    let bag = DisposeBag()
    var selectedImage: Observable<UIImage> {
        return selectedImageSubject.asObservable()
    }

    // MARk: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "album view"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // Func get image
    static func loadImages() -> PHFetchResult<PHAsset> {
        let allImagesOptions = PHFetchOptions()
        allImagesOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allImagesOptions)
    }
}

// MARK: - UICollectionViewDataSource
extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let asset = images.object(at: indexPath.item)

        imageManager.requestImage(for: asset, targetSize: CGSize(width: 50, height: 50), contentMode: .aspectFill, options: nil, resultHandler: {
            images , _ in
            cell.layer.contents = images?.cgImage
        })
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = images.object(at: indexPath.item)

        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.alpha = 0.5
            UIView.animate(withDuration: 0.5, animations: {
                cell.alpha = 1
            })
        }
        imageManager.requestImage(for: asset, targetSize: view.frame.size, contentMode: .aspectFill, options: nil, resultHandler: {
            [weak self] image, info in
            guard let image = image,let info = info else { return }

            if let isThumbnail = info[PHImageResultIsDegradedKey as NSString] as? Bool, !isThumbnail {
                guard let this = self else { return }
                this.selectedImageSubject.onNext(image)
                this.dismiss(animated: true, completion: nil)
            }
        })
    }
}

//
//  MultipleCellViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.contentMode = .scaleAspectFill
        image.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()

    func setupView() {
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

    }
}

class TextCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()

    func setupView() {
        addSubview(textLabel)
        backgroundColor = .red
        textLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
}

final class MultipleCellViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "multiple cell"
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "TextCell")
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.dataSource = self
    }
}

extension MultipleCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath)
        return cell
    }
}

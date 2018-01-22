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
    var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()

    func setupView() {
        addSubview(textLabel)
        backgroundColor = .green
        textLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
}

final class MultipleCellViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    let bag = DisposeBag()

    enum MyCellModel {
        case text(String)
        case image(UIImage)
    }

    let obsevable: Observable<[MyCellModel]> = Observable.of([
        .text("home"),.image(#imageLiteral(resourceName: "home_1")),
        .text("info"),.image(#imageLiteral(resourceName: "me_1")),
        .text("favo"),.image(#imageLiteral(resourceName: "favor_1")),
        .text("tam"), .text("thu")
        ])

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "multiple cell"
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "TextCell")
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")

        obsevable.bind(to: collectionView.rx.items) { (collectionView: UICollectionView, index: Int, element: MyCellModel) in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .text(let title):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath)
                if let cell = cell as? TextCollectionViewCell {
                    cell.textLabel.text = title
                }
                return cell

            case .image(let image):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
                    if let cell = cell as? PhotoCollectionViewCell {
                        cell.imageView.image = image
                }
                return cell
            }
        }.addDisposableTo(bag)

        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let this = self else { return }
                this.showAlert(message: "Items select \(indexPath.row)")
        }).addDisposableTo(bag)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "demo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


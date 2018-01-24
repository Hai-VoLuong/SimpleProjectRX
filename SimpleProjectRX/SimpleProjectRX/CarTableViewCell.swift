//
//  CarTableViewCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/24/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MVVM

final class CarTableViewCell: UITableViewCell, MVVM.View {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var powerLabel: UILabel!

    private let bag = DisposeBag()

    var viewModel: CarViewModel? {
        didSet {
            updateView()
        }
    }

    func updateView() {

        guard let viewModel = viewModel else { return }
        
        viewModel.titleText
            .bind(to: titleLabel.rx.text)
            .addDisposableTo(bag)

        viewModel.horsepowerText
            .bind(to: powerLabel.rx.text)
            .addDisposableTo(bag)

        guard let url = viewModel.photoURL else { return }
        URLSession.shared.rx.data(request: URLRequest(url: url))
            .subscribe(onNext: { [weak self] data in
                guard let this = self else { return }
                DispatchQueue.main.async {
                    this.photoImageView.image = UIImage(data: data)
                }
            }).addDisposableTo(bag)
    }
}

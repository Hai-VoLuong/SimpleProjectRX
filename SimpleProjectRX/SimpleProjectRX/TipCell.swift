//
//  TipCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/1/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import MVVM
import Kingfisher

struct TipModel {
    var title: String
    var subtitle: String
    var timeStamp: String
    var avatarURL: URL?
}

final class TipCell: UITableViewCell , MVVM.View {

    // MARK: - IBoutlets
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!

    // MARK: - Properties
    var viewModel: TipModel? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        self.titleLabel.text = viewModel?.title
        self.subtitleLabel.text = viewModel?.subtitle
        self.createdAtLabel.text = viewModel?.timeStamp
        self.thumbImageView.layer.cornerRadius = 30
        self.thumbImageView.layer.masksToBounds = true
        self.thumbImageView.kf.setImage(with: viewModel?.avatarURL)
    }
}

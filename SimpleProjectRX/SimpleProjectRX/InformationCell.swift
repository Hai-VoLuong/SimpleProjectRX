//
//  InformationCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/1/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import MVVM

struct InformationModel {
    let title: String
    var content: String
}

final class InformationCell: UITableViewCell, MVVM.View {

    // MARK: - IBoutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    // MARK: - Properties
    var viewModel: InformationModel? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        self.titleLabel.text = viewModel?.title
        self.contentLabel.text = viewModel?.content
    }

}

//
//  MoVieCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let movieImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40
        iv.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()

    let movieTitleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .left
        l.textColor = .white
        return l
    }()

    let dateLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        l.textAlignment = .left
        l.textColor = .white
        return l
    }()

    var priceLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .right
        l.textColor = .white
        return l
    }()

    func displayMovieInCell(using viewModel: MovieViewModel) {
        movieTitleLabel.text = viewModel.title
        dateLabel.text = viewModel.releaseDate
        priceLabel.text = viewModel.purchasePrice
    }

    private func setUpViews() {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        addSubview(movieImage)
        movieImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true

        addSubview(priceLabel)
        priceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        addSubview(movieTitleLabel)
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        movieTitleLabel.leftAnchor.constraint(equalTo: movieImage.rightAnchor, constant: 10).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -10).isActive = true
        movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(dateLabel)
        dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: movieTitleLabel.leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: movieTitleLabel.rightAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive = true
    }
}

//
//  VenueDetailViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/31/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    var venue = Venue()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        print(venue.name)
    }
}

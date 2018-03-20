//
//  ExpandableNames.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames {
    var isExpanded: Bool
    var names: [FavoritableContact]
}


struct FavoritableContact {
    var contact: CNContact
    var hasFavorite: Bool
}

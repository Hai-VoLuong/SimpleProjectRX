//
//  SwinjectStoryboard.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard
{
    class func setup ()
    {
        Container.loggingFunction = nil

        defaultContainer.register(RepoServiceProtocol.self, factory: { _ in return RepoService() })
    }
}


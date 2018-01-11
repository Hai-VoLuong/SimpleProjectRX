//
//  HTTPClient.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

// handle the remote communication

class HTTPClient {

    @discardableResult func getRequest(_ url: String) -> AnyObject {
        return Data() as AnyObject
    }

    @discardableResult func postRequest(_ url: String, body: String) -> AnyObject {
        return Data() as AnyObject
    }

    func downloadImage(_ url: String) -> UIImage? {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }

}


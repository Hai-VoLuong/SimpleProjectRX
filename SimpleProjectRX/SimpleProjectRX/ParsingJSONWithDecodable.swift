//
//  ParsingJSONWithDecodable.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/7/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

// https://api.letsbuildthatapp.com/jsondecodable/course
/*
 {
 "id": 1,
 "name": "Instagram Firebase",
 "link": "https://www.letsbuildthatapp.com/course/instagram-firebase",
 "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/04782e30-d72a-4917-9d7a-c862226e0a93"
 }
 */

struct Course {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

class ParsingJSONWithDecodable: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing JSON With Decodable"

        let jsonString = "https://api.letsbuildthatapp.com/jsondecodable/course"

        guard let url = URL(string: jsonString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            print(dataString)
        }.resume()

    }
}

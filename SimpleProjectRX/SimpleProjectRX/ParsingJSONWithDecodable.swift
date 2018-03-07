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

    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }
}

class ParsingJSONWithDecodable: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing JSON With Decodable"

        let jsonString = "https://api.letsbuildthatapp.com/jsondecodable/course"

        guard let url = URL(string: jsonString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] else { return }
                let course = Course(json: json)
                print(course)
            } catch let err {
                print("error serializing json, \(err.localizedDescription)")
            }


        }.resume()

    }
}

//
//  ParsingJSONWithDecodable.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/7/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

/*
 1 --> https://api.letsbuildthatapp.com/jsondecodable/course

 {
     "id": 1,
     "name": "Instagram Firebase",
     "link": "https://www.letsbuildthatapp.com/course/instagram-firebase",
     "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/04782e30-d72a-4917-9d7a-c862226e0a93"
 }

2 --> https://api.letsbuildthatapp.com/jsondecodable/courses

 [
     {
         "id": 1,
         "name": "Instagram Firebase",
         "link": "https://www.letsbuildthatapp.com/course/instagram-firebase",
         "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/04782e30-d72a-4917-9d7a-c862226e0a93"
         },
         {
         "id": 3,
         "name": "Kindle Basic Training",
         "link": "https://www.letsbuildthatapp.com/basic-training",
         "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/a6180731-c077-46e7-88d5-4900514e06cf"
     }
 ]

 */

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    // let imageUrl: String
}

class ParsingJSONWithDecodable: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing JSON With Decodable"

        let jsonString1 = "https://api.letsbuildthatapp.com/jsondecodable/course"
        let jsonString2 = "https://api.letsbuildthatapp.com/jsondecodable/courses"

        guard let url = URL(string: jsonString2) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
            } catch let err {
                print("error serializing json, \(err.localizedDescription)")
            }


        }.resume()

    }
}

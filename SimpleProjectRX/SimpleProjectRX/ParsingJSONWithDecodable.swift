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

 3 --> https://api.letsbuildthatapp.com/jsondecodable/website_description

 {
     "name": "Lets Build That App",
     "description": "Teaching and Building Apps since 1999",
     "courses": [
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
 }

 4 --> https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields

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
     },
     {
         "name": "Yelp"
     }
 ]

 tham khao: https://grokswift.com/json-swift-4/

 */

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let temp: Bool = false
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
}


class ParsingJSONWithDecodable: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Parsing JSON With Decodable"

        getJson { (courses) in
            print(courses)
        }
    }

    private func getJson(completion: @escaping ([Course]) -> ()) {

        let jsonString1 = "https://api.letsbuildthatapp.com/jsondecodable/course"
        let jsonString2 = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        let jsonString3 = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        let jsonString4 = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"

        guard let url = URL(string: jsonString4) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                completion(courses)
            } catch let err {
                print("error serializing json, \(err.localizedDescription)")
            }
            }.resume()
    }
}

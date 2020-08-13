//
//  Post.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-12.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

struct Post {
    
    let author: String
    let title: String?
    let selftext: String?
    let thumbnail: String?
    let thumbnail_width: Int?
    let thumbnail_height: Int?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum dataInfoKeys: String, CodingKey {
        case author
        case title
        case selftext
        case thumbnail
        case thumbnail_width
        case thumbnail_height
    }
}

extension Post: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataInfo = try values.nestedContainer(keyedBy: dataInfoKeys.self, forKey: .data)
        
        author = try dataInfo.decode(String.self, forKey: .author)
        title = try? dataInfo.decode(String.self, forKey: .title)
        selftext = try? dataInfo.decode(String.self, forKey: .selftext)
        thumbnail = try? dataInfo.decode(String.self, forKey: .thumbnail)
        thumbnail_width = try? dataInfo.decode(Int.self, forKey: .thumbnail_width)
        thumbnail_height = try? dataInfo.decode(Int.self, forKey: .thumbnail_height)
    }
}

//
//  Posts.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-12.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

struct Posts {
    
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum dataInfoKeys: String, CodingKey {
        case posts = "children"
    }
}

extension Posts: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataInfo = try values.nestedContainer(keyedBy: dataInfoKeys.self, forKey: .data)
        
        posts = try dataInfo.decode([Post].self, forKey: .posts)
    }
}


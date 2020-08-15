//
//  PostViewModel.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

struct PostViewModel {
    
    var author: String
    var title: String?
    var selftext: String?
    var thumbnail: String?
    var thumbnail_width: Int?
    var thumbnail_height: Int?
    // media like youtube
    var mediaContent: String?
    
    init(dataModel: Post) {
        self.author = dataModel.author
        self.title = dataModel.title
        self.selftext = dataModel.selftext
        self.thumbnail = dataModel.thumbnail
        self.thumbnail_width = dataModel.thumbnail_width
        self.thumbnail_height = dataModel.thumbnail_height
        self.mediaContent = dataModel.media_embed?.content
    }
}

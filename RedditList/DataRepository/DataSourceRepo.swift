//
//  DataSource.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-12.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

class DataSourceRepo {
    
    static let shared = DataSourceRepo()
    
    private var posts: [Post] = []
    private var fetchErr: Error?
    
    private init() {}
    
    func fetchPosts() {
        let postRouter = RedditAPI.posts(queryParas: nil, bodyParas: nil)
        do {
            let netRequest = try postRouter.getURLRequest()
            postRouter.netWorks(request: netRequest) { [unowned self] result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(Posts.self, from: data)
                        self.posts = jsonData.posts
                    } catch let errData {
                        self.fetchErr = errData
                    }
                case .failure(let err):
                    self.fetchErr = err
                }
            }
        } catch let error {
            self.fetchErr = error
        }
    }
    
    
}

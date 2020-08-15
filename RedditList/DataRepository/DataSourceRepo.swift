//
//  DataSourceRepo.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-12.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

class DataSourceRepo {
    
    // datasource update listening
    typealias Listener = (Result42<[Post], Error>) -> ()
    
    static let shared = DataSourceRepo()
    
    private var listeners: [Listener]
    
    private var posts: [Post] {
        didSet {
            let newResult = Result42<[Post], Error>.success(posts)
            for listener in listeners {
                listener(newResult)
            }
        }
    }
    private var fetchErr: Error? {
        didSet {
            if let err = fetchErr {
                let newResult = Result42<[Post], Error>.failure(err)
                for listener in listeners {
                    listener(newResult)
                }
            }
        }
    }
    
    private init() {
        posts = []
        listeners = []
    }
    
    func addListener(listener: @escaping Listener) {
        self.listeners.append(listener)
    }
    
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

//
//  PostsListViewModel.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import Foundation

class PostsListViewModel {
    
    // 'PostsListViewModel' update listening
    typealias Listener = (Result42<[PostViewModel], Error>) -> ()
    
    private var listeners: [Listener]
    
    private var postsList: [PostViewModel] {
        didSet {
            let newResult = Result42<[PostViewModel], Error>.success(postsList)
            for listener in listeners {
                listener(newResult)
            }
        }
    }
    
    private var err: Error? {
        didSet {
            if let err = err {
                let newResult = Result42<[PostViewModel], Error>.failure(err)
                for listener in listeners {
                    listener(newResult)
                }
            }
        }
    }
    
    init() {
        postsList = []
        listeners = []
    }
    
    func bindTo(dataSource: DataSourceRepo) {
        dataSource.addListener { [unowned self] (result) in
            switch result {
            case .success(let posts):
                self.postsList = posts.map({PostViewModel(dataModel: $0)})
            case .failure(let err):
                self.err = err
            }
        }
    }
    
    func addListener(listener: @escaping Listener) {
        self.listeners.append(listener)
    }
}


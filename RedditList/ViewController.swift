//
//  ViewController.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-12.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    let dS = DataSourceRepo.shared
    let vm = PostsListViewModel()
    
    @IBOutlet weak var lbl11: UILabel!
    @IBOutlet weak var lbl22: UILabel!
    
    var list: [PostViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp() {
        vm.bindTo(dataSource: dS)
        vm.addListener { [unowned self] (result) in
            switch result {
            case .success(let posts):
                self.list = posts
                self.updateView()
            case .failure(let err):
                print(err)
            }
        }
        dS.fetchPosts()
    }
    
    func updateView() {
        lbl11.text = self.list[0].author
        lbl22.text = self.list[0].selftext
    }
}


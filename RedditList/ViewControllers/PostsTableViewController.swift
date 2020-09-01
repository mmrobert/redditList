//
//  PostsTableViewController.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import UIKit

// table view to 'main' view

class PostsTableViewController: UITableViewController {
    
    private let dataRepo = DataSourceRepo.shared
    private let postListViewModel = PostsListViewModel()
    
    private var postList: [PostViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Swift News"
        setUp()
    }
    
    // wire up view model with dataSource
    // then add listener to view model
    private func setUp() {
        postListViewModel.bindTo(dataSource: dataRepo)
        postListViewModel.addListener { [unowned self] (result) in
            switch result {
            case .success(let posts):
                self.postList = posts
                self.tableView.reloadData()
            case .failure(let err):
                print("Error: \(err)")
            }
        }
        dataRepo.fetchPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PostTableViewCell
        
        let post = self.postList[indexPath.row]
        cell.setupCell(postViewModel: post)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postList.count - 1 {
            dataRepo.fetchNextPosts(queryParas: ["after": "t3_icpc67"])
        }
    }

    // MARK: - Navigation

    // when tap list item, navigate to detail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
            let viewController = navigationController.topViewController as? PostDetailViewController
            else {
                return
        }
        
        if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
            viewController.post = self.postList[selectedRowIndexPath.row]
        }
    }
}

//
//  PostsRootViewController.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-14.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import UIKit

class PostsRootViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    // to show table view when first lauched
    // otherwise to show the selected item detail view
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? PostDetailViewController else { return false }
        if topAsDetailController.post == nil {
            // Return true to show table view when first lauched
            // meaning no item is selected
            return true
        }
        return false
    }
}

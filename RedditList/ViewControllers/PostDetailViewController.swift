//
//  PostDetailViewController.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import UIKit
import SDWebImage

class PostDetailViewController: UIViewController {
    
    var post: PostViewModel?
    
    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var postBody: UILabel!
    
    // used to control the image real size from API
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var thumbnailWidth: NSLayoutConstraint!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // to show "back" button on navigation bar left
        // for sliding in list when in ipad portrait
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        
        self.title = self.post?.title
        
        setupUI()
    }
    
    private func setupUI() {
        if let width = self.post?.thumbnail_width, let height = self.post?.thumbnail_height {
            // if thumbnail image exist
            self.thumbnailImg.isHidden = false
            self.thumbnailWidth.constant = CGFloat(width)
            self.thumbnailHeight.constant = CGFloat(height)
            self.imgTop.constant = 20
            if let urlStr = self.post?.thumbnail {
                // SDWebImage framework for image loading from net
                self.thumbnailImg.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: "imgplaceholder"))
            }
        } else {
            self.thumbnailImg.isHidden = true
            self.thumbnailHeight.constant = 0
            self.imgTop.constant = 0
        }
        
        self.postBody.text = post?.selftext
    }

}

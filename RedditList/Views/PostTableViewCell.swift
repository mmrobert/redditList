//
//  PostTableViewCell.swift
//  RedditList
//
//  Created by boqian cheng on 2020-08-13.
//  Copyright © 2020 boqiancheng. All rights reserved.
//

import UIKit
import SDWebImage

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postThumbnail: UIImageView!
    
    @IBOutlet weak var thumbnailWidth: NSLayoutConstraint!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    @IBOutlet weak var thumbnailTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setAppearance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setAppearance() {
        
        self.containerView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
        self.containerView.layer.cornerRadius = 5.0
        self.containerView.clipsToBounds = true
    }
    
    func setupCell(postViewModel: PostViewModel) {
        postTitle.text = postViewModel.title
        if let width = postViewModel.thumbnail_width, let height = postViewModel.thumbnail_height {
            // if thumbnail exists
            postThumbnail.isHidden = false
            thumbnailWidth.constant = CGFloat(width)
            thumbnailHeight.constant = CGFloat(height)
            thumbnailTop.constant = 15
            if let urlStr = postViewModel.thumbnail {
                postThumbnail.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: "imgplaceholder"))
            }
        } else {
            postThumbnail.isHidden = true
            thumbnailHeight.constant = 0
            thumbnailTop.constant = 0
        }
    }
}

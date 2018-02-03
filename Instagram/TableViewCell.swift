//
//  TableViewCell.swift
//  Instagram
//
//  Created by Rohan Gupta on 1/30/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TableViewCell: UITableViewCell {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var photoView: PFImageView!
    @IBOutlet var dateLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            self.usernameLabel.text = post["author"] as? String
            self.dateLabel.text = "\(post.createdAt!)"
            self.photoView.file = post["media"] as? PFFile
            self.captionLabel.text = post["caption"] as? String
            self.photoView.loadInBackground()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

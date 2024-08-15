//
//  FeedCell.swift
//  Snapchat-Clone
//
//  Created by Sabri Çetin on 12.08.2024.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedİmageView: UIImageView!
    @IBOutlet weak var feedUsernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

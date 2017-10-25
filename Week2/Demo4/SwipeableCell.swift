//
//  SwipeableCell.swift
//  week2
//
//  Created by 1111 on 2017/10/25.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class SwipeableCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var model:FriendModel? = nil{
        didSet{
            if model != nil
            {
                img.image = model?.image
                title.text = model?.name
            }
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

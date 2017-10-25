//
//  PhoneListCell.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class PhoneListCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var friendModel:FriendModel? = nil{
        didSet{
            if friendModel != nil{
                img.image = friendModel?.image
                name.text = friendModel?.name
            }
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

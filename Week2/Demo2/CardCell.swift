//
//  CardCell.swift
//  week2
//
//  Created by 1111 on 2017/10/24.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var notesLabel: UILabel!
    
    var friend:FriendModel? = nil{
        didSet{
            if friend != nil {
                img.image = friend?.image
                notesLabel.text = friend?.notes
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.layer.masksToBounds = true
//        self.contentView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5
    }

}

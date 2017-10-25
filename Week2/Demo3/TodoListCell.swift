//
//  TodoListCell.swift
//  week2
//
//  Created by 1111 on 2017/10/24.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class TodoListCell: UITableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model:TodoModel? = nil{
        didSet{
            if model != nil {
                img.image = gIMGName(name: (model!.img! + String(2)))
                titleLabel.text = model?.todo
                timeLabel.text = model?.time
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

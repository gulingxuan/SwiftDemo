//
//  Demo3Cell.swift
//  SwiftThreeWeek
//
//  Created by 顾泠轩 on 2017/11/5.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit

class Demo3Cell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    var model:Demo3Model? = nil {
        didSet{
            if model == nil
            {
                return
            }
            imgView.image = model?.img
            btn.isSelected = model!.isCollect
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func collectClick(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        model?.isCollect = btn.isSelected
    }
    
    
    
    

}

//
//  Demo3Model.swift
//  SwiftThreeWeek
//
//  Created by 顾泠轩 on 2017/11/5.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit

class Demo3Model: NSObject {

    var img:UIImage?
    var isCollect = false
    
    init(img:UIImage?)
    {
        self.img = img
    }
    
    override required init() {
        super .init()
    }
    
    
    
}

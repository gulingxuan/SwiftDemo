//
//  TodoModel.swift
//  week2
//
//  Created by 1111 on 2017/10/24.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    
    var img:String?
    var todo:String?
    var time:String?
    
    convenience override init() {
        self.init()
    }
    
    init(dict:[String:String])
    {
        super.init()
        setValuesForKeys(dict)
    }
    
    class func todoModels(array:[[String:String]]) ->[TodoModel]
    {
        var models:[TodoModel] = []
        for dic in array
        {
            let model = TodoModel(dict: dic)
            models.append(model)
        }
        
        return models
    }
    
}

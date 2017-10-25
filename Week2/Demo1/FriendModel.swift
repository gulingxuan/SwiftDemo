//
//  FriendModel.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class FriendModel: NSObject {

    var image:UIImage?
    var name:String?
    var mobile:String?
    var email:String?
    var notes:String?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "img" {
            image = gIMGName(name: value as! String)
        }
    }
    
    init(dict:[String:String])
    {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override init() {
        super.init()
    }
    
    class func friendsWithArray(array:[[String:String]]) -> Array<FriendModel>
    {
        var friends:[FriendModel] = []
        for dic in array
        {
            let model = FriendModel(dict: dic)
            friends.append(model)
        }
        return friends
    }


    
}

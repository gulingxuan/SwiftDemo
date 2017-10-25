//
//  InfoCardViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class InfoCardViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesHeight: NSLayoutConstraint!
    
    var model:FriendModel?
    
    var friendModel:FriendModel? = nil{
        didSet{
            if friendModel != nil {
                img.image = friendModel!.image
                nameLabel.text = friendModel!.name
                
                let phone = changePhone(phone: friendModel!.mobile!)

                
                mobileLabel.text = phone
                emailLabel.text = friendModel!.email
                
                let str = friendModel!.notes
                
                let height = getTextHeigh(textStr: str!, font: notesLabel.font, width: SCW - 50)
                
                if height >= 25 {
                    notesHeight.constant = height + 5

                }
                
                notesLabel.numberOfLines = 0
                notesLabel.text = str
            }
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Info Card"
        navigationController?.navigationBar.tintColor = UIColor.white
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightItem
        
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 40
        friendModel = model
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changePhone(phone:String) -> String
    {
        let index1 = phone.index(phone.startIndex, offsetBy: 4)
        let phone1 = phone.substring(to: index1)

        let index3 = phone.index(phone.endIndex, offsetBy: -4)
        let phone3 = phone.substring(from: index3)
        
        let phone2 = phone[index1..<index3]
        
        let phoneNum = phone1 + "-" + phone2 + "-" + phone3
        return phoneNum

    }
   
}

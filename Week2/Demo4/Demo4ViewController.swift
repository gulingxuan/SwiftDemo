//
//  Demo4ViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo4ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var dataArr:[FriendModel] = {
        () -> [FriendModel] in
        let arr = NSArray(contentsOfFile: (Bundle.main.path(forResource: "PhoneList.plist", ofType: nil))!) as! [[[String:String]]]
        return FriendModel.friendsWithArray(array: arr.last!)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swipeable"
        createUI()
        
    }

    
    //MARK: ------------------- UI -------------------
    func createUI()
    {
        let tableView = UITableView(frame: view.bounds);
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SwipeableCell", bundle: nil), forCellReuseIdentifier: "SwipeableCell")
        view.addSubview(tableView)
        
    }
    
    //MARK: ------------------- TV代理 -------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwipeableCell", for: indexPath) as! SwipeableCell
        cell.model = dataArr[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action1 = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "🙂\n删除") { (action, indexPath) in
            self.dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let action2 = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "😁\n分享") { (action, indexPath) in
            let model = self.dataArr[indexPath.row]
            let share = UIActivityViewController(activityItems: [model.image,model.name,model.notes!], applicationActivities: nil)
            self.present(share, animated: true, completion: nil)
        }
        action2.backgroundColor = UIColor.blue
        
        let action3 = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "✈️\nDownload") { (action, indexPath) in
            
        }
        action3.backgroundColor = UIColor.lightGray
        return [action3,action2,action1]
    }
    
    
    

}

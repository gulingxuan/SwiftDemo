//
//  Demo1ViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataArr:[[FriendModel]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        createUI()
        
    }

    
    //MARK: ------------------- UI -------------------
    func createUI()
    {
        
        //导航
        navigationController?.navigationBar.barTintColor = RGBA(R: 0, G: 142, B: 246, A: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        title = "Contacts"
        let leftBtn = createButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25) , backImage: gIMGName(name: "set"))
        leftBtn.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.leftBarButtonItem = leftItem
        
        let rightBtn = createButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25), backImage: gIMGName(name: "add"))
        let rightItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem = rightItem
        
        
        let tableView = UITableView(frame: view.bounds);
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "PhoneListCell", bundle: nil), forCellReuseIdentifier: "PhoneListCell")
        view.addSubview(tableView)
        
        
        
    }

    //MARK: ------------------- 数据处理 -------------------
    func initData()
    {
        let filePath = Bundle.main.path(forResource: "PhoneList.plist", ofType: nil)
        let arr = NSArray(contentsOfFile: filePath!)!
        let array = arr as! [[[String:String]]]
        
        for friendArr in array
        {
            dataArr.append(FriendModel.friendsWithArray(array: friendArr))
        }

    }
    
    
    
    
    
    
    //MARK: ------------------- Event事件处理 -------------------
    @objc func goBack()
    {
        navigationController?.popViewController(animated: true)
    }
    

    //MARK: ------------------- TableView -------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneListCell", for: indexPath) as! PhoneListCell
        cell.friendModel = dataArr[indexPath.section][indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hview = UIView(frame: CGRect(x: 0, y: 0, width: SCW, height: 40))
        hview.backgroundColor = RGBA(R: 244, G: 244, B: 244, A: 244)
        let label = createLabel(frame:CGRect(x: 20, y: 0, width: 150, height: 40), text: section == 0 ? "RECENT" : "FRIENDS", titleColor: RGBA(R: 89, G: 70, B: 56, A: 1), fontSize: 13)
        hview.addSubview(label)
        return hview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = dataArr[indexPath.section][indexPath.row]
        let ic = InfoCardViewController(nibName: "InfoCardViewController", bundle: nil)
        ic.model = friend
        navigationController?.pushViewController(ic, animated: true)
    }
    

}





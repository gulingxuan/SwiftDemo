//
//  Demo2ViewController.swift
//  SwiftWeek1
//
//  Created by 1111 on 2017/10/18.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var tvArr:[[String]] = []
    var sectionArr:[String] = []
    
    let dataArr = [["A":["Aaa","Abb","Acc","Add"]],["B":["Baa","Bbb","Bcc","Bdd"]],["D":["Daa","Dbb","Dcc","Ddd"]],["H":["Haa","Hbb","Hcc","Hdd"]],["T":["Taa","Tbb","Tcc","Tdd"]],["Z":["Zaa","Zbb","Zcc","Zdd","Zee","Zff","Zgg","Zhh","Zii","Zjj","Zkk","Zll","Zmm","Znn","Zoo","Zpp","Zqq","Zrr","Zss","Ztt","Zuu","Zvv","Zww","Zxx"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Demo2"
        createUI()
        initData()
    }
    
    func createUI()
    {
        let tv = UITableView.init(frame:CGRect(x: 0.0 , y: 0.0, width: SCW, height: SCH))
        tv.separatorStyle = UITableViewCellSeparatorStyle.none
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.sectionIndexColor = UIColor.blue
        tv.sectionIndexTrackingBackgroundColor = UIColor.clear
        tv.sectionIndexBackgroundColor = UIColor.clear
        
        view.addSubview(tv)
        self.tableView = tv
    }
    
    func initData()
    {
        for (_,value) in dataArr.enumerated()
        {
            for (key,dValue) in value
            {
                tvArr.append(dValue)
                sectionArr.append(key)
            }
        }
        tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tvArr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvArr[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CellID")
        }
        cell?.textLabel?.text = tvArr[indexPath.section][indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sview = UIView(frame: CGRect(x: 0, y: 0, width: SCW, height: 40))
        sview.backgroundColor = RGBA(R: 242, G: 242, B: 242, A: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 120, height: 40))
        label.textColor = UIColor.blue
        label.text = sectionArr[section]
        sview.addSubview(label)
        return sview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionArr
    }


}

//
//  TableView.swift
//  SwiftDemo4-2
//
//  Created by 1111 on 2017/10/14.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit
import SnapKit

protocol TableViewDelegate {
    func updateViewHeight(height:CGFloat,tableView:TableView)
}


class TableView: UIView,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView?
    var delegate:TableViewDelegate?
    var countries:[String]?
    var cities:[String:[String]]?
    var isOpenSection = false
    var sectionIndex:Int?
    var sectionDic = [0:0,1:0]
    
    var heightConstrains:Constraint?
    
    init(frame:CGRect,title:String,countries:[String],cities:[String:[String]])
    {
        super.init(frame: frame)
        self.countries = countries
        self.cities = cities
        setupSubView(title: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: ------------------- UI -------------------
    func setupSubView(title:String)
    {
        let tv = UITableView(frame: CGRect.zero)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = UITableViewCellSeparatorStyle.none
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        tv.tableHeaderView = headerView(titleStr: title)
        addSubview(tv)
        tv.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self)
        }
        tableView = tv;
        
    }
    
    //tableViewHeaderView -- 头部视图
    func headerView(titleStr:String) -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCW, height: 40))
        headerView.layer.cornerRadius = 4
        headerView.backgroundColor = RGBA(R: 242, G: 242, B: 242, A: 1)
        let title = UILabel(frame:CGRect(x: 15, y: 5, width: 130, height: 30))
        title.textColor = UIColor.black
        title.text = titleStr
        title.font = UIFont.systemFont(ofSize: 14)
        headerView.addSubview(title)
        
        let btn = UIButton (frame: CGRect(x: SCW - 120, y: 0, width: 100, height: 40))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.setTitle("收起", for: UIControlState.normal)
        btn.setTitle("展开", for: UIControlState.selected)
        btn.addTarget(self, action: #selector(clickBtn(btn:)), for: UIControlEvents.touchUpInside)
        headerView.addSubview(btn)
        return headerView
    }
    
    //分区头部视图
    func sectionHeaderView(sectionTitle:String,section:Int) -> UIView
    {
        let sView = UIView(frame: CGRect(x: 0, y: 0, width: SCW, height: 40))
        sView.backgroundColor = RGBA(R: 248, G: 248, B: 248, A: 0.8)
        let lable = UILabel(frame: CGRect(x: 30, y: 0, width: SCW - 40, height: 40))
        lable.textColor = RGBA(R: 50, G: 50, B: 50, A: 1)
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.text = sectionTitle
        lable.isUserInteractionEnabled = true
        let btn = UIButton(frame: CGRect(x: SCW - 110, y: 0, width: 40, height: 40))
        lable.addSubview(btn)
        btn.setTitleColor(RGBA(R: 50, G: 50, B: 50, A: 1), for: UIControlState.normal)
        btn.setTitle("+", for: UIControlState.normal)
        btn.setTitle("-", for: UIControlState.selected)
        sView.addSubview(lable)
        btn.addTarget(self, action: #selector(showCity(btn:)), for: UIControlEvents.touchUpInside)
        let rows = sectionDic[section]
        if rows != 0 {
            btn.isSelected = true
        }
        
        return sView
    }

    
    //MARK: ------------------- Event事件处理 -------------------
    
    @objc func clickBtn(btn:UIButton)
    {
        isOpenSection = false
        sectionDic = [0:0,1:0]
        if btn.isSelected
        {
            delegate?.updateViewHeight(height: 120, tableView: self)
        }
        else
        {
            delegate?.updateViewHeight(height: 40, tableView: self)
        }
        tableView?.reloadData()
        btn.isSelected = !btn.isSelected
    }
    
    @objc func showCity(btn:UIButton)
    {
        let selected = btn.isSelected
        
        btn.isSelected = selected ? false : true
        isOpenSection = true
        
        let label:UILabel = btn.superview as! UILabel
        let country:String = label.text!
        var height = 120
        sectionIndex = countries?.index(of:country)
    
        if btn.isSelected
        {
            
            let rows = cities![country]!.count
            sectionDic[sectionIndex!] = rows
        }
        else
        {
            sectionDic[sectionIndex!] = 0
        }
        
        for (_,value) in sectionDic
        {
            height += value * 40
        }
        delegate?.updateViewHeight(height:CGFloat(height) , tableView: self)
//        tableView?.reloadSections([sectionIndex!], with: UITableViewRowAnimation.fade)
        tableView?.reloadData()
    
    
    }
    
    //    MARK: ---------------- TableView代理 ----------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isOpenSection == false
        {
            return 0
        }
        
        return sectionDic[section]!
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CellID")
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.textLabel?.textColor = RGBA(R: 50, G: 50, B: 50, A: 1)

        let arr = cities![countries![indexPath.section]]!
        cell?.textLabel?.text = "        " + arr[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView(sectionTitle: countries![section],section: section)
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
    
    






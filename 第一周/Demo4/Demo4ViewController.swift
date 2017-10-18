//
//  Demo4ViewController.swift
//  SwiftWeek1
//
//  Created by 1111 on 2017/10/18.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit
import SnapKit

class Demo4ViewController: UIViewController,TableViewDelegate {

    var sv:UIScrollView?
    var tvArr:[TableView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Demo4"
        createUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUI()
    {
        sv = UIScrollView(frame: view.bounds)
        view.addSubview(sv!)
        sv!.isScrollEnabled = true
        sv?.showsVerticalScrollIndicator = false
        
        let titleArr = ["亚洲","南美洲","澳洲"]
        let countryArr = [["中国","俄罗斯"], ["巴西","阿根廷"],["澳大利亚","新西兰"]]
        let cityArr = [["中国":["北京","上海","深圳","广州"],"俄罗斯":["莫斯科","新西伯利亚","叶卡捷琳堡"]],["巴西":["巴西利亚","圣保罗"],"阿根廷":["布宜诺斯艾利斯","门多萨","圣菲","圣路易斯","胡胡伊"]],["澳大利亚":["悉尼","墨尔本","堪培拉","阿德雷德"],"新西兰":["惠灵顿","奥克兰"]]]
        
        var preTV:TableView?
        for i in 0 ..< titleArr.count {
            let tableView = TableView(frame: CGRect.zero, title: titleArr[i], countries: countryArr[i], cities: cityArr[i])
            tableView.delegate = self
            sv!.addSubview(tableView)
            
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(preTV == nil ? sv! : preTV!.snp.bottom).offset(preTV == nil ? 70 : 25)
                make.centerX.equalTo(view)
                make.width.equalTo(SCW - 40)
                tableView.heightConstrains = make.height.equalTo(120).constraint
            }
            
            preTV = tableView
            tvArr.append(tableView)
            
            
        }
        
        
    }
    
    func updateViewHeight(height: CGFloat, tableView: TableView) {
        
        tableView.heightConstrains?.deactivate()
        tableView.snp.makeConstraints { (make) in
            tableView.heightConstrains = make.height.equalTo(height).constraint
        }
        
        var svHeight:CGFloat = 150 + height
        for i in 0 ..< tvArr.count
        {
            let tv = tvArr[i]
            if tv != tableView
            {
                let hei = tv.frame.size.height
                svHeight += hei
            }
            
            sv!.contentSize = CGSize(width: SCW, height: svHeight)
        }
        
    }


}

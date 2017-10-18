//
//  Demo3ViewController.swift
//  SwiftWeek1
//
//  Created by 1111 on 2017/10/18.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit
import SnapKit

class Demo3ViewController: UIViewController {

    var time:Float = 0{
        didSet{
            self.timeLabel?.text = String(format: "%.1f", time)
        }
    }
    var timeLabel:UILabel?
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Demo3"
        createUI()
        
        
    }
    
    func createUI()
    {
        let label = createLabel(frame: CGRect(x: 0, y: 64, width: SCW, height: 200), text: "0.0", titleColor: UIColor.white, fontSize: 50,textAlignment:NSTextAlignment.center)
        label.backgroundColor = UIColor.black
        
        view.addSubview(label)
        timeLabel = label
        
        let resetBtn = createButton(frame: CGRect(x: SCW - 90, y: 90, width: 70, height: 30), title: "Reset", titleColor: UIColor.white,fontSize:14)
        resetBtn.addTarget(self, action:#selector(resetTime) , for: UIControlEvents.touchUpInside)
        view.addSubview(resetBtn)
        
        let leftView = UIView(frame: CGRect.zero)
        leftView.backgroundColor = UIColor.blue
        view.addSubview(leftView)
        
        let rightView = UIView(frame: CGRect.zero)
        rightView.backgroundColor = UIColor.green
        view.addSubview(rightView)
        
        
        let playBtn = createButton(frame: CGRect.zero, image: gIMGName(name: "play"))
        playBtn.addTarget(self, action:#selector(timingBegins) , for: UIControlEvents.touchUpInside)
        leftView.addSubview(playBtn)
        
        let stopBnt = createButton(frame: CGRect.zero, image: gIMGName(name: "zt"))
        stopBnt.addTarget(self, action:#selector(stopTiming) , for: UIControlEvents.touchUpInside)
        rightView.addSubview(stopBnt)
        
        leftView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(view)
            make.top.equalTo(label.snp.bottom)
            make.width.equalTo(view.bounds.width/2)
        }
        rightView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(view)
            make.top.equalTo(label.snp.bottom)
            make.width.equalTo(view.bounds.width/2)
        }
        
        playBtn.snp.makeConstraints { (make) in
            make.center.equalTo(leftView)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        stopBnt.snp.makeConstraints { (make) in
            make.center.equalTo(rightView)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        
    }
    
    @objc func timingBegins()
    {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(addTime), userInfo: nil, repeats: true)
    }
    
    @objc func stopTiming()
    {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func addTime()
    {
        time += 0.1
    }
    
    @objc func resetTime()
    {
        time = 0
    }

}

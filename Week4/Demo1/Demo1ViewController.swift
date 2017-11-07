//
//  Demo1ViewController.swift
//  SwiftDemos
//
//  Created by 1111 on 2017/10/30.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo1ViewController: BaseViewController {
    
    lazy var imgView:UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        iv.image = gIMGName(name: "钟表")
        return iv
    }()
    
    var hourLayer:CAShapeLayer!
    var minuteLayer:CAShapeLayer!
    var secondLayer:CAShapeLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func createUI()
    {
        view.addSubview(imgView)
        imgView.center = view.center
        setUpHourLayer()
        setUpMinuteLayer()
        setUpSecondLayer()
        
        let _ = Timer.scheduledTimer(timeInterval: 1, target:self , selector: #selector(getTime), userInfo: nil, repeats: true)
        getTime()
        
        
    }
    
    @objc func getTime()
    {
        let calender = NSCalendar.current;
        let cmp = calender.dateComponents(Set<Calendar.Component>([.second,.minute,.hour]), from: Date.init())
        let second = cmp.second
        let min = cmp.minute
        let hour = cmp.hour
        
        
        //角度转换
        let secondAngles = CGFloat(second!) * 6
        let minAngles = CGFloat(min!) * 6 + CGFloat(second!) * 0.1
        let hourAngles = CGFloat(hour!) * 30 + CGFloat(min!) * 0.5
        secondLayer.transform = CATransform3DMakeRotation(CGFloat(Double(secondAngles / 180) * Double.pi), 0, 0, 1)
        minuteLayer.transform = CATransform3DMakeRotation(CGFloat(Double(minAngles / 180) * Double.pi), 0, 0, 1)
        hourLayer.transform = CATransform3DMakeRotation(CGFloat(Double(hourAngles / 180) * Double.pi), 0, 0, 1)

    }
    
    
    //时针
    func setUpHourLayer()
    {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        layer.position = CGPoint(x: 100, y: 100)
        layer.bounds = CGRect(x: 0, y: 0, width: 4, height: 45)
        layer.cornerRadius = 4
        hourLayer = layer
        imgView.layer.addSublayer(layer)
    }
    
    //分针
    func setUpMinuteLayer()
    {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        layer.position = CGPoint(x: 100, y: 100)
        layer.bounds = CGRect(x: 0, y: 0, width: 4, height: 60)
        layer.cornerRadius = 4
        minuteLayer = layer
        imgView.layer.addSublayer(layer)
    }
    
    //秒钟
    func setUpSecondLayer()
    {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.red.cgColor
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        layer.position = CGPoint(x: 100, y: 100)
        layer.bounds = CGRect(x: 0, y: 0, width: 4, height: 75)
        layer.cornerRadius = 4
        secondLayer = layer
        imgView.layer.addSublayer(layer)
    }
    
    
    
    
    


}

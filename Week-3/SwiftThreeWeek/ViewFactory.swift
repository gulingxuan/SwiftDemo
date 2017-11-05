//
//  ViewFactory.swift
//  swiftOneWeek
//
//  Created by 贾仕琪 on 2017/10/16.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit
let SW = UIScreen.main.bounds.width;
let SH = UIScreen.main.bounds.height;

let LL_iPhoneX = (SW == 375.0 && SH == 812.0 ? true : false)
let kNavibarH = CGFloat(LL_iPhoneX ? 88.0 : 64.0)
let kTabbarH = CGFloat(LL_iPhoneX ? (49.0+34.0) : 49.0)
let kStatusbarH = CGFloat(LL_iPhoneX ? 44.0 : 20.0)
//设置RGB颜色
func RGBA(r: CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) ->UIColor
{
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func GFONT_TITLE(X:CGFloat) ->UIFont{
    return UIFont.systemFont(ofSize: X)
}
func randomColor() -> UIColor{
    let red = CGFloat(arc4random()%256)/255.0
    let green = CGFloat(arc4random()%256)/255.0
    let blue = CGFloat(arc4random()%256)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}
class ViewFactory
{
    /**
     * 控件默认尺寸
     */
    class func getDefaultFrame() -> CGRect
    {
        let defaultFrame = CGRect(x: 0, y: 0, width: 100, height: 30)
        return defaultFrame
    }
    
    class func createControl(type:String, title:[String], action:Selector, sender:AnyObject)
        -> UIView {
            switch(type)
            {
            case "label":
                return ViewFactory.createLabel(title: title[0])
            case "button":
                return ViewFactory.createButton(title: title[0], action: action,
                                                sender: sender as! UIViewController)
            case "text":
                return ViewFactory.createTextField(value: title[0],placeholder: "")
            case "segment":
                return ViewFactory.createSegment(items: title, action: action, sender:
                    sender as! UIViewController)
            default:
                return ViewFactory.createLabel(title: title[0])
            }
    }
    
    /**
     * 创建按钮控件
     */
    class func createButton(title:String, action:Selector, sender:UIViewController)
        -> UIButton {
            let button = UIButton(frame:ViewFactory.getDefaultFrame())
            button.backgroundColor = UIColor.orange
            button.setTitle(title, for:.normal)
            button.titleLabel!.textColor = UIColor.white
            button.titleLabel!.font = UIFont.systemFont(ofSize:14)
            button.addTarget(sender, action:action, for:.touchUpInside)
            return button
    }
    
    /**
     * 创建文本输入框控件
     */
    class func createTextField(value:String, placeholder:String)
        -> UITextField
    {
        let textField = UITextField(frame:ViewFactory.getDefaultFrame())
        textField.backgroundColor = UIColor.clear
        textField.placeholder = placeholder
        textField.textColor = UIColor.black
        textField.text = value
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }
    
    /**
     * 创建分段单选控件
     */
    class func createSegment(items: [String], action:Selector, sender:UIViewController)
        ->UISegmentedControl
    {
        let segment = UISegmentedControl(items:items)
        segment.frame = ViewFactory.getDefaultFrame()
        //segment.segmentedControlStyle = UISegmentedControlStyle.Bordered
        segment.isMomentary = false
        segment.addTarget(sender, action: action, for: UIControlEvents.valueChanged)
        return segment
    }
    
    /**
     * 创建文本标签控件
     */
    class func createLabel(title:String) -> UILabel
    {
        let label = UILabel()
        label.textColor = UIColor.black;
        label.backgroundColor = UIColor.white;
        label.text = title;
        label.frame = ViewFactory.getDefaultFrame()
        label.font =  UIFont(name: "HelveticaNeue-Bold", size: 16)
        return label
    }
    // 生成随机字符串
    class func randomSmallCaseString(length: Int) -> String {
        var output = ""
        for _ in 0..<length {
            let randomNumber = arc4random() % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber)!)
            output.append(randomChar)
        }
        return output
    }
    //随机数生成器函数
    class func randomNumber(start: Int, end: Int) ->Int {
        let temp = Int(arc4random() % UInt32(end)) + start
        return temp
    }

}

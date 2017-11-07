//
//  Utils.swift
//  FirstSwift
//
//  Created by 顾泠轩 on 2017/10/9.
//  Copyright © 2017年 glx. All rights reserved.
//

import Foundation
import UIKit

//屏幕宽、高、bounds
let SCW = UIScreen.main.bounds.width
let SCH = UIScreen.main.bounds.height
let gBOUNDS = UIScreen.main.bounds

//获取设备型号 e.g. @"iPhone", @"iPod touch"
let kDevice_Model = UIDevice.current.model
//获取系统版本
let giOS_Version = Float(UIDevice.current.systemVersion)

//是否为iPad
let gIS_iPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
//是否为iPhone
let gIS_iPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone

let gCLEARCOLOR = UIColor.clear


//设置字体
func gFONT_TITLE(X:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: X);
}

//图片资源获取
func gIMGFROMBUNDLE(name:String) -> UIImage {
    return UIImage.init(contentsOfFile:name)!
}
func gLOADIMG(file:String,ext:String) -> UIImage
{
    return UIImage.init(contentsOfFile: Bundle.main.path(forResource: file, ofType: ext)!)!
}
func gIMGName(name:String) -> UIImage{
    return UIImage.init(named: name)!
}

//设置RGB颜色{
func RGBA(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat) ->UIColor{
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}

//颜色设置方式二：
func colorWithHexString(hex:String) ->UIColor {
    var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased();
    
    if (cString.hasPrefix("#")) {
        let index = cString.index(cString.startIndex, offsetBy:1);
        cString = cString.substring(from: index);
    }
    if (cString.characters.count != 6) {
        return UIColor.red;
    }
    let rIndex = cString.index(cString.startIndex, offsetBy: 2);
    let rString = cString.substring(to: rIndex);
    let otherString = cString.substring(from: rIndex);
    let gIndex = otherString.index(otherString.startIndex, offsetBy: 2);
    let gString = otherString.substring(to: gIndex);
    let bIndex = cString.index(cString.endIndex, offsetBy: -2);
    let bString = cString.substring(from: bIndex);
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r);
    Scanner(string: gString).scanHexInt32(&g);
    Scanner(string: bString).scanHexInt32(&b);
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1));
}

//输出语句
func NSLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        print("\(methodName)[\(lineNumber)]:\(message)");
    #endif
}

func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
    let normalText: NSString = textStr as NSString
    let size = CGSize(width: width, height: 1000)
    let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)

    let stringSize = normalText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
    return stringSize.height
}

func getTexWidth(textStr:String,font:UIFont,height:CGFloat) -> CGFloat {
    
    let normalText: NSString = textStr as NSString
    
    let size = CGSize(width: 1000, height: height)
    
    let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
    
    let stringSize = normalText.boundingRect(with:size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
    
    return stringSize.width
    
}









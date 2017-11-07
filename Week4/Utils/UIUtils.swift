//
//  UIUtils.swift
//  SwiftDemo3
//
//  Created by 1111 on 2017/10/16.
//  Copyright © 2017年 glx. All rights reserved.
//

import Foundation
import UIKit

//label
func createLabel(frame:CGRect,text:String?) -> UILabel {
    let label = UILabel(frame:frame)
    if text != nil {
        label.text = text
    }
    return label
}

func createLabel(frame:CGRect,text:String?,titleColor:UIColor?,fontSize:CGFloat) -> UILabel {
    let label = createLabel(frame: frame, text: text)
    if titleColor != nil {
        label.textColor = titleColor
    }
    label.font = UIFont.systemFont(ofSize: fontSize)
    return label
}

func createLabel(frame:CGRect,text:String?,titleColor:UIColor?,fontSize:CGFloat,textAlignment:NSTextAlignment?) -> UILabel {
    let label = createLabel(frame: frame, text: text, titleColor: titleColor, fontSize: fontSize)
    if textAlignment != nil {
        label.textAlignment = textAlignment!
    }
    return label

}

//btn
func createButton(frame:CGRect,title:String?,titleColor:UIColor?) -> UIButton
{
    let btn = UIButton(frame:frame)
    if titleColor != nil {
        btn.setTitleColor(titleColor, for: UIControlState.normal)
    }
    if title != nil {
        btn.setTitle(title, for: UIControlState.normal)
    }
    return btn
}

func createButton(frame:CGRect,title:String?,titleColor:UIColor?,fontSize:CGFloat) -> UIButton
{
    let btn = createButton(frame: frame, title: title, titleColor: titleColor)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    return btn
}

func createButton(frame:CGRect,title:String?,titleColor:UIColor?,selectedTitle:String?,selectedColor:UIColor?) -> UIButton
{
    let btn = createButton(frame: frame, title: title, titleColor: titleColor)
    if selectedColor != nil {
        btn.setTitleColor(selectedColor, for: UIControlState.selected)
    }
    if selectedTitle != nil {
        btn.setTitle(selectedTitle, for: UIControlState.selected)
    }
    return btn
}

func createButton(frame:CGRect,image:UIImage?) -> UIButton
{
    let btn = UIButton(frame:frame)
    if image != nil {
        btn.setImage(image!, for: UIControlState.normal)
    }
    return btn
}

func createButton(frame:CGRect,image:UIImage?,selectdImage:UIImage?) -> UIButton
{
    let btn = createButton(frame: frame, image: image)
    if selectdImage != nil {
        btn.setImage(selectdImage!, for: UIControlState.selected)
    }
    return btn
}

func createButton(frame:CGRect,image:UIImage?,title:String?) -> UIButton
{
    let btn = createButton(frame: frame, image: image)
    if title != nil {
        btn.setTitle(title, for: UIControlState.selected)
    }
    return btn
}

func createButton(frame:CGRect,backImage:UIImage?) -> UIButton
{
    let btn = UIButton(frame:frame)
    if backImage != nil {
        btn.setBackgroundImage(backImage!, for: UIControlState.normal)
    }
    return btn
}

func createButton(frame:CGRect,backImage:UIImage?,selectdBackImage:UIImage?) -> UIButton
{
    let btn = createButton(frame: frame, backImage: backImage)
    if selectdBackImage != nil {
        btn.setBackgroundImage(selectdBackImage!, for: UIControlState.selected)
    }
    return btn
}

func createGradientColorLayer(colors:[CGColor],bounds:CGRect) -> CAGradientLayer
{
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = colors
    return gradientLayer
}





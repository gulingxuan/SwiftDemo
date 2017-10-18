//
//  Demo1ViewController.swift
//  SwiftWeek1
//
//  Created by 1111 on 2017/10/18.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController,UITextFieldDelegate {

    private var priceText:UITextField?
    private var tipLabel:UILabel?
    private var tipTitleLabel:UILabel?
    private var totalLabel:UILabel?
    private var totalTitleLabel:UILabel?
    private var slider:UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Demo1"
        createUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func createUI() {
        let text = UITextField()
        text.frame = CGRect(x: 50, y: 70, width: Int(SCW - 100), height: 40)
        text.placeholder = "$0.00"
        text.textColor = RGBA(R: 0, G:0 , B: 0, A: 1)
        text.textAlignment = NSTextAlignment.center
        text.keyboardType = UIKeyboardType.numberPad
        text.delegate = self
        priceText = text;
        view.addSubview(text);
        
        let titleArr = ["Tip(%15)","$0.00","Total","$0.00"]
        
        for i in 0 ..< 4{
            let num = CGFloat(i)
            let rect = CGRect(x: i%2 == 0 ? SCW/2 - 120.0 : SCW/2 + 20.0 , y: 130.0 + 50.0 * (num/2 < 1 ? 0 : 1), width: 100.0, height: 30.0)
            let label = UILabel(frame: rect)
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = titleArr[i]
            view.addSubview(label)
            switch i {
            case 0:
                tipTitleLabel = label
            case 1:
                tipLabel = label
            case 2:
                totalTitleLabel = label
            case 3:
                totalLabel = label
            default: break
            }
        }
        
        slider = UISlider(frame: CGRect(x: 70.0, y: 250.0, width: SCW - 140, height: 20.0))
        slider?.minimumValue = 0
        slider?.maximumValue = 100
        slider?.value = 15
        slider?.isContinuous = true
        
        slider?.addTarget(self, action:#selector(sliderValueChange(slider:)) , for: UIControlEvents.valueChanged)
        view.addSubview(slider!)
    }
    
    @objc func sliderValueChange(slider:UISlider)
    {
        let value = slider.value
        print(value)
        
        tipTitleLabel?.text = "Tip(%" + String(Int(value)) + ")"
        if priceText?.text?.isEmpty == true{ return }
        let price = Float(priceText!.text!)!
        let tip = Float(Int(value))/100 * price
        tipLabel?.text = String.init(format:"$%.2f", tip)
        totalLabel?.text =  String.init(format:"$%.2f", tip+price)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let value = slider!.value
        tipTitleLabel?.text = "Tip(%" + String(Int(value)) + ")"
        if priceText?.text?.isEmpty == true{ return true}
        let price = Float(priceText!.text!)!
        let tip = Float(Int(value))/100 * price
        tipLabel?.text = String.init(format:"$%.2f", tip)
        totalLabel?.text =  String.init(format:"$%.2f", tip+price)
        return true
    }


}

//
//  Demo3ViewController.swift
//  SwiftDemos
//
//  Created by 1111 on 2017/10/30.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo3ViewController: BaseViewController {
    
    var heartImg:UIImageView = UIImageView(frame: CGRect(x: SCW/2 - 45, y: 100, width: 90, height: 90))
    
    var img:UIImageView = UIImageView(frame: CGRect(x: SCW/2 - 120, y: 230, width: 240, height: 240))
    
    let hiddenAni = CABasicAnimation(keyPath: "opacity")
    
    let heartAnimation = CABasicAnimation(keyPath: "transform.scale")

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        heartImg.layer.add(heartAnimation, forKey: "transform.scale")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        img.layer.add(hiddenAni, forKey: "opacity")
    }

    override func createUI()
    {
        heartImg.image = gIMGName(name: "heartAni")
        view.addSubview(heartImg)
        
        heartAnimation.duration = 0.3
        heartAnimation.toValue = 1.1
        heartAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        heartAnimation.autoreverses = true
        heartAnimation.repeatCount = .greatestFiniteMagnitude
        heartImg.layer.add(heartAnimation, forKey: "transform.scale")
        
        img.image = gIMGName(name: "dl")
        view.addSubview(img)
        hiddenAni.duration = 3
        hiddenAni.fromValue = 1
        hiddenAni.toValue = 0
        hiddenAni.isRemovedOnCompletion = false
        hiddenAni.fillMode = kCAFillModeForwards
    }

}

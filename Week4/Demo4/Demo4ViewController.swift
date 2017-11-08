//
//  Demo4ViewController.swift
//  SwiftDemos
//
//  Created by 1111 on 2017/10/30.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo4ViewController: BaseViewController {

    var img:UIImageView!
    
    let ani = CAKeyframeAnimation(keyPath: "transform.scale")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        img.layer.add(ani, forKey: "transform.scale")
    }

    override func createUI()
    {
        
        let imgView = UIImageView(frame: view.bounds)
        imgView.image = gIMGName(name: "chengg")
        view.addSubview(imgView)
        
        img = UIImageView(frame: CGRect(x: SCW/2 - 40, y: SCH/2 - 40, width: 100, height: 80))
        img.image = gIMGName(name: "tw")
        view.layer.mask = img.layer
        
        ani.duration = 0.6
        ani.values = [1,0.7,35]
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false

    }

    

}

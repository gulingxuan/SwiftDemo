//
//  ViewController.swift
//  SwiftWeek1
//
//  Created by 1111 on 2017/10/18.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "第一周"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pushDemo1(_ sender: Any) {
        let vc = Demo1ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pushDemo2(_ sender: Any) {
        let vc = Demo2ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func pushDemo3(_ sender: Any) {
        let vc = Demo3ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func PushDemo4(_ sender: Any) {
        let vc = Demo4ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


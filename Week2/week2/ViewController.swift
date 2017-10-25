//
//  ViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = RGBA(R: 255, G: 255, B: 255, A: 0.5)
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
    
    @IBAction func pushDemo4(_ sender: Any) {
        let vc = Demo4ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    


}


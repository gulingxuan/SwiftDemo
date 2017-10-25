//
//  NavgationViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/24.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class NavgationViewController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count > 1
        {
            viewController.tabBarController?.tabBar.isHidden = true
        }
        else
        {
            viewController.tabBarController?.tabBar.isHidden = false
        }
    }

    

}

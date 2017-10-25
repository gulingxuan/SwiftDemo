//
//  TabBarViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/24.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViewControllers()
    {
        let demo1 = NavgationViewController(rootViewController: Demo1ViewController())
        let demo2 = Demo2ViewController()
        let demo3 = NavgationViewController(rootViewController: Demo3ViewController())
        let demo4 = NavgationViewController(rootViewController: Demo4ViewController())
        
        viewControllers = [demo1, demo2, demo3, demo4]
        
        let imgArr = ["find","heart","plane","plant"]
        let titleArr = ["Contacts","Card","Todo List","Swipeable"]
        
        for i in 0 ..< 4 {
            let item = tabBar.items?[i]
            item?.title = titleArr[i]
//            tabBar.tintColor = RGBA(R: 2, G: 21, B: 60, A: 1)
            let img = gIMGName(name: imgArr[i])
            item?.image = img.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            item?.selectedImage = gIMGName(name: (imgArr[i] + "2")).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
        
        self.selectedIndex = 0
        
    }
    
    
    
    
    
   

}

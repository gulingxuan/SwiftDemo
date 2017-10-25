//
//  Demo2ViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit
import SnapKit

class Demo2ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var dataArr:[FriendModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        createUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: ------------------- UI -------------------
    func createUI()
    {
        let layer = createGradientColorLayer(colors: [RGBA(R: 160, G: 121, B: 156, A: 1).cgColor,RGBA(R: 255, G: 163, B: 186, A: 1).cgColor,RGBA(R: 137, G: 113, B: 145, A: 1).cgColor], bounds: view.bounds)
        view.layer.addSublayer(layer)
        
        addCollectionView()
        
    }
    
    func addCollectionView()
    {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 15, 20, 15)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 210, height: 300)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.centerY.equalTo(view)
            make.width.equalTo(SCW)
            make.height.equalTo(400)
        }
        
        
    }
    

    
    //MARK: ------------------- 数据处理 -------------------
    func initData()
    {
        let filePath = Bundle.main.path(forResource: "PhoneList.plist", ofType: nil)
        let arr = NSArray(contentsOfFile: filePath!)!
        let array = arr as! [[[String:String]]]
    
        dataArr = FriendModel.friendsWithArray(array: array.last!)
    }

    
    //MARK: ------------------- collectionView -------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.friend = dataArr[indexPath.item]
        return cell
    }
    

}

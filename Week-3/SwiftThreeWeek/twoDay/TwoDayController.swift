//
//  TwoDayController.swift
//  SwiftThreeWeek
//
//  Created by 贾仕琪 on 2017/10/30.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit

class TwoDayController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    let itemWH:CGFloat = (SW - 15) / 2
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "collectionView"
        self.navigationController?.navigationBar.barTintColor = UIColor.yellow
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsetsMake(5,5, 5, 5)
        flowLayout.itemSize = CGSize(width: itemWH, height: itemWH + 30)
        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: kNavibarH, width: SW, height: SH - kNavibarH - kTabbarH ),collectionViewLayout:flowLayout);
        collectionView.backgroundColor = UIColor.white;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TwoDayController")
        view.addSubview(collectionView)
    }

    //MARK: - UICollectionView 代理
    
    //分区数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25;
    }
    
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "TwoDayController"
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 4
        let imageView = UIImageView.init(frame: cell.bounds)
        imageView.image = UIImage.init(named: "\(ViewFactory.randomNumber(start: 1, end: 11))")
        cell.addSubview(imageView)
        
        return cell;
    }
    
    //item 的尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width:itemWH,height:itemWH);
    }
    
    //每个分区区头尺寸
    
    
    //item 对应的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index is \(indexPath.row)");
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

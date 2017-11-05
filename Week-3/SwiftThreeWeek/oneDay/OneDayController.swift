//
//  OneDayController.swift
//  SwiftThreeWeek
//
//  Created by 贾仕琪 on 2017/10/30.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit

class OneDayController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    let itemWH:CGFloat = (SW - 50) / 4
    var collectionView:UICollectionView!
    var pageControl:UIPageControl!
    var cycyleTimer : Timer?
    var isScroll:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
        
        let flowLayout = LWLCollectionViewHorizontalLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10,10, 10, 10)
        flowLayout.itemSize = CGSize(width: itemWH, height: itemWH)
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 100, width: SW, height: itemWH * 2 + 30 ),collectionViewLayout:flowLayout);
        collectionView.backgroundColor = UIColor.red;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        
        collectionView.contentSize = CGSize(width: SW * 2, height: collectionView.bounds.height )
        view.addSubview(collectionView)
        //pageControl
        pageControl = UIPageControl(frame: CGRect(x: collectionView.frame.midX - 20, y: collectionView.frame.maxY + 10, width: 40, height: 40))
        pageControl.contentVerticalAlignment = .fill
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        view.addSubview(pageControl)
        addCycleTimer()
    }
    // 添加定时器
    fileprivate func addCycleTimer() {
        cycyleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer!, forMode:RunLoopMode.commonModes)
    }
    
    // 移除定时器
    fileprivate func removeCycleTimer() {
        // 从运行循环中移除
        cycyleTimer?.invalidate()
        cycyleTimer = nil
    }
    
    // 定时器的方法
    @objc fileprivate func scrollToNext() {
        if isScroll  == false {
            collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            pageControl.currentPage = 0
            isScroll  = true
        }else{
            collectionView.setContentOffset(CGPoint.init(x: SW - 10 , y: 0), animated: true)
            pageControl.currentPage = 1
            isScroll  = false
        }
    }
    //MARK: - UICollectionView 代理
    
    //分区数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12;
    }
    
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "OneDayController\(indexPath.row)"
    
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor.brown
        let lable = ViewFactory.createLabel(title: "\(indexPath.row)")
        lable.frame = cell.bounds
        lable.backgroundColor = UIColor.clear
        lable.textAlignment = .center
        cell.addSubview(lable)
        
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
    deinit {
        removeCycleTimer()
    }
    
}
/**************************  LWLCollectionViewHorizontalLayout  ******************/

class LWLCollectionViewHorizontalLayout: UICollectionViewFlowLayout {
    var itemCountPerRow:NSInteger = 2
    var rowCount:NSInteger = 4
    var allAttributes:[UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        rowCount = 2
        itemCountPerRow = 4
        let count:Int = (self.collectionView?.numberOfItems(inSection: 0))!
        for i in 0..<count {
            let indexPath:IndexPath = IndexPath.init(item: i, section: 0)
            let attributes:UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: indexPath)!
            allAttributes.append(attributes)
        }
    }
    
    override var collectionViewContentSize: CGSize{
        return super.collectionViewContentSize
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let item = indexPath.item
        var x:NSInteger = 0
        var y:NSInteger = 0
        self.targetPosition(item: item, resultX: &x, resultY: &y)
        let item2 = self.originItem(x: x, y: y)
        let theNewIndexPath:IndexPath = IndexPath.init(item: item2, section: indexPath.section)
        let theNewAttr = super.layoutAttributesForItem(at: theNewIndexPath)
        theNewAttr?.indexPath = indexPath
        return theNewAttr
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var tmp:[UICollectionViewLayoutAttributes] = []
        for attr:UICollectionViewLayoutAttributes in attributes!{
            for attr2 in self.allAttributes{
                if attr.indexPath.item == attr2.indexPath.item{
                    tmp.append(attr2)
                    break
                }
            }
        }
        return tmp
    }
    
    func targetPosition(item:NSInteger, resultX: inout NSInteger, resultY:inout NSInteger ){
        let page:NSInteger =  item/(self.itemCountPerRow*self.rowCount)
        let theX:NSInteger = item % self.itemCountPerRow + page * self.itemCountPerRow
        let theY:NSInteger = item / self.itemCountPerRow - page * self.rowCount
            resultX = theX
            resultY = theY
    }
    func originItem(x:NSInteger , y:NSInteger) -> NSInteger{
        let item: NSInteger = x * self.rowCount + y
        return item
    }
}
































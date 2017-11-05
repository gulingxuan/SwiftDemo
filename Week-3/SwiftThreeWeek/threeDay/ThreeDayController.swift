//
//  ThreeDayController.swift
//  SwiftThreeWeek
//
//  Created by 贾仕琪 on 2017/10/30.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit

class ThreeDayController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var width: CGFloat!
    var images: Array<UIImage>!
    var collectionView:UICollectionView!
    var maskView: UIView!
    var cellRect: CGRect!
    var changeRect: CGRect!
    var models:[Demo3Model] = []
    //MARK: --life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
        waterfallCollectionView()
    }
    private func waterfallCollectionView() {
        width = (view.bounds.size.width - 20)/3
        let layout = WaterCollectionViewLayout()
        images = []
        for i in 0..<18 {
            let image = UIImage(named: "timg-\(i).jpeg")
            images.append(image!)
            
            let model = Demo3Model(img: image)
            models.append(model)
        }
        layout.setSize = {
            return self.images
        }
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: SW, height: SH - kTabbarH), collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "Demo3Cell", bundle: nil), forCellWithReuseIdentifier: "Demo3Cell")
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }
    
   @objc func showPic(btn:UIButton){
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.cellRect
        }) { (finish) in
            btn.removeFromSuperview()
            self.maskView.removeFromSuperview()
            self.maskView = nil
            self.cellRect = nil
        }
    }
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Demo3Cell", for: indexPath as IndexPath) as? Demo3Cell
        cell?.model = models[indexPath.row]
        return cell!
    }

}
/*********************** WaterCollectionViewLayout      ***************************/
class WaterCollectionViewLayout: UICollectionViewLayout {
    
    //来控制cell的大小
    var setSize:()->(Array<UIImage>) = { return []}
    var queueNum: Int = 2 //列数，默认为两列
    var hs: Array<CGFloat>!
    private var totalNum: Int!
    private var layoutAttributes: Array<UICollectionViewLayoutAttributes>!
    override func prepare() {
        super.prepare()
        hs = []
        for _ in 0..<queueNum {
            hs.append(5)
        }
        totalNum = collectionView?.numberOfItems(inSection: 0)
        layoutAttributes = []
        var indexpath: NSIndexPath!
        for index in 0..<totalNum {
            indexpath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath as IndexPath)
            layoutAttributes.append(attributes!)
        }
    }
    private let gap:CGFloat = 5//间隔，缝隙大小
    private var width:CGFloat!
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        width = (collectionView!.bounds.size.width-gap*(CGFloat(queueNum)-1))/CGFloat(queueNum)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let sizes = setSize()
        attributes.size = CGSize(width: width, height: sizes[indexPath.row].size.height*width/sizes[indexPath.row].size.width)
        var nub:CGFloat = 0
        var h:CGFloat = 0
        (nub,h) = minH(hhs: hs)
        attributes.center = CGPoint(x:(nub+0.5)*(gap+width), y:h+(width/attributes.size.width*attributes.size.height+gap)/2)
        hs[Int(nub)] = h+width/attributes.size.width*attributes.size.height+gap
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    //    override func collectionViewContentSize() -> CGSize {
    //        return CGSize(width: (collectionView?.bounds.width)!, height: maxH(hhs: hs))
    //    }
    //swift3.0废弃了上面这个方法，所以我们改成重写collectionViewContentSize属性
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: maxH(hhs: hs))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    private func minH(hhs:Array<CGFloat>)->(CGFloat,CGFloat){
        var num = 0
        var min = hhs[0]
        for i in 1..<hhs.count{
            if min>hhs[i] {
                min = hhs[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    func maxH(hhs:Array<CGFloat>)->CGFloat{
        var max = hhs[0]
        for i in 1..<hhs.count{
            if max<hhs[i] {
                max = hhs[i]
            }
        }
        return max
    }
}



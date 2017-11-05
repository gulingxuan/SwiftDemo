//
//  FourDayController.swift
//  SwiftThreeWeek
//
//  Created by 贾仕琪 on 2017/10/30.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

import UIKit
import Kingfisher

let kLeftTableViewCell = "LeftTableViewCell"
let kCollectionViewCell = "CollectionViewCell"
let kCollectionViewHeaderView = "CollectionViewHeaderView"


class FourDayController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: 80, height: SH - kTabbarH)
        tableView.rowHeight = 55
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.clear
        tableView.register(LeftTableViewCell.self, forCellReuseIdentifier: kLeftTableViewCell)
        return tableView
    }()
    
    fileprivate lazy var flowlayout : UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 2
        flowlayout.minimumInteritemSpacing = 2
        flowlayout.itemSize = CGSize(width: (SW - 80 - 4 - 4) / 3, height: (SW - 80 - 4 - 4) / 3 + 30)
        return flowlayout
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.init(x: 2 + 80, y: 2 + 64, width: SW - 80 - 4, height: SH - 64 - 4), collectionViewLayout: self.flowlayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCell)
        collectionView.register(CollectionViewHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionViewHeaderView)
        return collectionView
    }()
    
    fileprivate lazy var dataSource = [CollectionCategoryModel]()
    fileprivate lazy var collectionDatas = [[SubCategoryModel]]()
    
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureData()
        
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }

    func configureData() {
        
        guard let path = Bundle.main.path(forResource: "liwushuo", ofType: "json") else { return }
        
        guard let data = NSData(contentsOfFile: path) as Data? else { return }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        
        guard let dict = anyObject as? [String : Any] else { return }
        
        guard let datas = dict["data"] as? [String : Any] else { return }
        
        guard let categories = datas["categories"] as? [[String : Any]] else { return }
        
        for category in categories {
            let model = CollectionCategoryModel(dict: category)
            dataSource.append(model)
            
            guard let subcategories = model.subcategories else { continue }
            
            var datas = [SubCategoryModel]()
            for subcategory in subcategories {
                datas.append(subcategory)
            }
            collectionDatas.append(datas)
        }
        
    }
    
    //MARK: - TableView DataSource Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLeftTableViewCell, for: indexPath) as! LeftTableViewCell
        let model = dataSource[indexPath.row]
        cell.nameLabel.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        
        // http://stackoverflow.com/questions/22100227/scroll-uicollectionview-to-section-header-view
        // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
        scrollToTop(section: selectIndex, animated: true)
        
        // collectionView.scrollToItem(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: true)
        tableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
    }
    
    //MARK: - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
    fileprivate func scrollToTop(section: Int, animated: Bool) {
        let headerRect = frameForHeader(section: section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - collectionView.contentInset.top)
        collectionView.setContentOffset(topOfHeader, animated: animated)
    }
    
    fileprivate func frameForHeader(section: Int) -> CGRect {
        let indexPath = IndexPath(item: 0, section: section)
        let attributes = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath)
        guard let frameForFirstCell = attributes?.frame else {
            return .zero
        }
        return frameForFirstCell;
    }
    
    //MARK: - CollectionView DataSource Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDatas[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCell, for: indexPath) as! CollectionViewCell
        let model = collectionDatas[indexPath.section][indexPath.row]
        cell.setDatas(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reuseIdentifier : String?
        if kind == UICollectionElementKindSectionHeader {
            reuseIdentifier = kCollectionViewHeaderView
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier!, for: indexPath) as! CollectionViewHeaderView
        
        if kind == UICollectionElementKindSectionHeader {
            let model = dataSource[indexPath.section]
            view.setDatas(model)
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SW, height: 30)
    }
    
    // CollectionView 分区标题即将展示
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        // 当前 CollectionView 滚动的方向向上，CollectionView 是用户拖拽而产生滚动的（主要是判断 CollectionView 是用户拖拽而滚动的，还是点击 TableView 而滚动的）
        if !isScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
            selectRow(index: indexPath.section)
        }
    }
    
    // CollectionView 分区标题展示结束
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        // 当前 CollectionView 滚动的方向向下，CollectionView 是用户拖拽而产生滚动的（主要是判断 CollectionView 是用户拖拽而滚动的，还是点击 TableView 而滚动的）
        if isScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
            selectRow(index: indexPath.section + 1)
        }
    }
    
    // 当拖动 CollectionView 的时候，处理 TableView
    private func selectRow(index : Int) {
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
    }
    
    // 标记一下 CollectionView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
/********************* Model ************************/
class CollectionCategoryModel: NSObject {
    
   @objc var name : String?
   @objc var subcategories : [SubCategoryModel]?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "subcategories" {
            subcategories = Array()
            guard let datas = value as? [[String : Any]] else { return }
            for dict in datas {
                let subModel = SubCategoryModel(dict: dict)
                subcategories?.append(subModel)
            }
        } else {
            super.setValue(value, forKey: key)
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

class SubCategoryModel: NSObject {
    
   @objc var iconUrl : String?
   @objc var name : String?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "icon_url" {
            guard let icon = value as? String else { return }
            iconUrl = icon
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
/*********************  Cell ************************/
class LeftTableViewCell: UITableViewCell {
    
    lazy var nameLabel = UILabel()
    private lazy var yellowView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureUI()
    }
    
    func configureUI () {
        
        nameLabel.frame = CGRect(x: 10, y: 10, width: 60, height: 40)
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textColor = RGBA(r: 130, g: 130, b: 130, a: 1)
        nameLabel.highlightedTextColor = RGBA(r: 253, g: 212, b: 49, a: 1)
        contentView.addSubview(nameLabel)
        
        yellowView.frame = CGRect(x: 0, y: 5, width: 5, height: 45)
        yellowView.backgroundColor = RGBA(r: 253, g: 212, b: 49, a: 1)
        contentView.addSubview(yellowView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.white : UIColor(white: 0, alpha: 0.1)
        isHighlighted = selected
        nameLabel.isHighlighted = selected
        yellowView.isHidden = !selected
        
    }
    
}

class CollectionViewCell: UICollectionViewCell {
    
    private lazy var imageV = UIImageView()
    private lazy var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI(frame: frame)
    }
    
    func configureUI(frame:CGRect) {
        imageV.frame = CGRect(x: 2, y: 2, width: frame.size.width - 4, height: frame.size.width - 4)
        imageV.contentMode = .scaleAspectFit
        contentView.addSubview(imageV)
        
        nameLabel.frame = CGRect.init(x: 2, y: frame.size.width + 2, width: frame.size.width - 4, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }
    
    func setDatas(_ model : SubCategoryModel) {
        
        guard
            let iconUrl = model.iconUrl,
            let name = model.name else { return }
        
        guard let url = URL(string: iconUrl) else { return }
        
        nameLabel.text = name
        imageV.kf.setImage(with: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class CollectionViewHeaderView: UICollectionReusableView {
    
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = RGBA(r: 248, g: 248, b: 248, a: 0.8)
        
        titleLabel.frame = CGRect(x: 0, y: 5, width: SW - 80, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    func setDatas(_ model : CollectionCategoryModel) {
        
        guard let name = model.name else { return }
        
        titleLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

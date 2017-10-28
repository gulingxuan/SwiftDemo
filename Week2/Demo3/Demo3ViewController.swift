//
//  Demo3ViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/23.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

class Demo3ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArr:[TodoModel] = []
    var tableView:UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo List"
        initData()
        createUI()
    }

    
    //MARK: ------------------- UI -------------------
    func createUI()
    {
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit , target: self, action:#selector(editTableView(btn:)))
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addTodo))
        navigationItem.rightBarButtonItem = rightItem
        
        let tableView = UITableView(frame: view.bounds);
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TodoListCell", bundle: nil), forCellReuseIdentifier: "TodoListCell")
        view.addSubview(tableView)
        self.tableView = tableView

    }

    //MARK: ------------------- 数据处理 -------------------
    func initData()
    {
        dataArr = TodoModel.todoModels(array: [["img":"yl","todo":"发呆的呆","time":"2017-10-21"],["img":"fj","todo":"发呆的发","time":"2017-10-22"],["img":"tel","todo":"梦游的梦","time":"2017-10-20"],["img":"yl","todo":"梦游的游","time":"2017-10-24"],["img":"gw","todo":"想不出来的出","time":"2017-10-23"]])
    }

    //MARK: ------------------- Event事件处理 -------------------
    @objc func editTableView(btn:UIBarButtonItem)
    {
        tableView?.isEditing = !tableView!.isEditing
    }
    
    @objc func addTodo()
    {
        let dvc = TodoDetailViewController(model: nil, isModify: false)
//        dvc.addModel = {
//            [unowned self](model:TodoModel) ->Void in
//            self.dataArr.append(model)
//            self.tableView?.reloadData()
//        }
        
        dvc.addModel = {
            [unowned self] model in
            self.dataArr.append(model)
            self.tableView?.reloadData()
        }
        
        
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    //MARK: ------------------- TV代理 -------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as! TodoListCell
        cell.model = dataArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.none
//    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArr[indexPath.row]
        let vc = TodoDetailViewController(model: model, isModify: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //更新数据源
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let model = dataArr[sourceIndexPath.row]
        dataArr.remove(at: sourceIndexPath.row)
        dataArr.insert(model, at: destinationIndexPath.row)
        
        print(dataArr)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //删除数据
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    

}




//
//  TodoDetailViewController.swift
//  week2
//
//  Created by 1111 on 2017/10/25.
//  Copyright © 2017年 glx. All rights reserved.
//

import UIKit

typealias AddTodoModel = (TodoModel) -> Void

class TodoDetailViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var btnArr: [UIButton]!
    @IBOutlet weak var todoText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var addModel:AddTodoModel?
    var model:TodoModel?
    var img = "yl"
    var tempBtn:UIButton?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        todoText.delegate = self
        title = "New Todo"
        
        let SimgArr = ["yl","tel","gw","fj"]
        
        for i in 0 ..< 4
        {
            let btn = btnArr[i]
            btn.setImage(gIMGName(name: (SimgArr[i] + "2")) , for: UIControlState.selected)
            if  i == 0 {
                tempBtn = btn
                btn.isSelected = true
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //选择类型
    @IBAction func ChooseType(_ sender: Any) {
        let btn = sender as! UIButton
        if btn.isSelected == true{ return }
        
        tempBtn?.isSelected = false;
        tempBtn = btn
        tempBtn?.isSelected = true

        switch (btn.tag%10) {
        case 0:
            img = "yl"
        case 1:
            img = "tel"
        case 2:
            img = "gw"
        case 3:
            img = "fj"
        default:
            break
        }
    }
    
    
    @IBAction func createTodoModel(_ sender: Any)
    {
        if todoText.text == nil || todoText.text!.isEmpty {
            print("请输入事件~")
            return
        }
        let dic = ["img":img,"time":getTime(),"todo":todoText.text!]
        model = TodoModel(dict: dic)
        addModel?(model!)
        navigationController?.popViewController(animated: true)
    }
    
    //获取时间
    func getTime() -> String
    {
        let date = datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    
    

}

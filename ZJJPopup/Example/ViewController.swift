//
//  ViewController.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/28.
//

import UIKit



class ViewController: UIViewController {
    
    var dataArray:[ZJJConfigModel] = []
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.dataArray = [ZJJConfigModel.picker(),ZJJConfigModel.tableView(title: "请选择tableView列表中的数据"),ZJJConfigModel.customTableView(title:"请选择customTableView列表中的数据"),ZJJConfigModel.init(type: .customView)]
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func showPicker(model:ZJJConfigModel) {
        let (pickerView,_) =  ZJJPopup.pickerView(optionModel: model.option, title: "请选择") { (pickerView, popupView, model, btn) in
            let dataModel = model as? ZJJDataModel
            print("==\(dataModel?.title ?? "")==row:\(dataModel?.row ?? 0)==")
        }
        
        var pickerUI = ZJJPickerUI()
        //设置行高
        pickerUI.rowHeight = 44
        //设置选择字体的颜色
        pickerUI.selectColor = .blue
        //字体的大小
        pickerUI.font = UIFont.systemFont(ofSize: 20)
        //分割线的颜色
        pickerUI.separatorLineColor = .red
        pickerView.pickerUI = pickerUI
    }
    
    func showTableView(model:ZJJConfigModel) {
        
        ZJJPopup.tableView(optionModel: model.option, popupModel: model.popupModel) { (tableView, popupView, model, btn) in
            btn.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                //延时，模拟网络请求，等数据成功后在进行隐藏
                btn.isEnabled = true
                popupView.hidden()
            }
        }
    }
    
    func showCustomTableView(model:ZJJConfigModel) {
        
        let (tableView,_) =  ZJJPopup.tableView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width-60, height:250), optionModel:model.option, popupModel: model.popupModel) { (tableView, popupView, model, btn) in
            if let md = model {
                print("选中：\(md.jj_optionValue ?? "")")
            }else{
                print("未选择")
            }
        }
        tableView.register(UINib.init(nibName: "ZJJCustomCell", bundle: nil), forCellReuseIdentifier: "ZJJCustomCell")
        
        tableView.setupBlock { (tableView, indexPath, model) -> CGFloat? in
            //设置行高
            return UITableView.automaticDimension
        } cellForRowBlock: { (tableView, indexPath, model, selectModel) -> UITableViewCell? in
            //自定义cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZJJCustomCell", for: indexPath) as! ZJJCustomCell
            cell.selectionStyle = .none
            if let customModel = model as? ZJJCustomModel {
                cell.model = customModel
                
                if cell.model.jj_optionValue == selectModel?.jj_optionValue {
                    cell.selectImageView.image = UIImage.init(named: "chengong_icon")
                }else{
                    cell.selectImageView.image = UIImage.init(named: "weix_icon")
                }
            }
            return cell
        }
        
    }
    
    func showCustomView(model:ZJJConfigModel) {
        
        let customView = Bundle.main.loadNibNamed("ZJJCustomView", owner: nil, options: nil)?.first as! ZJJCustomView
        customView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 200)
        let popupView = ZJJPopup.customView(contentView: customView)
        
        customView.close {
            popupView.hidden()
        }
    }
    
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
            
        }
        let model = self.dataArray[indexPath.row]
        cell?.textLabel?.text = model.type.rawValue
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row]
        if model.type == .picker {
            self.showPicker(model: model)
        } else if model.type == .tableView{
            self.showTableView(model: model)
        } else if model.type == .customTableView{
            self.showCustomTableView(model: model)
        } else {
            self.showCustomView(model: model)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    
    
}

//
//  ZJJConfigModel.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/28.
//

import UIKit

enum ZJJPopupType:String {
    case picker,tableView,customTableView,customView
}

struct  ZJJConfigModel {

    var type:ZJJPopupType = .picker
    var option:ZJJOption = ZJJOption()
    var popupModel:ZJJPopupModel = ZJJPopupModel()
    
    static func picker() -> ZJJConfigModel {
        let option = self.getOption(type: .picker)
        return ZJJConfigModel.init(type: .picker, option: option)
    }
    
    static func tableView(title:String = "") -> ZJJConfigModel {
        var option = self.getOption(type: .tableView)
        //设置默认选择的对象
        option.selectModel = option.optionArray[6]
        let popupModel = ZJJPopupModel.tableView(title: title)
        return ZJJConfigModel.init(type: .tableView, option: option, popupModel: popupModel)
    }
    
    static func customTableView(title:String = "") -> ZJJConfigModel {
        
        var option = ZJJOption()
        //构造数据
        for i  in 0 ..< 20 {
            let data = ZJJCustomModel.init()
            data.icon = "dizhic_icon"
            data.title = self.getTitle(count: i)
            option.optionArray.append(data)
        }
    
        var popupModel = ZJJPopupModel()
        //设置标题
        popupModel.topViewConfig.titleConfig.text = title
        //隐藏取消按钮
        popupModel.topViewConfig.cancelConfig.isHidden = true
        //设置title的位置是否自动居中
        popupModel.topViewConfig.isTitleAutomaticCenter = false
        //居中显示
        popupModel.popupViewStyle = .center
        return ZJJConfigModel.init(type: .customTableView, option: option,popupModel: popupModel)
    }

    static func getOption(type:ZJJPopupType) -> ZJJOption{
        var option = ZJJOption()
        //构造数据
        for i  in 0 ..< 15 {
            let data = ZJJDataModel.init(title: "\(type.rawValue)", row: i+1)
            option.optionArray.append(data)
        }
        return option
    }
    
    static func getTitle(count:Int) -> String {
        var value = ""
        for i  in 0 ..< count+1 {
            value = "test\(i) " + value
        }
        return value
    }
}



extension ZJJPopupModel {
    
    static func tableView(title:String = "") -> ZJJPopupModel{
        var popupModel = ZJJPopupModel()
        popupModel.isTouchHidden = false //点击遮罩层，是否隐藏弹框视图
        popupModel.isConfirmHidden = false //点击确定按钮，是否隐藏弹框视图
        popupModel.contentViewMinHeight = 300 //contentView内容的最小高度
        popupModel.topViewConfig.minHeight = 50 //topView 内容的最小高度
        popupModel.popupViewRadius = 0 //popupView的圆角
        popupModel.maskLayerColor = UIColor.init(red:0, green: 0, blue:0, alpha: 0.8) //遮罩层的颜色
        
        //设置标题
        popupModel.topViewConfig.titleConfig.text = title
        //设置标题的字体大小
        popupModel.topViewConfig.titleConfig.font = UIFont.systemFont(ofSize: 20)
        //隐藏取消按钮
        popupModel.topViewConfig.cancelConfig.isHidden = true
        //设置确定按钮的文本
        popupModel.topViewConfig.confirmConfig.text = "Confirm"
        //设置确定文本的颜色
        popupModel.topViewConfig.confirmConfig.color = .white
        //设置确定按钮的背景色
        popupModel.topViewConfig.confirmConfig.backgroundColor = .blue
        //设置确定按钮的圆角，边框大小和颜色
        popupModel.topViewConfig.confirmConfig.set(cornerRadius: 5,borderWidth: 1,borderColor: .red)
        return popupModel
    }
}

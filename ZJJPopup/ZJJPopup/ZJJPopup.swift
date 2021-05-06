//
//  ZJJPopup.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/28.
//

import UIKit

typealias ZJJPopupPickerBlock = (ZJJDefaultPickerView,ZJJPopupView,ZJJOptionProtocol?,UIButton) -> ()
typealias ZJJPopupTableViewBlock = (ZJJDefaultSelectTableView,ZJJPopupView,ZJJOptionProtocol?,UIButton) -> ()

class ZJJPopup {
    
    @discardableResult
    static func tableView(frame:CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:220),optionModel:ZJJOption,title:String,confirmBlock:ZJJPopupTableViewBlock? = nil) -> (ZJJDefaultSelectTableView,ZJJPopupView) {
        
        return self.tableView(frame: frame, optionModel: optionModel, popupModel: ZJJPopupModel.popup(title: title,animationType: .move), confirmBlock: confirmBlock)
    }
    @discardableResult
    static func tableView(frame:CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:220),optionModel:ZJJOption,popupModel:ZJJPopupModel = ZJJPopupModel.init(),confirmBlock:ZJJPopupTableViewBlock? = nil) -> (ZJJDefaultSelectTableView,ZJJPopupView){
        let tableView = ZJJDefaultSelectTableView.init(frame: frame, model: optionModel)
        let popupView = ZJJPopupView.init(contentView:tableView , popupModel: popupModel) { (popView, btn) in
            if let block = confirmBlock {
                block(tableView,popView,tableView.selectModel,btn)
            }
        } cancelBlock: { (popView, btn) in
            
        }
        popupView.show()
        return (tableView,popupView)
    }
    
    @discardableResult
    static func pickerView(frame:CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:220),optionModel:ZJJOption,title:String,confirmBlock:ZJJPopupPickerBlock? = nil) -> (ZJJDefaultPickerView,ZJJPopupView) {
        
        return self.pickerView(frame: frame, optionModel: optionModel, popupModel: ZJJPopupModel.popup(title: title,animationType: .move), confirmBlock: confirmBlock)
    }
    @discardableResult
    static func pickerView(frame:CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:220),optionModel:ZJJOption,popupModel:ZJJPopupModel = ZJJPopupModel.init(),confirmBlock:ZJJPopupPickerBlock? = nil) -> (ZJJDefaultPickerView,ZJJPopupView){
        let pickerView = ZJJDefaultPickerView.init(frame:frame, model: optionModel)
        let popupView = ZJJPopupView.init(contentView:pickerView , popupModel: popupModel) { (popView, btn) in
            if let block = confirmBlock {
                block(pickerView,popView,pickerView.selectModel,btn)
            }
        } cancelBlock: { (popView, btn) in
            
        }
        popupView.show()
        return (pickerView,popupView)
    }
    
    static func customView(contentView:UIView,isTouchHidden:Bool = false,animationType:ZJJPopupAnimationType = .scale) -> ZJJPopupView{
        var popupModel = ZJJPopupModel()
        popupModel.isTouchHidden = isTouchHidden
        popupModel.animationType = animationType
        popupModel.topViewConfig.isHidden = true
        let popupView = ZJJPopupView.init(contentView: contentView, popupModel: popupModel)
        popupView.show()
        return popupView
    }
    
    static func customView(contentView:UIView,popupModel:ZJJPopupModel) -> ZJJPopupView{
        let popupView = ZJJPopupView.init(contentView: contentView, popupModel: popupModel)
        popupView.show()
        return popupView
    }
    
}

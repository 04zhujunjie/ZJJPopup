//
//  ZJJPopupModel.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/26.
//

import UIKit

struct ZJJPopupModel {
    
    var popupViewStyle:ZJJPopupViewStyle = .bottom //设置popupView的位置
    var popupViewRadius:CGFloat = 10 //设置popupView的圆角
    var isTouchHidden:Bool = true //点击遮罩层，是否隐藏弹框视图
    var isConfirmHidden:Bool = true //点击确定按钮，是否隐藏弹框视图
    var contentViewMinHeight:CGFloat = 220 //contentView内容的最小高度
    var isHiddenTopView:Bool = false //是否隐藏 topView
    var topViewMinHeight:CGFloat = 48 //topView 内容的最小高度
    var coverColor:UIColor = UIColor.init(red:0, green: 0, blue:0, alpha: 0.5) //遮罩层的颜色
    var lineColor:UIColor = UIColor(red: 0.42, green: 0.41, blue: 0.47,alpha:0.3) //分割线的颜色
    var lineHeight:CGFloat = 0.6 //分割线的高度
    var isHiddenLine:Bool = false //是否分割线
    var titleConfig:ZJJPopupUIConfig = ZJJPopupUIConfig() //标题的设置
    var cancelConfig:ZJJPopupButtonConfig = ZJJPopupButtonConfig.init(text: "取消") //取消按钮设置
    var confirmConfig:ZJJPopupButtonConfig = ZJJPopupButtonConfig.init(text: "确定") //确定按钮设置
    
    static func popup(title:String,style:ZJJPopupViewStyle = .bottom) -> ZJJPopupModel {
       var model = ZJJPopupModel()
        model.titleConfig.text = title
        model.popupViewStyle = style
        return model
    }
    
    static func popupCenter(isTouch isTouchHidden:Bool = false,minHeight contentViewMinHeight:CGFloat = 220) -> ZJJPopupModel {
       var model = ZJJPopupModel()
        model.isTouchHidden = isTouchHidden
        model.popupViewStyle = .center
        model.contentViewMinHeight = contentViewMinHeight //设置最小高度
        model.isHiddenTopView = true //隐藏topView
        return model
    }
    
}

class ZJJPopupButtonConfig: ZJJPopupUIConfig {
    var margin:CGFloat = 8 //按钮距离父视图的左边或右边距离,如果按钮在左边，那么就是距离父视图的左边距，如果按钮在右边，那么就是距离俯视图的右边距
    var maxWidth:CGFloat = 80 //按钮的最大宽度，如果文本过长，超过最大宽度，那么按钮的宽度为maxWidth，会根据numberOfLines属性来计算文本是否换行
    var minTopBottom:CGFloat = 8 //按钮距离父视图的上下边的最小边距
}


class  ZJJPopupUIConfig{
    
    var text:String = ""
    var isHidden:Bool = false
    var font:UIFont = .systemFont(ofSize: 16)
    var color:UIColor = .black
    var numberOfLines:Int = 0
    var backgroundColor:UIColor = .clear
    var textAlignment:NSTextAlignment = .center
    var leftRightMargin:CGFloat = 10 //文本的左右边距
    var borderWidth:CGFloat = 0
    var borderColor:UIColor = UIColor.clear
    var cornerRadius:CGFloat = 0
    var masksToBounds:Bool = false
    
    init(text:String = "") {
        self.text = text
    }
    
    func set(cornerRadius:CGFloat = 0,borderWidth:CGFloat = 0,borderColor:UIColor = UIColor.clear) {
        self.masksToBounds = true
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    
}

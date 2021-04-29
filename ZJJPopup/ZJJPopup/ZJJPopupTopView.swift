//
//  ZJJPopupTopView.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/27.
//

import UIKit

class ZJJPopupTopView: UIView {
    
    private let titleLabel = UILabel()
    private let lineView:UIView = UIView()
    let cancelButton = UIButton()
    let confirmButton = UIButton()
    private var popupModel:ZJJPopupModel = ZJJPopupModel()
    
    func setup(frame:CGRect,popupModel:ZJJPopupModel) {
        self.frame = frame
        
        confirmButton.contentEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
        self.popupModel = popupModel
        self.setupUI()
    }
    
    private func setupUI() {
        
        var cancelSize = CGSize.zero
        var confirmSize = CGSize.zero
        var titleWidth:CGFloat = 0
        var titleHeight:CGFloat = 0
        if self.backgroundColor == nil {
            self.backgroundColor = .white
        }
        if !popupModel.cancelConfig.isHidden {
            self.addSubview(self.cancelButton)
            cancelButton.contentEdgeInsets = .init(top: 0, left: popupModel.cancelConfig.leftRightMargin, bottom: 0, right: popupModel.cancelConfig.leftRightMargin)
            self.setup(view: cancelButton, config: popupModel.cancelConfig)
            cancelSize = self.getBtnSize(config: popupModel.cancelConfig)
        }
        
        if !popupModel.confirmConfig.isHidden {
            self.addSubview(self.confirmButton)
            confirmButton.contentEdgeInsets = .init(top: 0, left: popupModel.confirmConfig.leftRightMargin, bottom: 0, right: popupModel.confirmConfig.leftRightMargin)
            self.setup(view: confirmButton, config: popupModel.confirmConfig)
            confirmSize = self.getBtnSize(config: popupModel.confirmConfig)
        }
        
        if !popupModel.titleConfig.isHidden {
            self.addSubview(self.titleLabel)
            self.setup(view: titleLabel, config: popupModel.titleConfig)
            titleWidth = self.frame.size.width -  (max(cancelSize.width, confirmSize.width)*2 + popupModel.cancelConfig.margin+popupModel.confirmConfig.margin) - popupModel.titleConfig.leftRightMargin*2
            if titleWidth > 0 {
                let height = self.getHeight(width: titleWidth, config: popupModel.titleConfig)
                if popupModel.titleConfig.numberOfLines == 0 {
                    titleHeight = height
                }else if popupModel.titleConfig.numberOfLines > 1{
                    let heightN = CGFloat(22*popupModel.titleConfig.numberOfLines)+10
                    if height > heightN {
                        titleHeight = heightN
                    }else{
                        titleHeight = height
                    }
                    
                }else{
                    titleHeight = 30
                }
                
            }
        }
        
        
        //取最大值作为topView的高度
        let viewHeight = max(cancelSize.height+popupModel.cancelConfig.minTopBottom*2, confirmSize.height+popupModel.confirmConfig.minTopBottom*2, titleHeight, popupModel.topViewMinHeight)
        
        var selfFrame = self.frame
        selfFrame.size.height = viewHeight
        self.frame = selfFrame
        self.titleLabel.frame = CGRect.init(x: 0, y: 0, width: titleWidth, height: titleHeight)
        self.titleLabel.center = CGPoint.init(x: self.frame.size.width/2.0, y: viewHeight/2.0)
        
        self.cancelButton.frame = CGRect.init(origin: CGPoint.init(x: popupModel.cancelConfig.margin, y: 0), size: cancelSize)
        self.cancelButton.center = CGPoint.init(x:self.cancelButton.center.x , y: viewHeight/2.0)
        self.confirmButton.frame  = CGRect.init(origin: CGPoint.init(x: self.frame.size.width - popupModel.confirmConfig.margin-confirmSize.width, y: 0), size: confirmSize)
        self.confirmButton.center = CGPoint.init(x:self.confirmButton.center.x , y: viewHeight/2.0)
        if !popupModel.isHiddenLine {
            self.addSubview(self.lineView)
            self.lineView.backgroundColor = popupModel.lineColor
            self.lineView.frame = CGRect.init(x: 0, y: viewHeight-popupModel.lineHeight, width: self.frame.size.width, height:popupModel.lineHeight)
        }

        
    }
    
    private  func getBtnSize(config:ZJJPopupButtonConfig) -> CGSize {
        if !config.isHidden {
            let maxWidth:CGFloat = config.maxWidth
            //文本内容距离按钮的左右边距
            let buttonEdgeInsetLeftRight = config.leftRightMargin
            let width = config.text.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: 25), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:config.font], context: nil).size.width
            let btnHeight = popupModel.topViewMinHeight - config.minTopBottom*2
            
            if width > maxWidth {
                //文本的宽度大于最大宽度
                //按钮的宽度
                let btnWidth = maxWidth+buttonEdgeInsetLeftRight*2
                if config.numberOfLines == 0 {
                    return CGSize.init(width: btnWidth, height: self.getHeight(width: maxWidth, config: config))
                }else if config.numberOfLines > 1{
                    return CGSize.init(width: btnWidth, height: btnHeight*CGFloat(config.numberOfLines)*5/6)
                }
                return CGSize.init(width: btnWidth, height: btnHeight)
            }else{
                return CGSize.init(width: width+buttonEdgeInsetLeftRight*2, height: btnHeight)
            }
            
        }
        return CGSize.zero
    }
    //计算文本的高度
    private  func getHeight(width:CGFloat,config:ZJJPopupUIConfig) -> CGFloat {
        if !config.isHidden {
            let height = config.text.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:config.font], context: nil).size.height
            return height + 20
        }
        return 0
    }
    
    private func setup(view:UIView,config:ZJJPopupUIConfig) {
        
        if let btn = view as? UIButton {
            btn.titleLabel?.font = config.font
            btn.titleLabel?.numberOfLines = config.numberOfLines
            btn.setTitle(config.text, for: .normal)
            btn.setTitle(config.text, for: .highlighted)
            btn.setTitleColor(config.color, for: .normal)
            btn.setTitleColor(config.color, for: .highlighted)
        } else if let label = view as? UILabel {
            
            label.font = config.font
            label.text = config.text
            label.textColor = config.color
            label.numberOfLines = config.numberOfLines
            label.textAlignment = config.textAlignment
        }
        view.backgroundColor = config.backgroundColor
        
        if config.masksToBounds {
            view.layer.masksToBounds = config.masksToBounds
            view.layer.borderWidth = config.borderWidth
            view.layer.borderColor = config.borderColor.cgColor
            view.layer.cornerRadius = config.cornerRadius
        }
    }
    
}

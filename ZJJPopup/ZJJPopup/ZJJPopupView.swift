//
//  ZJJPopupView.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/26.
//

import UIKit

fileprivate let  kZJJScreenHeight = UIScreen.main.bounds.height
fileprivate let  kZJJScreenWidth = UIScreen.main.bounds.width

typealias ZJJPopupViewBlock = (ZJJPopupView,UIButton) -> ()

enum ZJJPopupViewStyle {
    case bottom
    case center
}

class ZJJPopupView: UIView,UIGestureRecognizerDelegate {
    
    private let popupView = UIView()
    private var model:ZJJPopupModel = ZJJPopupModel()
    private var topView:ZJJPopupTopView = ZJJPopupTopView()
    private var contentView:UIView = UIView()
    private var confirmBlock:ZJJPopupViewBlock?
    private var cancelBlock:ZJJPopupViewBlock?
    private var style:ZJJPopupViewStyle = .bottom
    private var isAnimation:Bool = false //是否正在进行显示或消失的动画
    
    convenience init(contentView:UIView,popupModel:ZJJPopupModel = ZJJPopupModel(),confirmBlock: ZJJPopupViewBlock? = nil){
        self.init(contentView:contentView,popupModel:popupModel,confirmBlock: confirmBlock,cancelBlock: nil)
    }
    
    init(contentView:UIView,popupModel:ZJJPopupModel,confirmBlock: ZJJPopupViewBlock? = nil,cancelBlock: ZJJPopupViewBlock? = nil) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: kZJJScreenWidth, height: kZJJScreenHeight))
        self.contentView = contentView
        self.style = popupModel.popupViewStyle
        self.model = popupModel
        if model.isTouchHidden {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(hidden))
            tap.delegate = self
            self.addGestureRecognizer(tap)
        }
        if !model.isHiddenTopView {
            self.setupTopView()
            self.confirmBlock = confirmBlock
            self.cancelBlock = cancelBlock
        }
        
        self.setupUI()
        
        if let window = self.getWindow() {
            window.addSubview(self)
        }
        
    }
    
    private  func setupTopView() {
        
        var contentViewWidth = contentView.frame.size.width
        if contentViewWidth < 1 {
            contentViewWidth = kZJJScreenWidth
        }
        self.topView.setup(frame: CGRect.init(x: 0, y: 0, width:contentViewWidth, height:model.topViewMinHeight), popupModel: model)
        self.topView.cancelButton.addTarget(self, action: #selector(cancelButtonClick(btn:)), for: .touchUpInside)
        self.topView.confirmButton.addTarget(self, action: #selector(confirmButtonClick(btn:)), for: .touchUpInside)
    }
    
    @objc open func cancelButtonClick(btn:UIButton){
        self.hidden()
        if let cancelBlock = self.cancelBlock{
            cancelBlock(self,btn)
        }
    }
    
    @objc open func confirmButtonClick(btn:UIButton){
        if model.isConfirmHidden {
            self.hidden()
        }
        if let confirmBlock = self.confirmBlock{
            confirmBlock(self,btn)
        }
    }
    
    open  func show() {
        if self.isAnimation {
            return
        }
        self.isAnimation = true
        UIView.animate(withDuration: 0.25) {
            self.setupPopupViewAnimate(isShow: true)
        } completion: { (_) in
            self.isAnimation = false
        }
    }
    
    @objc open func hidden() {
        if self.isAnimation {
            return
        }
        self.isAnimation = true
        UIView.animate(withDuration: 0.25) {
            self.setupPopupViewAnimate(isShow: false)
        } completion: { (_) in
            self.isAnimation = false
            self.removeFromSuperview()
            
        }
    }
    
    private func setupPopupViewAnimate(isShow:Bool) {
        
        if isShow {
            if style == .center {
                self.popupView.isHidden = false
            }else{
                var rect = self.popupView.frame
                rect.origin.y = kZJJScreenHeight-rect.size.height
                self.popupView.frame = rect
            }
            
        }else{
            if style == .center {
                self.popupView.isHidden = true
            }else{
                var rect = self.popupView.frame
                rect.origin.y =  kZJJScreenHeight
                self.popupView.frame = rect
                
            }
        }
    }
    
    private func setupUI() {
        self.addSubview(self.popupView)
        self.backgroundColor = model.coverColor
        self.popupView.backgroundColor = .clear
        if self.contentView.backgroundColor == nil || self.contentView.backgroundColor == .clear  {
            self.contentView.backgroundColor = .white
        }
        self.popupView.addSubview(self.contentView)
        
        let contentViewHeight = max(contentView.frame.size.height, model.contentViewMinHeight)
        var topViewViewHeight:CGFloat = 0
        var popuViewWidth:CGFloat = self.contentView.frame.size.width
        if !model.isHiddenTopView {
            topViewViewHeight = max(topView.frame.size.height, model.topViewMinHeight)
            popuViewWidth = self.topView.frame.size.width
            self.popupView.addSubview(self.topView)
        }else{
            if popuViewWidth < 1 {
                popuViewWidth = kZJJScreenWidth
            }
        }
        
        let popupViewHeight:CGFloat = contentViewHeight + topViewViewHeight
        self.popupView.frame = CGRect.init(x: 0, y: kZJJScreenHeight+kZJJScreenHeight-popupViewHeight, width:popuViewWidth, height: popupViewHeight)
        if style == .center {
            self.popupView.center = CGPoint.init(x: kZJJScreenWidth/2.0, y: kZJJScreenHeight/2.0)
            self.popupView.isHidden = true
        }else{
            self.popupView.center = CGPoint.init(x: kZJJScreenWidth/2.0, y: self.popupView.center.y)
        }
        
        self.contentView.frame = CGRect.init(x: 0, y: topViewViewHeight-1, width: popuViewWidth, height:contentViewHeight+1)
        self.contentView.center = CGPoint.init(x: self.popupView.frame.size.width/2.0, y: self.contentView.center.y)
        //设置圆角
        self.setCornersRadius()

    }
    
    private func setCornersRadius(){
        let radius = model.popupViewRadius
        if radius > 0 {
            if model.popupViewStyle == .bottom {
                self.popupView.jj_setCornersRadius(radius: radius, roundingCorners: [.topLeft,.topRight])
            }else{
            self.popupView.jj_setCornersRadius(radius: radius, roundingCorners: [.allCorners])
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func getWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            
            for scene in UIApplication.shared.connectedScenes {
                if scene.activationState == .foregroundActive,let window = (scene as! UIWindowScene).windows.first {
                    return window
                }
            }
            
            if UIApplication.shared.windows.count > 0 {
                for window in UIApplication.shared.windows {
                    if window.isMember(of: UIWindow.self) {
                        return window
                    }
                }
            }
        }else{
            if let delegate = UIApplication.shared.delegate,let window = delegate.window,let w = window {
                return w
            }
            
        }
        return nil
        
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchView = touch.view else {
            return model.isTouchHidden
        }
        //touchView的frame转化到popupView上的frame
        let frame = touchView.convert(touchView.frame, to: self.popupView)
        if frame.origin.x >= 0&&frame.origin.y >= 0 {
            //说明点击的是popupView上的视图
            return false
        }
        return model.isTouchHidden
    }
    
    
}


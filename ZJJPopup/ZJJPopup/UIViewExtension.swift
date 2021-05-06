//
//  UIViewExtension.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/29.
//

import UIKit

extension UIView {
    //设置圆角
    func jj_setCornersRadius(radius: CGFloat, roundingCorners: UIRectCorner) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.shouldRasterize = true
        maskLayer.rasterizationScale = UIScreen.main.scale
        self.layer.mask = maskLayer
    }
    
}

extension UIWindow {
    
    static func current() -> UIWindow? {
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
    
    func currentVC() -> UIViewController?{
        if let rootVC = self.rootViewController{
            return UIWindow.getCurrentVC(form: rootVC)
        }
        return nil
    }
    
    static func currentVC() -> UIViewController?{
        if let rootVC = self.current()?.rootViewController{
            return self.getCurrentVC(form: rootVC)
        }
        return nil
    }
    
    static private func getCurrentVC(form rootVC:UIViewController) -> UIViewController?{
        var currentVC:UIViewController? = nil
        var rootPre = rootVC
        if rootPre.presentedViewController != nil {
            rootPre = rootVC.presentedViewController!
        }
        if rootVC.isKind(of: UITabBarController.self) {
            if let selectedViewController = (rootVC as! UITabBarController).selectedViewController {
                currentVC = self.getCurrentVC(form: selectedViewController)
            }
        }else if rootVC.isKind(of: UINavigationController.self){
            if let visibleViewController = (rootVC as! UINavigationController).visibleViewController {
                currentVC = self.getCurrentVC(form: visibleViewController)
            }
        }else{
            currentVC = rootPre
        }
        return currentVC
    }
}

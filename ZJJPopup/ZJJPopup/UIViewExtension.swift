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

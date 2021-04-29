//
//  ZJJCustomView.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/29.
//

import UIKit

typealias ZJJCustomViewCloseBlock = () -> ()

class ZJJCustomView: UIView {

    var closeBlock:ZJJCustomViewCloseBlock?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func close(block:ZJJCustomViewCloseBlock?)  {
        self.closeBlock = block
    }

    @IBAction func closeBtnClick(_ sender: UIButton) {
        if let block = self.closeBlock {
            block()
        }
    }
}

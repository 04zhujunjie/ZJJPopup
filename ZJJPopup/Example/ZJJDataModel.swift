//
//  ZJJDataModel.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/29.
//



import UIKit

struct ZJJDataModel:ZJJOptionProtocol {
    var jj_optionValue: String?{
        set{

        }
        get {
            return "\(title ?? "")--\(row ?? 0)"
        }
    }
    var title:String?
    var row:Int?
}

class ZJJCustomModel:NSObject,ZJJOptionProtocol{
    var jj_optionValue: String?{
        set{

        }
        get {
            return "\(title ?? "")"
        }
    }
    var icon:String?
    var title:String? 
 
}

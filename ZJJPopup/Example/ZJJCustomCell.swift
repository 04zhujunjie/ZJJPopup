//
//  ZJJCustomCell.swift
//  ZJJPopup
//
//  Created by weiqu on 2021/4/29.
//

import UIKit

class ZJJCustomCell: UITableViewCell {

    @IBOutlet weak private var iconImageView: UIImageView!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak  var selectImageView: UIImageView!
    var model:ZJJCustomModel!{
        didSet{
            self.updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell() {
        self.iconImageView.image = UIImage.init(named: model.icon ?? "")
        self.iconImageView.jj_setCornersRadius(radius: self.iconImageView.frame.size.width/2.0, roundingCorners: .allCorners)
        self.titleLabel.text = model.jj_optionValue
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

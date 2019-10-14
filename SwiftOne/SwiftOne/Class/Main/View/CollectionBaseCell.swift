//
//  CollectionBaseCell.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet var nickNameLabel: UILabel!
    
    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet var online: UIButton!
    
    var model : AnchorModel? {
        didSet {
            guard let model = model else {return}
            nickNameLabel.text = model.room_name
            var onlineStr : String
            if model.online >= 10000 {
                onlineStr = "\(Int(model.online / 10000))万在线"
            }else {
                onlineStr = "\(model.online)在线"
            }
            online.setTitle(onlineStr, for: .normal)
            iconImage.kf.indicatorType = .activity
            let url = URL(string: model.vertical_src)
            iconImage.kf.setImage(with: url,placeholder: UIImage(named: "Img_default"))
              
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.layer.cornerRadius = 5;
        iconImage.layer.masksToBounds = true
    }
}

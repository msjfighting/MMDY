//
//  CollectionGameCell.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    var model : BaseModel? {
        didSet {
            titleLabel.text = model?.tag_name
            if model?.small_icon_url == "" {
                iconImage.image = UIImage(named: "home_more_btn")
            }else{
                let url = URL.init(string:model?.small_icon_url ?? "")
                let data : NSData! = NSData(contentsOf: url!) //转为data类型
                if data == nil {
                    iconImage.image = UIImage(named: model?.small_icon_url ?? "home_more_btn")
                }else {
                    iconImage.kf.setImage(with: url)
                }
                //iconImage.kf.setImage(with: url,placeholder: UIImage(named:model?.small_icon_url ?? "home_more_btn"))
            }
        }
    }
}

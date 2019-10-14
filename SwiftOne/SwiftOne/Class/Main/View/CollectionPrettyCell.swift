//
//  CollectionPrettyCell.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {
    @IBOutlet var city: UIButton!
    
     override var model : AnchorModel? {
        didSet {
            super.model = model
            city.setTitle(model?.anchor_city, for: .normal)
        }
    }
    
       override func awakeFromNib() {
           super.awakeFromNib()
           online.layer.cornerRadius = 3;
           online.layer.masksToBounds = true
       }
}

//
//  UICollectionNormalCell.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import Kingfisher
class UICollectionNormalCell: CollectionBaseCell {

    
    @IBOutlet var roomNameLabel: UILabel!
  
    
   override var model : AnchorModel? {
        didSet {
            super.model = model
            roomNameLabel.text = model?.room_name
        }
    }
}

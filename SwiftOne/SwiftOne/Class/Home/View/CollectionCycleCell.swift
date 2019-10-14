//
//  CollectionCycleCell.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet var iconImage: UIImageView!

    @IBOutlet var titleLabel: UILabel!
    
    var cycle : CycleModel? {
        didSet {
            titleLabel.text = cycle?.title
            let url = URL(string: cycle?.pic_url ?? "")!
            iconImage.kf.setImage(with: url,placeholder: UIImage(named: "Img_default"))
            
        }
    }
}

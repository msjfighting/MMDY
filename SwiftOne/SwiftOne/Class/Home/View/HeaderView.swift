//
//  HeaderView.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import Kingfisher
class HeaderView: UICollectionReusableView {
    @IBOutlet var icon: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var moreBtn: UIButton!
    var group : AnchorGroup? {
        didSet {
            guard let group = group else {return}
            title.text = group.tag_name
            icon.kf.indicatorType = .activity
            if group.small_icon_url == "" {
                icon.image = UIImage(named: "home_header_normal")
            }else {
                let url = URL.init(string: group.small_icon_url)
                let data : NSData! = NSData(contentsOf: url!) //转为data类型
                if data == nil {
                   icon.image = UIImage(named: group.small_icon_url)
                }else {
                   icon.kf.setImage(with: url)
                }
            }
           
//             icon.kf.setImage(with: url, placeholder: UIImage(named: group.small_icon_url))
        }
    }
}

extension HeaderView {
    class func headerView() -> HeaderView {
        
        return Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.first as! HeaderView
    }
}

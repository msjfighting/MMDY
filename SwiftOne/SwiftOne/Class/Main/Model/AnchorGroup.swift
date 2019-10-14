//
//  AnchorGroup.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel{
    public lazy var anchors : [AnchorModel] = [AnchorModel]()
    
   @objc var room_list : [[String : NSObject]]? {
        // 监听属性改变
        didSet {
            guard let room_list = room_list else { return }
             for dict in room_list {
                anchors.append(AnchorModel.deserialize(from: dict)!)
            }
        }
    }
}

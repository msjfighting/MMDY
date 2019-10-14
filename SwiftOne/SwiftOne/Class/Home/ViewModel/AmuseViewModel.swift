//
//  AmuseViewModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
  
}
extension AmuseViewModel {
    func requestAmuseData(callBack : @escaping()->()) {
            loadAnchorData(isGroupData: true,urlString: "getHotRoom/2",finishedCallBack: callBack)
        }
}

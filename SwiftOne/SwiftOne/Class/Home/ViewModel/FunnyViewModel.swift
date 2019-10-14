
//
//  FunnyViewModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel {

}

extension FunnyViewModel {
    func requestFunnyData(callBack : @escaping()->()) {
        loadAnchorData(isGroupData: false,urlString: "getHotRoom/3",param:["limit":"30","offset":"0"] ,finishedCallBack: callBack)
        }
}

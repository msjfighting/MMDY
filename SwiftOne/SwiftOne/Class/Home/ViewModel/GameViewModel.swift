//
//  GameViewModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/11.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class GameViewModel {
  lazy var anchorGroup : [GameModel] = [GameModel]()
}
extension GameViewModel {
   func requestGameData(callBack : @escaping()->()) {
    let params = ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]
        NetworkTools.requestData(type: .GET, urlString: BaseURL + "getHotCate", params: params, finishedCallBack: { (response) in
            guard let resultDict = response as? [String : NSObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else { return }
            for dic in dataArr {
              let group = GameModel.deserialize(from: dic)
              self.anchorGroup.append(group!)
            }
            callBack()
        }) { (error) in}
    
    }
}

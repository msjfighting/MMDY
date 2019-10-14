//
//  BaseViewModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/12.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit

class BaseViewModel {
  lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool,urlString : String,param: [String : Any]? = nil,finishedCallBack : @escaping () -> () ) {
            NetworkTools.requestData(type: .GET, urlString: BaseURL + urlString,params: param, finishedCallBack: { (response) in
                    guard let resultDict = response as? [String : NSObject] else {return}
                    guard let dataArr = resultDict["data"] as? [[String : NSObject]] else { return }
                
                    if isGroupData {
                        for dic in dataArr {
                             let group = AnchorGroup.deserialize(from: dic)
                             self.anchorGroup.append(group!)
                        }
                    }else {
                        let group = AnchorGroup()
                          for dic in dataArr {
                              let anchor = AnchorModel.deserialize(from: dic)
                              group.anchors.append(anchor!)
                           }
                        self.anchorGroup.append(group)
                    }
                    finishedCallBack()
            }) { (error) in}
    }
}

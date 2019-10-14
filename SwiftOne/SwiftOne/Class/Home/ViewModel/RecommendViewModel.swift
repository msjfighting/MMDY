//
//  RecommendViewModel.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
class RecommendViewModel : BaseViewModel{
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyDataGroup : AnchorGroup = AnchorGroup()
   
    lazy var cycleDatas : [CycleModel] = [CycleModel]()
   
    
}

extension RecommendViewModel {
    func requestData(callBack : @escaping()->()) {
        let params = ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]
        
        let disGroup = DispatchGroup()
       
        // 请求推荐数据
        disGroup.enter()
       NetworkTools.requestData(type: .GET, urlString: BaseURL + "getbigDataRoom",params: params, finishedCallBack: { (response) in
                    guard let dict = response as? [String : NSObject] else { return }
                      guard let dataArr = dict["data"] as? [[String : NSObject]] else { return }
                    self.bigDataGroup.tag_name = "热门推荐"
                    self.bigDataGroup.icon_url = "home_header_hot"
                    self.bigDataGroup.small_icon_url = "home_header_hot"
                      for dic in dataArr {
                          let anchor = AnchorModel.deserialize(from: dic)
                        self.bigDataGroup.anchors.append(anchor!)
                      }
         disGroup.leave()
       }) { (error) in}
        
        
        // 请求颜值数据
        disGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: BaseURL + "getVerticalRoom", params: params, finishedCallBack: { (response) in
                    guard let dict = response as? [String : NSObject] else { return }
                    guard let dataArr = dict["data"] as? [[String : NSObject]] else { return }
                self.prettyDataGroup.tag_name = "颜值"
                self.prettyDataGroup.icon_url = "home_header_phone"
               self.prettyDataGroup.small_icon_url = "home_header_phone"
                    for dic in dataArr {
                        let anchor = AnchorModel.deserialize(from: dic)
                        self.prettyDataGroup.anchors.append(anchor!)
                    }
            disGroup.leave()
        }) { (error) in}
        
        
        // 请求后面部分数据
         disGroup.enter()
         loadAnchorData(isGroupData: true,urlString: "getHotCate",param: params) {
                disGroup.leave()
            }
        
         disGroup.notify(queue: .main) {
            self.anchorGroup.insert(self.prettyDataGroup, at: 0)
            self.anchorGroup.insert(self.bigDataGroup, at: 0)
            callBack()
        }
    }
    
    func requestCycleData(callback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: BaseURL + "slide/6", params: ["version":"2.300"], finishedCallBack: { (response) in
            guard let resultDict = response as? [String : NSObject] else {return}
            guard let dataArr = resultDict["data"] as? [[String : NSObject]] else { return }
            for dict in dataArr {
                let cycle = CycleModel.deserialize(from: dict)
                self.cycleDatas.append(cycle!)
            }
            callback()
        }) { (error) in}
    }

}

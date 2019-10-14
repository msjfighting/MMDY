//
//  NetworkTools.swift
//  SwiftOne
//
//  Created by zlhj on 2019/10/10.
//  Copyright © 2019 msj. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    // @escaping 一个接受闭包作为参数的函数，该闭包可能在函数返回后才被调用，也就是说这个闭包逃离了函数的作用域，这种闭包称为逃逸闭包
    class func requestData(type : MethodType, urlString : String, params : [String : Any]? = nil, finishedCallBack : @escaping (_ result:Any) -> (),error :  @escaping (_ result : Any) -> ()) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method , parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                 error(response.result.error!)
                return
            }
            finishedCallBack(result)
        }
    }
}

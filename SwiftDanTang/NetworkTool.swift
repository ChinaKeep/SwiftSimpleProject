//
//  NetworkTool.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/1.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

//网络请求封装

typealias NetworkFinished = (_ success :Bool ,_ result:JSON?,_ error : NSError?) -> ()

extension NetworkTool{
       //MARK: - GET
    /// - Parameters
    ///  -url :urlString
    ///  - params: 参数
    ///  - finished:完成回调
    ///  使用Alamofire进行网络请求时，调用方法的参数都是通过getRequest(urlString,params,success:,failure:)传入的其实是一个接受 [String:AnyObject]类型 返回void类型的函数
    
    func get(url:String,parms:[String:Any],finished:@escaping NetworkFinished) {
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        SVProgressHUD.show(withStatus:"正在加载中。。。")
        Alamofire.request(url, method: HTTPMethod.get, parameters: parms, headers: nil).responseJSON { [weak self](response) in
            /*
             这里使用了闭包
             当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
             使用switch判断请求是否成功，也就是response的result
             
             */
            print("url:",response.response?.url as Any,"\n",response.result.value as Any)
            self?.handle(response: response, finished: finished)
        }
    }
    
    //MARK: - PSOT
    ///
    /// - Parameters
    /// - params:参数
    /// - url: urlString
    /// - finished:完成回调
    
    func post(url:String,params:[String:Any],finished:@escaping NetworkFinished) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show(withStatus:"正在加载中....")
        Alamofire.request(url, method: HTTPMethod.post, parameters: params,encoding:URLEncoding.default, headers: nil).responseJSON{[weak self](response) in
            
                print("POST url:",response.response?.url as Any,"\n",response.result.value as Any)
            self?.handle(response: response, finished: finished)
        }
    }
    
    
    //MARK: - 照片上传
    /// -Parameters
    /// - urlString:服务器地址
    /// - params: 必传参数["flag":"","userId":""] - flag,userId 为必传参数
    /// - data: image转换成data
    /// - name:fileName
    /// - success：
    /// -failture:
    func uploadImageRequest(url:String,params:[String:String],data:[Data],name:[String],finished:@escaping NetworkFinished) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show(withStatus:"正在加载中....")
        
        let headers = ["content-type":"multipart/form-data"]

        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: url,
            headers: headers,
            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        if let value = response.result.value as? [String: AnyObject]{
//                            success(value)
//                            let json = JSON(value)
//                            PrintLog(json)
//                        }
//                    }
//                case .failure(let encodingError):
//                    PrintLog(encodingError)
//                    failture(encodingError)
//                }
        }
        )
    }
    //处理响应结果
    /// - response:响应完成
    /// - finished:完成响应
    fileprivate func handle(response:DataResponse<Any>,finished:@escaping NetworkFinished){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            SVProgressHUD.dismiss()
            finished(true,json,nil)
            break
            
        case .failure(let error):
            SVProgressHUD.showError(withStatus: "请求失败，请重试")
            finished(false,nil,error as NSError?)
            break
        }
    }

}

class NetworkTool: NSObject{
    
    //swift 单行单例
    static let shared = NetworkTool()
    
    func loadHomeTopData(finished:@escaping (_ channel:[TXHomeTopModel]) -> ()) {

        let url  = BASE_URL+"v2/channels/preset"
        let params = ["gender":1,"generation":1]
        SVProgressHUD.show()
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            
            if let value = response.result.value{
                print("url:",response.response?.url as Any,"\n",
                response.result.value as Any)
                
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                
                let data = dict["data"].dictionary
                
                if let channels = data!["channels"]?.arrayObject{
                    var tx_channels = [TXHomeTopModel]()
                    for channle  in channels{
                        let tx_channel = TXHomeTopModel(dict:channle  as! [String:AnyObject])
                        tx_channels.append(tx_channel)
                    }
                    finished(tx_channels)
                }
                
            }
        }
        
    }
    
    ///获取首页数据
    func loadHomeInfo (id:Int,finished:@escaping(_ homeModel:[HomeModel]) -> ()) {
    
    let url  = BASE_URL + "/v1/channels/\(id)/items"
        
    let params = ["gender":1,
                  "generation":1,
                  "limit":20,
                  "offset":0
        ]
        
        SVProgressHUD.show()
        Alamofire.request(url,
                          parameters:params)
        .responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            print("url:",response.response?.url as Any,"\n",
                  response.result.value as Any)
            if let value = response.result.value {
                print(response.result.value as Any)
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                let data = dict["data"].dictionary
                if let items = data?["items"]?.arrayObject{
                    var models  = [HomeModel]()//定义可变数组
                    for item in items{
                        let model = HomeModel(dict:item as! [String:AnyObject])
                        models.append(model)
                    }
                    finished(models)
                }
            }
        }
    
    }
    
    //获取单品数据  闭包相当于block 用于返回model的数组
    func loadProductData(finished:@escaping(_ productModel:[ProductModel]) -> ()) {
        let url = BASE_URL + "v2/items"
        let params = ["gender":1,
                      "generation":1,
                      "limit":20,
                      "offset":0]
        SVProgressHUD.show()
        Alamofire.request(url,parameters: params)
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            print("url:",response.response?.url as Any,"\n",response.result.value as Any)
            if let value = response.result.value {
                print(response.result.value as Any)
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                let  data = dict["data"].dictionary
                if let itmes = data?["items"]?.arrayObject{
                    var products = [ProductModel]()
                    for item in itmes{
                        let itemDic = item as! [String :AnyObject]
                        if let itemData = itemDic["data"]{
                            let product = ProductModel(dict:itemData as! [String: AnyObject])
                            products.append(product)
                        }
                    }
                    finished(products)
                }
                
            }
        }
    }

    
    //单品详情
    func loadProductDetailData(id:Int,finished:@escaping(_ productDetailModel:ProductDetailModel)->()){
        let url  = BASE_URL + "v2/items/\(id)"
        SVProgressHUD.show(withStatus:"正在加载中...")
        Alamofire
        .request(url)
        .responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            print("url:",response.response?.url as Any ,"\n",response.result.value as Any)
            if let value = response.result.value {
                print(response.result.value as Any)
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else{
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionaryObject{
                    let productDetail = ProductDetailModel(dict:data as [String : AnyObject])
                    finished(productDetail)
                }
            }
            
        }
        
    }
    
}
    
   

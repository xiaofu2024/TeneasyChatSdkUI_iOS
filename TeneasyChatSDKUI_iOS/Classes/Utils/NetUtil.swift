//
//  NetUtil.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by XiaoFu on 2023/2/2.
//

typealias RequestCompletionBlock = (_ response: URLResponse?, _ responseObject: [String: Any]?, _ error: Error?) -> Void

class NetRequest: NSObject {
    // 声明单例
    static let standard = NetRequest()

    func enqueueGETRequest(urlStr: String, completionHandler: RequestCompletionBlock? = nil) {
        let destUrl = URL(string: urlStr)!
        /// 发送请求的 session 对象
        let session = URLSession.shared
        /// 请求的 request
        var request = URLRequest(url: destUrl)
        request.httpMethod = "GET"
        // 设置请求头参数
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

        request.timeoutInterval = 60.0

        session.configuration.timeoutIntervalForRequest = 30.0

        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in

            guard error == nil, let data: Data = data, let _: URLResponse = response else {
                print("请求出错：\(error!.localizedDescription)")
                return
            }

            let dataStr = String(data: data, encoding: String.Encoding.utf8)!
            let responseObject = self.responseObjectFromJSONString(jsonString: dataStr)
            print("POST请求 URL=\(destUrl)")
            print("GET请求结果：\(responseObject)")
        }
        // 开始请求
        task.resume()
    }

    func enqueuePOSTRequest(urlStr: String, params: [String: Any]? = nil, completionHandler: RequestCompletionBlock? = nil) {
        let destUrl = URL(string: urlStr)!
        /// post请求参数
        let paramsData = try? JSONSerialization.data(withJSONObject: params ?? Dictionary(), options: [])

        /// 发送请求的 session 对象
        let session = URLSession.shared
        /// 请求的 request
        var request = URLRequest(url: destUrl)

        request.httpMethod = "POST"
        /// post请求参数
        request.httpBody = paramsData

        // 根据API的要求，设置请求头参数
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")

        /// 发送 POST请求
        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in

            guard error == nil, let data: Data = data, let _: URLResponse = response else {
                print("请求出错：\(error!.localizedDescription)")
                return
            }

            // data 转json字符串
            let dataStr = String(data: data, encoding: String.Encoding.utf8)!
            print("dataStr = \(dataStr)")

            let responseObject = self.responseObjectFromData(data: data)

            print("POST请求 URL=\(destUrl) 参数：\(params ?? Dictionary())")
            print("POST请求结果：\(responseObject)")
        }
        // 开始请求
        task.resume()
    }

    /// jsonString 转 json
    func responseObjectFromJSONString(jsonString: String) -> [String: Any] {
        let jsonData: Data = jsonString.data(using: String.Encoding.utf8)!
        let resultDic = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
        if resultDic != nil {
            return resultDic as! [String: Any]
        }
        return Dictionary()
    }

    /// data 转 JSON
    func responseObjectFromData(data: Data) -> [String: Any] {
        let resultDic = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if resultDic != nil {
            return resultDic as! [String: Any]
        }
        return Dictionary()
    }

    func upload(image: UIImage) {
        guard let dataTmp = image.jpegData(compressionQuality: 0.1) else { return }
        let uploadurl = "https://csapi.xdev.stream/v1/assets/upload"

        var request = URLRequest(url: URL(string: uploadurl)!)

        request.httpMethod = "POST"

        var boundary = "-------------------21212222222222222222222"

        var contentType = "multipart/form-data;boundary=" + boundary

        request.addValue(contentType, forHTTPHeaderField: "Content-Type")

        var body = NSMutableData()

        body.append(NSString(format: "\r\n--\(boundary)\r\n" as NSString).data(using: NSUTF8StringEncoding)!)

        body.append(NSString(format: "Content-Disposition:form-data;name=\"userfile\";filename=\"dd.jpg\"\r\n").data(using: NSUTF8StringEncoding)!)

        body.append(NSString(format: "Content-Type:application/octet-stream\r\n\r\n").data(using: NSUTF8StringEncoding)!)

        body.append(dataTmp)

        body.append(NSString(format: "\r\n--\(boundary)" as NSString).data(using: NSUTF8StringEncoding)!)

//                request.httpBody=body
//
//        let que=OperationQueue()
//
//               NSURLConnection.sendAsynchronousRequest(request, queue: que, completionHandler: {
//                    (response, data, error) ->Void in
//
//
//
//                   if (error != nil){
//                       println(error)
//
//                    }else{
//                        //Handle data in NSData type
//
//                       var tr:String=NSString(data:data,encoding:NSUTF8StringEncoding)!
//
//                       println(tr)
//
//                        //在主线程中更新UI风火轮才停止
//
//                        dispatch_sync(dispatch_get_main_queue(), {
//
//                           self.av.stopAnimating()
//
//                         //self.lb.hidden=true
//
//
//
//                        })
//
//
//
//                    }
//
//                })
    }
}

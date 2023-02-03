//
//  NetUtil.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by XiaoFu on 2023/2/2.
//
import Alamofire

typealias RequestCompletionBlock = (_ response: URLResponse?, _ responseObject: [String: Any]?, _ error: Error?) -> Void

class NetRequest: NSObject, URLSessionDelegate {
    // 声明单例
    static let standard = NetRequest()
//
//    func uploadingImage(imageData: Data) {
//        let uploadurl = "https://csapi.xdev.stream/v1/assets/upload"
//        let baseHeaders = HTTPHeaders()
//        let manager = Alamofire.AF
//        manager.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageData, withName: "myFile", fileName: "file.jpg", mimeType: "image/jpg")
//        }, to: uploadurl, headers: baseHeaders) { encodingResult in
//            print("我的：\(encodingResult)")
//            switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        if let data = response.data {
    ////                                        let responseJson = JSON(data: data)
    ////                                        if responseJson["status"].intValue == 1 {
    ////                                            //上传成功，刷新当前头像
    ////                                            }
    ////                                        } else {
    ////                                           let msg = responseJson["msg"].stringValue
    ////                                           self.showMessage(msg)
    ////                                        }
//                        }
//                    }
//                case .failure(let encodingError):
//                    log.debug(encodingError)
    ////                                self.showMessage("上传图片失败")
//            }
//        }
//    }

    public func uploadDocument(file: Data, filename: String, handler: @escaping (String) -> Void) {
        let bearertoken = "Bearer "
        let uploadurl = "https://csapi.xdev.stream/v1/assets/upload"
        let headers: HTTPHeaders = [
            "X-Token": "CCcQAxgDICEogqPPp-Ew.dqUVvR_wpsfIQ27wmV1Z1elKN2Ea-tIg9mENUfx1dJTZewGMkmnEjXu7eshJc2MldVO2H5MjvwfsxycUcrBIBw",
            "Content-type": "multipart/form-data",
            "Content-Disposition": "form-data;filename=lt_biaoqing.png",
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(file, withName: "myFile", fileName: filename, mimeType: "image/jpeg")
            },
            to: uploadurl, method: .post, headers: headers)
            .response { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success:
                    let json = response.data
                    if json != nil {
                        do {
                            if let jsonData = response.data {
//                                let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary
//                                print(parsedData)
                            }
                        } catch {
                            print("error message")
                        }
                    }
                }
            }
    }
}

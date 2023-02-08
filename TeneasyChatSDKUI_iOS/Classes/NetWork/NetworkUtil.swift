//
//  NetUtil.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by darren chen on 2023/2/8.
//

import Foundation
import HandyJSON

class NetworkUtil {
    static func getWorker(workerId: Int32,  done: @escaping ((_ success: Bool, _ data: WorkerModel?) -> Void)) {
        chatProvider.request(ChatApi.queryWorker(workerId: workerId)) { result in
            switch result {
                case .success(let response):
                    let dic = try? response.mapJSON() as? Dictionary<String, Any>
                    let result = BaseRequestResult.deserialize(from: dic)
                print(result?.code)
                print(result?.toJSON())
                case .failure(let error):
                    print(error)
            }
        }
    }
}


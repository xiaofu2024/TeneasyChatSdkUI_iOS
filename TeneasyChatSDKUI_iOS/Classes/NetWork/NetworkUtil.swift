//
//  NetUtil.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by darren chen on 2023/2/8.
//

import Foundation
import HandyJSON

let BaseUrl = "https://csapi.hfxg.xyz/v1"

enum NetworkUtil {
    static func getWorker(workerId: Int32, done: @escaping ((_ success: Bool, _ data: WorkerModel?) -> Void)) {
        let task = ChatApi.queryWorker(workerId: workerId)
        print("请求路径: \(task.baseURL)\(task.path)===\(task.method)")
        print("请求header: \(String(describing: task.headers))")
        ChatProvider.request(ChatApi.queryWorker(workerId: workerId)) { result in
            switch result {
                case .success(let response):
                    let dic = try? response.mapJSON() as? [String: Any]
                    let result = BaseRequestResult<WorkerModel>.deserialize(from: dic)

                    if result?.code == 0 {
                        done(true, result?.data)
                    } else {
                        done(false, nil)
                    }
                case .failure(let error):
                    print(error)
                    done(false, nil)
            }
        }
    }
}

//
//  NetUtil.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by Xiao Fu on 2023/2/8.
//

import Foundation
import HandyJSON

enum NetworkUtil {
    //获取客服的姓名和头像
    static func getWorker(workerId: Int32, done: @escaping ((_ success: Bool, _ data: WorkerModel?) -> Void)) {
        let task = ChatApi.queryWorker(workerId: workerId)
        print("请求路径: \(task.baseURL)\(task.path)===\(task.method)")
        print("请求header: \(String(describing: task.headers))")
        ChatProvider.request(ChatApi.queryWorker(workerId: workerId)) { result in
            switch result {
                case .success(let response):
                print(response)
                    let dic = try? response.mapJSON() as? [String: Any]
                print(dic)
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

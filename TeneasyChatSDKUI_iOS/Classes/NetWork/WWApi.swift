import Moya
// 生成请求封装类
let chatProvider = MoyaProvider<ChatApi>()

enum ChatApi {
    case queryWorker(workerId: Int32 = 1)
}

/// 实现TargetType协议
extension ChatApi: TargetType {
    /// url
    var baseURL: URL {
        return URL(string: "https://csapi.hfxg.xyz/v1")!
    }
    
    /// 请求路径
    var path: String {
        switch self {
        case .queryWorker:
            return "/api/query-worker"
        }
    }
    
    /// 请求方式
    var method: Moya.Method {
        return .post
    }
    
    /// 解析格式
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        // 公共参数
        var params: [String: Any] = ["workerId": 1]
        
        // 收集参数
        switch self {
        case let .queryWorker(id):
            params["workerId"] = id
        }
        
        print("请求路径: \(self.baseURL)\(self.path)===\(self.method)")
        print("请求参数: \(params)")
        print("请求header: \(String(describing: self.headers))")
        // 发起请求
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    /// 公共请求头
    var headers: [String: String]? {
        return ["X-Token": "CCcQARgKIBwotaa8vuAw.TM241ffJsCLGVTPSv-G65MuEKXuOcPqUKzpVtiDoAnOCORwC0AbAQoATJ1z_tZaWDil9iz2dE4q5TyIwNcIVCQ", "Content-Type":"application/json"]
    }
}

import Moya
// 生成请求封装类
let ChatProvider = MoyaProvider<ChatApi>()

enum ChatApi {
    case queryWorker(workerId: Int32 = 1)
    case queryAutoReplay(consultId: Int32 = 0)
    case queryEntrance
    case assignWorker(consultId: Int32 = 0)
}

/// 实现TargetType协议
extension ChatApi: TargetType {
    /// url
    var baseURL: URL {
        return URL(string: baseUrlApi)!
    }
    
    /// 请求路径
    var path: String {
        switch self {
        case .queryWorker:
            return "/api/query-worker/"
        case .queryAutoReplay:
            return "/api/query-auto-reply"
        case .queryEntrance:
            return "/api/query-entrance"
        case .assignWorker:
            return "/api/assign-worker"
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
        switch self {
        case .queryWorker(let id):
            return .requestParameters(parameters: ["workerId": id], encoding: JSONEncoding.default)
        case .queryAutoReplay(let id), .assignWorker(let id):
            return .requestParameters(parameters: ["consultId": id], encoding: JSONEncoding.default)
        case .queryEntrance:
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    /// 公共请求头
    var headers: [String: String]? {
        return ["X-Token": XToken, "Content-Type": "application/json"]
    }
}

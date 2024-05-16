//
//  Constant.swift
//  Pods
//
//  Created by tian molin on 10/2/23.
//

import Foundation

//开发环境
//let baseUrlImage = "https://sssacc.wwc09.com" //用于拼接图片地址
//let baseUrlImageApi = "https://csapi.xdev.stream"  //用于请求数据，上传图片
//let baseUrlApi = "https://wcsapi.qixin14.xyz/v1"    //用于大多数Api
//var XToken = ""

//线上环境
//let baseUrlImage = "https://images2acc.wwc09.com" //用于拼接图片地址
//let baseUrlApi = "https://csapi.ertw.xyz"//用于请求数据，上传图片



/*
 sssacc.wwc09.com  预发客户。//预发客户   这个是给前端用的
 images2acc.wwc09.com  生产客户
 */

var lines = "https://csapi.xdev.stream,https://wcsapi.qixin14.xyz,https://wcsapi.qixin14.xyz"
        var CONSULT_ID: Int32 = 1
        var xToken = ""
        var cert = "COYBEAUYASDyASiG2piD9zE.te46qua5ha2r-Caz03Vx2JXH5OLSRRV2GqdYcn9UslwibsxBSP98GhUKSGEI0Z84FRMkp16ZK8eS-y72QVE2AQ"
       var domain = "wcsapi.qixin14.xyz"  //domain
var baseUrlApi = "https://" + domain  //用于请求数据，上传图片
var baseUrlImage = "https://sssacc.wwc09.com" //用于拼接图片地址

       var merchantId = 230
       var userId = 1125324
       var workerId = 2

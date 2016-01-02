//
//  Network.swift
//  teknappi
//
//  Created by Jussi Vesala on 29.11.2015.
//  Copyright © 2015 Jussi Vesala. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Argo

struct ServerResult {
    var result: String?
}

extension ServerResult: Decodable {
    static func create(result: String?) -> ServerResult {
        return ServerResult(result: result)
    }

    static func decode(json: JSON) -> Decoded<ServerResult> {
        return ServerResult.create
            <^> json <|? "result"
    }
}

class Server {
    static func sendContactRequest(phoneNumber: String) -> Observable<ServerResult> {
        let url = NSURL(string: "https://teknappimock.herokuapp.com/tek/api/v1/requestContact")
        let params = ["phoneNumber": phoneNumber] as Dictionary<String, String>
        let data = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        return doPost(url!, data: data)
            .map { (data: AnyObject!) -> ServerResult in
                let postResult: ServerResult? = decode(data)
                return postResult ?? ServerResult.create("error")
            }
            .catchErrorJustReturn(ServerResult.create("error"))
    }

    static func doPost(url: NSURL, data: NSData) -> Observable<AnyObject!> {
        let request = NSMutableURLRequest(URL: url, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.HTTPBody = data
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        return session.rx_JSON(request).retry(3)
    }
}
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
        return doPost(url!)
    }

    static func doPost(url: NSURL) -> Observable<ServerResult> {
        let request = NSMutableURLRequest(URL: url, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        request.HTTPMethod = "POST"
        return session.rx_JSON(request)
            .map { (data: AnyObject!) -> ServerResult in
                let postResult: ServerResult? = decode(data)
                return postResult ?? ServerResult.create("error")
            }
            .retry(3)
            .catchErrorJustReturn(ServerResult.create("error"))
    }
}
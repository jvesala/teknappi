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

class Server {
    static func sendContactRequest(phoneNumber: String) -> Observable<ContactRequestResult> {
        let url = NSURL(string: "https://teknappimock.herokuapp.com/tek/api/v1/requestContact")
        let params = ["phoneNumber": phoneNumber]
        let data = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        return doPost(url!, data: data)
            .map { (data: AnyObject!) -> ContactRequestResult in
                let postResult: ContactRequestResult? = decode(data)
                return postResult ?? ContactRequestResult.create("error")
            }
            .catchErrorJustReturn(ContactRequestResult.create("error"))
    }

    static func sendLogin(user: String, password: String, personIdEnd: String) -> Observable<LoginResult> {
        let url = NSURL(string: "https://teknappimock.herokuapp.com/tek/api/v1/login")
        let params = ["user": user, "password": password, "personIdEnd": personIdEnd]
        let data = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        return doPost(url!, data: data)
            .map { (data: AnyObject!) -> LoginResult in
                let postResult: LoginResult? = decode(data)
                return postResult!
            }
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
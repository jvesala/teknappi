//
//  Domain.swift
//  teknappi
//
//  Created by Jussi Vesala on 2.1.2016.
//  Copyright © 2016 Jussi Vesala. All rights reserved.
//

import Foundation
import Argo

struct ContactRequestResult {
    var result: String
}

struct LoginResult {
    var token: String
}

struct UserData {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
}

extension ContactRequestResult: Decodable {
    static func create(result: String) -> ContactRequestResult {
        return ContactRequestResult(result: result)
    }
    
    static func decode(json: JSON) -> Decoded<ContactRequestResult> {
        return ContactRequestResult.create <^> json <| "result"
    }
}

extension LoginResult: Decodable {
    static func create(token: String) -> LoginResult {
        return LoginResult(token: token)
    }

    static func decode(json: JSON) -> Decoded<LoginResult> {
        return LoginResult.create <^> json <| "token"
    }
}

extension UserData: Decodable {
    static func create(firstName: String)(lastName: String)(email: String)(phoneNumber: String) -> UserData {
        return UserData(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
    }
    
    static func decode(json: JSON) -> Decoded<UserData> {
        return UserData.create
            <^> json <| "firstName"
            <*> json <| "lastName"
            <*> json <| "email"
            <*> json <| "phoneNumber"
    }
}


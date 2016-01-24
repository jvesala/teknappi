//
//  UserDataRepository.swift
//  teknappi
//
//  Created by Jussi Vesala on 11.1.2016.
//  Copyright © 2016 Jussi Vesala. All rights reserved.
//

import Foundation


class UserDataRepository {
    static let TokenName = "loginToken"
    static func getLoginToken() -> String? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey(TokenName)
    }

    static func setLoginToken(loginToken: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(loginToken, forKey: TokenName)
    }
    
    static func reset() {
        print("Remove existing tokens for debug")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(TokenName)
    }
}

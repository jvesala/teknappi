//
//  UserDataRepository.swift
//  teknappi
//
//  Created by Jussi Vesala on 11.1.2016.
//  Copyright © 2016 Jussi Vesala. All rights reserved.
//

import Foundation


class UserDataRepository {
    static let LoginName = "loginToken"
    
    static func getLoginToken() -> String? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey(LoginName)
    }

    static func setLoginToken(loginToken: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(loginToken, forKey: LoginName)
    }
    
    static func reset() {
        print("Remove existing tokens for debug")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(LoginName)
    }
    
    static func setUserData(userData: UserData) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(userData.firstName, forKey: "firstName")
        defaults.setObject(userData.lastName, forKey: "lastName")
        defaults.setObject(userData.email, forKey: "email")
        defaults.setObject(userData.phoneNumber, forKey: "phoneNumber")
    }
    
    static func getUserData() -> UserData? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return UserData(firstName: defaults.stringForKey("firstName")!,
            lastName: defaults.stringForKey("lastName")!,
            email: defaults.stringForKey("email")!,
            phoneNumber: defaults.stringForKey("phoneNumber")!)
    }
}

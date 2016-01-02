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
    var result: String?
}

extension ContactRequestResult: Decodable {
    static func create(result: String?) -> ContactRequestResult {
        return ContactRequestResult(result: result)
    }
    
    static func decode(json: JSON) -> Decoded<ContactRequestResult> {
        return ContactRequestResult.create
            <^> json <|? "result"
    }
}


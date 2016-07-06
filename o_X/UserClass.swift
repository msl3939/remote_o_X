//
//  UserClass.swift
//  o_X
//
//  Created by Michelle Lee on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


class User {
    var email:String = ""
    var password:String = ""
    var token:String = ""
    var client:String = ""
    
    init (email:String, password:String, token:String, client:String) {
        self.email = email
        self.password = password
        self.token = token
        self.client = client
    }
}



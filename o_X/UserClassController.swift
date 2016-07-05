//
//  UserClassController.swift
//  o_X
//
//  Created by Michelle Lee on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController {
    static var sharedInstance: UserController = UserController()
   
    var users:[User] = []
   
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var currentUser: User?
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        for user in users {
            if user.email == email {
                onCompletion(nil, "Email address already in use")
                return
            }
        }
        if password.characters.count >= 6 {
            var newuser = User(email: email, password: password)
            onCompletion(newuser, nil)
            currentUser = newuser
            users.append(newuser)
            defaults.setObject(email, forKey: "currentUserEmail")
            defaults.setObject(password, forKey: "currentUserPassword")
            defaults.synchronize()
            
        }
        else {
            onCompletion(nil, "Password not long enough")
            return
        }
        
        
        
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        for user in users {
            if user.email == email
            && user.password == password
            { onCompletion(user, nil)
                currentUser = user
                return
            }}
        onCompletion(nil, "Email or password is incorrect")
        
       
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        
    }
    
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        currentUser = nil
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
    }
    
}



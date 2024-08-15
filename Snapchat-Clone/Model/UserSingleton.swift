//
//  UserSingleton.swift
//  Snapchat-Clone
//
//  Created by Sabri Çetin on 11.08.2024.
//

import Foundation


class UserSingleton {
        
    static let sharedUserInfo = UserSingleton()
        
    var email = ""
    var username = ""
        
    private init () {
        
    }
    
}

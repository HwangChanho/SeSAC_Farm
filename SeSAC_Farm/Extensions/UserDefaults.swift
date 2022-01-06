//
//  UserDefaults.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import Foundation

extension UserDefaults {
    static var token: String {
        get {
            return UserDefaults.standard.string(forKey: Constants.UserInfo.token)!
        }
    }
    
    static var userId: String {
        get {
            return UserDefaults.standard.string(forKey: Constants.UserInfo.userId)!
        }
    }
    
    func saveUserDefaults(token: String, name: String, id: Int, email: String) {
        UserDefaults.standard.set(token, forKey: Constants.UserInfo.token)
        UserDefaults.standard.set(name, forKey: Constants.UserInfo.userName)
        UserDefaults.standard.set(id, forKey: Constants.UserInfo.userId)
        UserDefaults.standard.set(email, forKey: Constants.UserInfo.userEmail)
    }
    
    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: Constants.UserInfo.token)
        UserDefaults.standard.removeObject(forKey: Constants.UserInfo.userName)
        UserDefaults.standard.removeObject(forKey: Constants.UserInfo.userId)
        UserDefaults.standard.removeObject(forKey: Constants.UserInfo.userEmail)
    }
}

//
//  StartViewModel.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import Foundation

class StartViewModel: UserDefaults {
    var nickName: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func login(completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.login(identifier: nickName.value, password: password.value) { data, error, errorData in
            
            switch error {
            case .invalidData:
                completion(errorData)
            case .failed:
                completion(nil)
            case .invalidResponse:
                completion(nil)
            default:
                print("login Success")
            }
            
            guard let data = data else {
                return
            }
            
            self.removeUserDefaults()
            self.saveUserDefaults(token: data.jwt, name: data.user.username, id: data.user.id, email: data.user.email)
            
            completion(nil)
        }
    }
}

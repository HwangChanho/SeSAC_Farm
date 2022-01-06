//
//  LoginViewModel.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import Foundation

class LoginViewModel: UserDefaults {
    var email: Observable<String> = Observable("")
    var nickName: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var passwordCheck: Observable<String> = Observable("")
    
    var currentPassword: Observable<String> = Observable("")
    var changePassword: Observable<String> = Observable("")
    var confirmPassword: Observable<String> = Observable("")
    
    // 아이디 형식 검사
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    func register(completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.register(username: nickName.value, email: email.value, password: password.value) { data, error, errorData in
            
            switch error {
            case .invalidData:
                completion(errorData)
            case .failed:
                completion(nil)
            case .invalidResponse:
                completion(nil)
            default:
                print("register Success!!")
            }
            
            guard let data = data else {
                return
            }
            
            self.removeUserDefaults()
            
            self.saveUserDefaults(token: data.jwt, name: data.user.username, id: data.user.id, email: data.user.email)
            
            completion(nil)
        }
    }
    
    func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (ErrorAPIReturns?) -> Void) {
        APIService.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword) { data, error, errorData in
            
            switch error {
            case .invalidData:
                completion(errorData)
            case .failed:
                completion(nil)
            case .invalidResponse:
                completion(nil)
            default:
                print("changePassword Success!!")
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

//
//  ViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2021/12/30.
//

import UIKit

class WelcomeViewController: UIViewController {
    static let notification = Notification.Name("backToRoot")
    
    let mainView = WelcomeView()
    let viewModel = StartViewModel()
    
    override func loadView() {
        view = mainView
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLogin()
        
        mainView.startButtonHandler = signIn
        mainView.loginButtonHandler = login
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification), name: WelcomeViewController.notification, object: nil)
    }
    
    func firstLogin() {
        viewModel.nickName.value = UserDefaults.standard.string(forKey: Constants.UserInfo.userName) ?? ""
        viewModel.password.value = UserDefaults.standard.string(forKey: Constants.UserInfo.password) ?? ""
        
        viewModel.login { error in
            switch error?.statusCode {
            case 400:
                print("in")
            case 401:
                self.showEdgeToast(message: "세션이 만료되었습니다. 재로그인 해주세요.")
            default:
                // 이동
                print("success")
                self.moveToPostView()
            }
        }
    }
    
    func login() {
        // 로그인 패이지로 이동
        let vc = StartViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func signIn() {
        // 회원가입 패이지로 이동
        let vc = LoginViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onNotification() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.showEdgeToast(message: "세션이 만료되었습니다. 재로그인 해주세요.")
        }
    }

}


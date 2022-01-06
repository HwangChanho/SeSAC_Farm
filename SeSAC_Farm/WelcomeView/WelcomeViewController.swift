//
//  ViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2021/12/30.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let mainView = WelcomeView()
    
    override func loadView() {
        view = mainView
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.startButtonHandler = signIn
        mainView.loginButtonHandler = login
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

}


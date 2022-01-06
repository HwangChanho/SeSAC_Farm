//
//  StartViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import SnapKit
import UIKit

class StartViewController: UIViewController {
    
    let mainView = StartView()
    let viewModel = StartViewModel()
    
    override func loadView() {
        view = mainView
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setDelegate()
        setTarget()
        
        mainView.loginButtonHandler = login
    }
    
    func login() {
        if mainView.emailField.text!.isEmpty || mainView.passwordField.text!.isEmpty {
            showToast(message: "아이디 비밀번호를 입력해 주세요")
        } else {
            viewModel.login { error in
                switch error?.statusCode {
                case 400:
                    self.showToast(message: "잘못된 로그인 정보 입니다.")
                    self.mainView.emailField.text = ""
                    self.mainView.passwordField.text = ""
                    self.mainView.emailField.becomeFirstResponder()
                case 401:
                    self.backToMainView()
                default:
                    // 이동
                    print("success")
                    self.moveToPostView()
                }
            }
        }
    }
    
    func setDelegate() {
        mainView.emailField.delegate = self
        mainView.passwordField.delegate = self
    }
    
    func setTarget() {
        mainView.emailField.addTarget(self, action: #selector(emailFieldChanged), for: .editingChanged)
        mainView.passwordField.addTarget(self, action: #selector(passwordFieldChanged), for: .editingChanged)
    }
    
    func setNavigationController() {
        self.navigationItem.title = "새싹농장 들어가기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension StartViewController {
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func emailFieldChanged(_ textField: UITextField) {
        let email = textField.text!
        viewModel.nickName.value = email

    }
    
    @objc func passwordFieldChanged(_ textField: UITextField) {
        let pass = textField.text!
        viewModel.password.value = pass
    }
}

extension StartViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

//
//  LoginVIewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    let viewModel = LoginViewModel()
    
    var submitFlag: [Bool] = [false, false, false, false]
    let maxLength = 30
    var password = ""
    
    override func loadView() {
        view = mainView
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setTarget()
        setDelegate()
        
        mainView.registerButtonHandler = register
    }
    
    func setDelegate() {
        mainView.emailField.delegate = self
        mainView.nicknameField.delegate = self
        mainView.passwordField.delegate = self
        mainView.passwordCheckField.delegate = self
    }
    
    func register() {
        if !submitFlag.contains(false) {
            viewModel.register { error in
                switch error?.statusCode {
                case 400:
                    self.showToast(message: "이미 등록된 이메일 입니다.")
                case 401:
                    self.backToMainView()
                default:
                    // 이동
                    print("success")
                    self.moveToPostView()
                    self.showToast(message: "가입 완료")
                }
            }
        } else {
            showToast(message: "가입 조건이 충족되지 않았습니다.")
        }
    }
    
    func setTarget() {
        mainView.emailField.addTarget(self, action: #selector(emailFieldChanged), for: .editingChanged)
        mainView.nicknameField.addTarget(self, action: #selector(nicknameFieldChanged), for: .editingChanged)
        mainView.passwordField.addTarget(self, action: #selector(passwordFieldChanged), for: .editingChanged)
        mainView.passwordCheckField.addTarget(self, action: #selector(passwordCheckFieldChanged), for: .editingChanged)
    }
    
    func setNavigationController() {
        self.navigationItem.title = "새싹농장 가입하기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController {
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func emailFieldChanged(_ textField: UITextField) {
        let email = textField.text!.lowercased()
        mainView.emailField.text = email
        viewModel.email.value = email
        if viewModel.isValidEmail(id: email) {
            mainView.emailField.textColor = .black
            submitFlag[0] = true
            checkValidate()
        } else {
            mainView.emailField.textColor = .red
            submitFlag[0] = false
            checkValidate()
        }
    }
    
    @objc func nicknameFieldChanged(_ textField: UITextField) {
        viewModel.nickName.value = textField.text!
        if !textField.text!.isEmpty {
            submitFlag[3] = true
            checkValidate()
        } else {
            submitFlag[3] = false
            checkValidate()
        }
    }
    
    @objc func passwordFieldChanged(_ textField: UITextField) {
        let pass = textField.text!
        password = pass
        viewModel.password.value = pass
        if viewModel.isValidPassword(pwd: pass) {
            mainView.passwordField.textColor = .black
            submitFlag[1] = true
            checkValidate()
        } else {
            mainView.passwordField.textColor = .red
            submitFlag[1] = false
            checkValidate()
        }
    }
    
    @objc func passwordCheckFieldChanged(_ textField: UITextField) {
        let passCheck = textField.text!
        viewModel.passwordCheck.value = passCheck
        if viewModel.isValidPassword(pwd: passCheck) && password == passCheck {
            mainView.passwordCheckField.textColor = .black
            submitFlag[2] = true
            checkValidate()
        } else {
            mainView.passwordCheckField.textColor = .red
            submitFlag[2] = false
            checkValidate()
        }
    }
    
    func checkValidate() {
        if !submitFlag.contains(false) {
            mainView.registerButton.setTitle("시작하기", for: .normal)
            mainView.registerButton.backgroundColor = .green
        } else {
            mainView.registerButton.setTitle("가입하기", for: .normal)
            mainView.registerButton.backgroundColor = .lightGray
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        if text.count > maxLength {
            textField.resignFirstResponder()
        }
        
        // 초과되는 텍스트 제거
        if text.count >= maxLength {
            let index = text.index(text.startIndex, offsetBy: maxLength)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
        }
        
        return true
    }
}


//
//  ChangePasswordViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation
import UIKit

class ChangePasswordViewController: UIViewController {
    
    let mainView = ChangePasswordView()
    let viewModel = LoginViewModel()
    
    var submitFlag: [Bool] = [false, false, false]
    
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
        mainView.emailField.delegate = self // 기존 비밀번호
        mainView.passwordField.delegate = self // 신규 비밀번호
        mainView.passwordCheckField.delegate = self // 신규 비밀번호 확인
    }
    
    func register() {
        let password = mainView.passwordField.text!
        
        if !submitFlag.contains(false) {
            viewModel.changePassword(currentPassword: mainView.emailField.text!, newPassword: mainView.passwordField.text!, confirmNewPassword: mainView.passwordCheckField.text!) { error in
                switch error?.statusCode {
                case 400:
                    self.showToast(message: "비밀번호 변경에 실패하였습니다.")
                case 401:
                    self.backToMainView()
                default:
                    // 이동
                    print("success")
                    UserDefaults.standard.set(password, forKey: Constants.UserInfo.password)
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    self.showToast(message: "변경 완료")
                }
            }
        } else {
            showToast(message: "변경 조건이 충족되지 않았습니다.")
        }
    }
    
    func setTarget() {
        mainView.emailField.addTarget(self, action: #selector(emailFieldChanged), for: .editingChanged)
        mainView.passwordField.addTarget(self, action: #selector(passwordFieldChanged), for: .editingChanged)
        mainView.passwordCheckField.addTarget(self, action: #selector(passwordCheckFieldChanged), for: .editingChanged)
    }
    
    func setNavigationController() {
        self.navigationItem.title = "비밀번호 변경"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ChangePasswordViewController {
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func emailFieldChanged(_ textField: UITextField) {
        let email = textField.text!
        if email.isEmpty { return }
        viewModel.email.value = email
        submitFlag[0] = true
        checkValidate()
    }
    
    @objc func passwordFieldChanged(_ textField: UITextField) {
        let pass = textField.text!
        if pass.isEmpty { return }
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
        if passCheck.isEmpty { return }
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
            mainView.registerButton.setTitle("변경", for: .normal)
            mainView.registerButton.backgroundColor = .green
        } else {
            mainView.registerButton.setTitle("변경불가", for: .normal)
            mainView.registerButton.backgroundColor = .lightGray
        }
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
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
    


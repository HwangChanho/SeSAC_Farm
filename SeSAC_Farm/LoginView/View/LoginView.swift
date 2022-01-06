//
//  LoginView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import UIKit

class LoginView: UIView, ViewRepresenable {
    
    let textFieldPaddingSize: CGFloat = 10
    
    let emailField = UITextField()
    let nicknameField = UITextField()
    let passwordField = UITextField()
    let passwordCheckField = UITextField()
    let registerButton = UIButton()
    
    var registerButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        animation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func animation() {
        UIView.animate(withDuration: 0.5) {
            self.emailField.alpha = 1
        } completion: { bool in
            
            UIView.animate(withDuration: 0.5) {
                self.nicknameField.alpha = 1
            } completion: { bool in
                
                UIView.animate(withDuration: 0.5) {
                    self.passwordField.alpha = 1
                } completion: { bool in
                    
                    UIView.animate(withDuration: 0.5) {
                        self.passwordCheckField.alpha = 1
                    } completion: { bool in
                        
                        UIView.animate(withDuration: 0.5) {
                            self.registerButton.alpha = 1
                        } completion: { bool in
                            
                            self.emailField.becomeFirstResponder()
                        }
                    }
                }
            }
        }
    }
    
    func setupView() {
        setTextFieldView(text: "이메일 주소", emailField)
        setTextFieldView(text: "닉네임", nicknameField)
        setTextFieldView(text: "비밀번호(8자이상의 영문(소,대)문자, 특수문자 1개이상포함)", passwordField)
        passwordField.isSecureTextEntry = true
        setTextFieldView(text: "비밀번호 확인", passwordCheckField)
        passwordCheckField.isSecureTextEntry = true
        
        registerButton.setTitle("가입하기", for: .normal)
        registerButton.backgroundColor = .lightGray
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        registerButton.alpha = 0
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }
    
    func setTextFieldView(text title: String, _ textField: UITextField) {
        textField.placeholder = title
        textField.tintColor = .lightGray
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = .systemFont(ofSize: 12)
        textField.setLeftPaddingPoints(textFieldPaddingSize)
        textField.setRightPaddingPoints(textFieldPaddingSize)
        textField.alpha = 0
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }
    
    func setupConstraints() {
        [emailField, nicknameField, passwordField, passwordCheckField, registerButton].forEach { item in
            addSubview(item)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            // make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        passwordCheckField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
    }
    
    @objc func registerButtonPressed(_ sender: UIButton) {
        registerButtonHandler?()
    }
}

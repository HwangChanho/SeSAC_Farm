//
//  LoginView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import UIKit

class ChangePasswordView: UIView, ViewRepresenable {
    
    let textFieldPaddingSize: CGFloat = 10
    
    let emailField = UITextField()
    let passwordField = UITextField()
    let passwordCheckField = UITextField()
    let registerButton = UIButton()
    
    var registerButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        setTextFieldView(text: "기존비밀번호", emailField)
        emailField.isSecureTextEntry = true
        setTextFieldView(text: "신규비밀번호(8자이상의 영문(소,대)문자, 특수문자 1개이상포함)", passwordField)
        passwordField.isSecureTextEntry = true
        setTextFieldView(text: "신규비밀번호 확인", passwordCheckField)
        passwordCheckField.isSecureTextEntry = true
        
        registerButton.setTitle("변경하기", for: .normal)
        registerButton.backgroundColor = .lightGray
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }
    
    func setupConstraints() {
        [emailField, passwordField, passwordCheckField, registerButton].forEach { item in
            addSubview(item)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            // make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
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

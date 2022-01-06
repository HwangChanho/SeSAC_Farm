//
//  StartView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import UIKit
import SnapKit

class StartView: UIView, ViewRepresenable {
    
    let stackView = UIStackView()
    let emailField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton()
    
    let textFieldPaddingSize: CGFloat = 10
    var loginButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        animation()
        keyBoard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func keyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func animation() {
        UIView.animate(withDuration: 0.5) {
            self.emailField.alpha = 1
        } completion: { finished in
            UIView.animate(withDuration: 0.5) {
                self.passwordField.alpha = 1
            } completion: { Boolfinished in
                self.loginButton.alpha = 1
                self.emailField.becomeFirstResponder()
            }
        }
    }
    
    func setupView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        
        setTextFieldView(text: "아이디를 입력해주세요.", emailField)
        setTextFieldView(text: "비밀번호를 입력해주세요.", passwordField)
        passwordField.isSecureTextEntry = true
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .green
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        loginButton.alpha = 0
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        addSubview(stackView)
        
        [emailField, passwordField, loginButton].forEach {
            stackView.addSubview($0)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
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
        textField.alpha = 0
    }
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        loginButtonHandler?()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 1) {
                self.stackView.snp.makeConstraints { make in
                    make.centerY.equalToSuperview().offset(-keyboardHeight / 2)
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        // 키보드가 사라질 때
        print("hidden")
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
}

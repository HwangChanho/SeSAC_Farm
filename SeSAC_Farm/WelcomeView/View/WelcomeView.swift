//
//  WelcomeView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2021/12/30.
//

import UIKit
import SnapKit

protocol ViewRepresenable {
    func setupView()
    func setupConstraints()
}

class WelcomeView: UIView, ViewRepresenable {
    let bottomFontSize: CGFloat = 12
   
    let logoImage = UIImageView()
    let titleLabel = UILabel()
    let introLabel = UILabel()
    let button = UIButton()
    
    let bottomView = UIStackView()
    let loginLabelView = UIView()
    let bindingView = UIView()
    let loginLabel = UILabel()
    let loginButton = UIButton()
    
    var startButtonHandler: (() -> Void)?
    var loginButtonHandler: (() -> Void)?
    var changePasswordButtonHandler: (() -> Void)?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
        UIView.animate(withDuration: 1) {
            print("On")
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.button.alpha = 1
            } completion: { bool in
                
                UIView.animate(withDuration: 1) {
                    self.loginLabelView.alpha = 1
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        logoImage.image = UIImage(named: "SeSAC_Logo_White")
        logoImage.backgroundColor = UIColor(named: "BackgroundColor")
        
        introLabel.text = "당신 근처의 새싹농장"
        introLabel.font = .boldSystemFont(ofSize: 18)
        introLabel.textColor = .black
        
        titleLabel.text = "IOS 꿈나무들의 희망찬 놀이터!! \n지금 SeSAC에서 함께해보세요!"
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        button.backgroundColor = .green
        button.setTitle("시작하기", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        
        loginLabel.text = "이미 계정이 있나요?"
        loginLabel.font = .systemFont(ofSize: bottomFontSize)
        loginLabel.textColor = .lightGray
        loginLabel.backgroundColor = .clear
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .clear
        loginButton.setTitleColor(.green, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: bottomFontSize)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        loginLabelView.alpha = 0
        
        bottomView.axis = .vertical
        bottomView.spacing = 0
        bottomView.distribution = .fillEqually
        bottomView.backgroundColor = .clear
        
        bindingView.backgroundColor = .clear
    }
    
    func setupConstraints() {
        [logoImage, titleLabel, introLabel, bottomView].forEach {
            addSubview($0)
        }
        
        [button, loginLabelView].forEach {
            bottomView.addSubview($0)
        }
        
        loginLabelView.addSubview(bindingView)
        
        [loginLabel, loginButton].forEach {
            bindingView.addSubview($0)
        }
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.width.height.equalTo(UIScreen.main.bounds.width / 3)
        }
        
        introLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(88)
        }
        
        button.snp.makeConstraints {
            $0.top.left.right.equalTo(bottomView)
            $0.height.equalTo(44)
        }
        
        loginLabelView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(bottomView)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        bindingView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabelView.snp.top).offset(10)
        }
         
        loginLabel.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.right.equalTo(loginButton.snp.left).offset(-5)
        }
        
        loginButton.snp.makeConstraints {
            $0.left.equalTo(loginLabel.snp.right).offset(5)
            $0.top.bottom.right.equalToSuperview()
        }
    }
    
    @objc func startButtonPressed(_ sender: UIButton) {
        startButtonHandler?()
    }
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        loginButtonHandler?()
    }
    
}

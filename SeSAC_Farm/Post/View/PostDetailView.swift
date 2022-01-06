//
//  PostDetailView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/05.
//

import SnapKit
import UIKit

class PostDetailView: UIView, ViewRepresenable {
    
    let profileView = UIView()
    let userImage = UIImageView()
    let usernameLabel = UILabel()
    let textLabel = UILabel()
    let dateLabel = UILabel()
    let lineView = UIView()
    let middleLineView = UIView()
    let replyButton = UIButton()
    let bottomLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        userImage.image = UIImage(systemName: "person.crop.circle")
        userImage.backgroundColor = .clear
        
        usernameLabel.font = .boldSystemFont(ofSize: 12)
        usernameLabel.textColor = .black
        usernameLabel.backgroundColor = .clear
        usernameLabel.numberOfLines = 0
        usernameLabel.sizeToFit()
        
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.textColor = .black
        textLabel.backgroundColor = .clear
        textLabel.numberOfLines = 0
        
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.numberOfLines = 0
        dateLabel.clipsToBounds = true
        dateLabel.layer.cornerRadius = 3
        dateLabel.sizeToFit()
        
        lineView.backgroundColor = UIColor(named: "LabelBackgroundColor")
        middleLineView.backgroundColor = UIColor(named: "LabelBackgroundColor")
        
        replyButton.setImage(UIImage(systemName: "message"), for: .normal)
        replyButton.setTitle(" 댓글 0", for: .normal)
        replyButton.titleLabel?.font = .systemFont(ofSize: 13)
        replyButton.contentVerticalAlignment = .center
        replyButton.contentHorizontalAlignment = .leading
        replyButton.setTitleColor(.gray, for: .normal)
        replyButton.tintColor = .gray
        replyButton.semanticContentAttribute = .forceLeftToRight
        replyButton.backgroundColor = .clear
        
        bottomLineView.backgroundColor = UIColor(named: "LabelBackgroundColor")
    }
    
    func setupConstraints() {
        [profileView, lineView, textLabel, middleLineView, replyButton, bottomLineView].forEach { item in
            addSubview(item)
        }
        
        [userImage, usernameLabel, dateLabel].forEach { item in
            profileView.addSubview(item)
        }
        
        profileView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(35)
        }
        
        userImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(25)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.left.equalTo(userImage.snp.right).offset(5)
            make.top.right.equalToSuperview()
            make.bottom.equalTo(dateLabel.snp.top)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.equalTo(userImage.snp.right).offset(5)
            make.bottom.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        middleLineView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        replyButton.snp.makeConstraints { make in
            make.top.equalTo(middleLineView.snp.bottom).offset(10)
            make.size.equalTo(28)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(bottomLineView.snp.top).offset(-5)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.top.equalTo(replyButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}

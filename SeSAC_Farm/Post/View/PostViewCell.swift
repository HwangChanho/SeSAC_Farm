//
//  PostViewCell.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import UIKit
import SnapKit

class PostViewCell: UITableViewCell {
    
    static let identifier = "PostViewCell"
    
    let idView = UIView()
    let userIdLabel = UILabel()
    let subTextLabel = UILabel()
    let dateLabel = UILabel()
    let line = UIView()
    let replyButton = UIButton()
    let footerView = UIView()
    
    var replyButtonHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        idView.backgroundColor = .clear
        
        userIdLabel.backgroundColor = UIColor(named: "LabelBackgroundColor")
        userIdLabel.textColor = .black
        userIdLabel.font = .systemFont(ofSize: 13)
        userIdLabel.numberOfLines = 0
        userIdLabel.clipsToBounds = true
        userIdLabel.layer.cornerRadius = 3
        
        subTextLabel.font = .boldSystemFont(ofSize: 15)
        subTextLabel.textColor = .black
        subTextLabel.backgroundColor = .clear
        subTextLabel.numberOfLines = 5
        
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .lightGray
        dateLabel.numberOfLines = 0
        
        line.backgroundColor = UIColor(named: "LabelBackgroundColor")
        
        replyButton.setImage(UIImage(systemName: "message"), for: .normal)
        replyButton.setTitle("  댓글쓰기", for: .normal)
        replyButton.titleLabel?.font = .systemFont(ofSize: 15)
        replyButton.contentVerticalAlignment = .center
        replyButton.contentHorizontalAlignment = .leading
        replyButton.setTitleColor(.gray, for: .normal)
        replyButton.tintColor = .gray
        replyButton.semanticContentAttribute = .forceLeftToRight
        replyButton.backgroundColor = .clear
        replyButton.addTarget(self, action: #selector(replyButtonPressed), for: .touchUpInside)
        
        footerView.backgroundColor = UIColor(named: "LabelBackgroundColor")
    }
    
    func setupConstraints() {
        idView.addSubview(userIdLabel)
        
        [idView, subTextLabel, dateLabel, line, replyButton, footerView].forEach { item in
            addSubview(item)
        }
        
        idView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.height.equalTo(30)
        }
        
        userIdLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        
        subTextLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(userIdLabel.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subTextLabel.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        replyButton.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(replyButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc func replyButtonPressed(_ sender: UIButton) {
        replyButtonHandler?()
    }
    
}

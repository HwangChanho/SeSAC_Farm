//
//  CommentCell.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/05.
//

import SnapKit
import UIKit

class CommentCell: UITableViewCell {
    
    static let identifier = "CommentCell"
    
    let userNameLabel = UILabel()
    let commentLabel = UILabel()
    let menuButton = UIButton()
    
    var menuButtonHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        userNameLabel.textColor = .black
        userNameLabel.backgroundColor = .clear
        userNameLabel.font = .boldSystemFont(ofSize: 13)
        userNameLabel.numberOfLines = 1
        
        commentLabel.textColor = .darkGray
        commentLabel.backgroundColor = .clear
        commentLabel.font = .systemFont(ofSize: 14)
        commentLabel.numberOfLines = 0
        
        let image = UIImage(systemName: "ellipsis")
        let newImage = image?.rotate(radians: .pi/2)
        
        menuButton.setImage(newImage, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonSelected), for: .touchUpInside)
    }
    
    func setupConstraints() {
        [menuButton, userNameLabel, commentLabel].forEach { item in
            addSubview(item)
        }
        
        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(20)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(menuButton.snp.left).offset(-20)
            make.height.equalTo(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(menuButton.snp.left).offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func menuButtonSelected(_ sender: UIButton) {
        print("tapped")
        menuButtonHandler?()
    }
}

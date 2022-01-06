//
//  PostCreateView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation
import UIKit
import SnapKit

class PostCreateView: UIView, ViewRepresenable {
    
    let textField = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
    }
    
    func setupConstraints() {
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

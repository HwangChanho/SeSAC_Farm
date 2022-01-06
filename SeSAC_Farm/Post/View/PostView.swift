//
//  BoardView.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import UIKit
import SnapKit

class PostView: UIView, ViewRepresenable {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        tableView.backgroundColor = .white
        
        tableView.register(PostViewCell.self, forCellReuseIdentifier: "PostViewCell")
    }
    
    func setupConstraints() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

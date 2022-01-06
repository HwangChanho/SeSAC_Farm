//
//  BaseViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/01.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraint()
    }
    
    func setDelegate() {
        
    }
    
    func setConstraint() {
        
    }
    
    // View 초기화
    func configure() {
        view.backgroundColor = .white
    }
}

//
//  CommentUpdateViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation
import UIKit
import SnapKit

class CommentUpdateViewController: UIViewController, UITextViewDelegate {
    
    let textView = UITextView()
    let viewModel = CommentsViewModel()
    var commentsID = 0
    var postId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setNavigationController()
        setup()
    }
    
    func setup() {
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.becomeFirstResponder()
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateCommentAndPopView()
        return true
    }
}

extension CommentUpdateViewController {
    func setNavigationController() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func updateCommentAndPopView() {
        viewModel.updateComment(commentsId: commentsID, postId: postId, text: textView.text!) { error in
            switch error?.statusCode {
            case 400:
                self.showToast(message: "수정 실패")
            case 401:
                self.backToMainView()
            default:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonPressed(_ sender: UIButton) {
        // 저장 후 pop
        updateCommentAndPopView()
    }
    
}

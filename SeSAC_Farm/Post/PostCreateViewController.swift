//
//  PostCreateController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/06.
//

import Foundation
import UIKit
import SnapKit

class PostCreateViewController: UIViewController {
    
    let mainView = PostCreateView()
    let viewModel = PostCreateViewModel()
    let maxLength = 500
    var updateFlag: Bool = false
    var postID = 0
    var text: String = ""
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        keyBoard()
        
        mainView.textField.delegate = self
        mainView.textField.becomeFirstResponder()
    }
}

extension PostCreateViewController: UITextViewDelegate {
    func keyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 1) {
                self.mainView.textField.snp.remakeConstraints { make in
                    make.top.left.right.equalToSuperview()
                    make.bottom.equalTo(-(keyboardHeight))
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        // 키보드가 사라질 때
        print("hidden")
        self.mainView.textField.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > maxLength {
            textView.resignFirstResponder()
        }
        
        if  textView.text.count >= maxLength {
            showToast(message: "최대 \(maxLength)자까지 작성가능")
            let index = textView.text.index(textView.text.startIndex, offsetBy: maxLength)
            let newString = textView.text[textView.text.startIndex..<index]
            textView.text = String(newString)
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        mainView.textField.resignFirstResponder()
        self.mainView.textField.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension PostCreateViewController {
    func setNavigationController() {
        self.navigationItem.title = "새싹농장 글쓰기"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func xButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonPressed(_ sender: UIButton) {
        if mainView.textField.text.isEmpty {
            showToast(message: "글을 등록해주세요")
            return
        }
        
        if updateFlag {
            viewModel.updatePost(postId: postID, text: mainView.textField.text!) { error in
                switch error?.statusCode {
                case 400:
                    self.showToast(message: "수정 실패")
                case 401:
                    self.backToMainView()
                default:
                    // 이동
                    print("success")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            viewModel.createPost(text: mainView.textField.text ?? "") { error in
                switch error?.statusCode {
                case 400:
                    self.showToast(message: "등록 실패")
                case 401:
                    self.backToMainView()
                default:
                    // 이동
                    print("success")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

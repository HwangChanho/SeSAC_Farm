//
//  PostDetailViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/05.
//

import UIKit
import SnapKit

class PostDetailViewController: UIViewController {
    
    let topView = PostDetailView()
    let tableView = UITableView()
    let textField = UITextField()
    let contentView = UIView()
    
    let viewModel = PostViewModel()
    let commentsViewModel = CommentsViewModel()
    var postInfo: Post? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        bindObjects()
        getComments()
        
        // post id 로 가져오는 api 필요
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setNavigationController()
        setupViewAndConstraints()
        setDelegate()
        keyBoard()
        
        bindObjects()
        getComments()
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
    }
 
    func bindObjects() {
        topView.usernameLabel.text = postInfo?.user.username
        topView.textLabel.text = postInfo?.text
        topView.dateLabel.text = dateFormatToMonthAndDate(inputData: postInfo?.updatedAt ?? postInfo!.createdAt)
        topView.replyButton.setTitle(" 댓글 \(postInfo?.comments.count ?? 0)", for: .normal)
    }
    
    func getComments() {
        commentsViewModel.getCommentById(postId: postInfo!.id) { error in
            switch error?.statusCode {
            case 400:
                self.showToast(message: "불러오기 실패")
            case 401:
                self.backToMainView()
            default:
                // 이동
                print("get comments success")
                self.tableView.reloadData()
            }
        }
    }
    
    func deletePost() {
        self.viewModel.deletePost(postId: self.postInfo!.id) { error in
            switch error?.statusCode {
            case 400:
                self.showToast(message: "삭제 실패")
            case 401:
                self.backToMainView()
            default:
                // 이동
                print("success")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func deleteComment(commentId: Int) {
        commentsViewModel.deleteComment(commentId: commentId) { error in
            switch error?.statusCode {
            case 400:
                self.showToast(message: "삭제 실패")
            case 401:
                self.backToMainView()
            default:
                // 이동
                print("success")
                self.getComments()
            }
        }
    }
}

extension PostDetailViewController {
    func setNavigationController() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        let image = UIImage(systemName: "ellipsis")
        let newImage = image?.rotate(radians: .pi/2)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: newImage, style: .plain, target: self, action: #selector(menuButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func menuButtonPressed(_ sender: UIButton) {
        showAlert()
    }
    
    func showAlert() {
        if postInfo?.user.id != Int(UserDefaults.userId) {
            showToast(message: "타인의 포스트는 관리 불가")
            return
        }
        
        let alert =  UIAlertController(title: "포스트 관리", message: nil, preferredStyle: .alert)
        
        let put =  UIAlertAction(title: "수정", style: .default) { (action) in
            let vc = PostCreateViewController()
            
            vc.mainView.textField.text = self.topView.textLabel.text!
            vc.updateFlag = true
            vc.postID = self.postInfo!.id
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let delete =  UIAlertAction(title: "삭제", style: .destructive) { (action) in
            self.showDeleteAlert(true, commentId: 0)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(put)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showDeleteAlert(_ option: Bool, commentId: Int) { // true: post, false: comment
        let alert =  UIAlertController(title: "주의: 정말 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let delete =  UIAlertAction(title: "삭제", style: .destructive) { (action) in
            if option {
                self.deletePost()
            } else {
                self.deleteComment(commentId: commentId)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsViewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else {
            return UITableViewCell() }
        
        let data = commentsViewModel.cellForRowAt(at: indexPath)
        
        cell.selectionStyle = .none
        
        cell.userNameLabel.text = data.user.username
        cell.commentLabel.text = data.comment
        cell.menuButtonHandler? = {
            print("tapped")
            self.menuButtonAction(commentId: data.id, userId: data.user.id)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = commentsViewModel.cellForRowAt(at: indexPath)
        
        self.menuButtonAction(commentId: data.id, userId: data.user.id)
    }
    
    func menuButtonAction(commentId: Int, userId: Int) {
        if userId != Int(UserDefaults.userId) {
            showToast(message: "타인의 댓글은 관리 불가")
            return
        }
        
        let alert =  UIAlertController(title: "댓글 관리", message: nil, preferredStyle: .alert)
        
        let put =  UIAlertAction(title: "수정", style: .default) { (action) in
            let vc = CommentUpdateViewController()
            
            vc.commentsID = commentId
            vc.postId = self.postInfo!.id
            vc.textView.text = self.textField.text
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let delete =  UIAlertAction(title: "삭제", style: .destructive) { (action) in
            self.showDeleteAlert(false, commentId: commentId)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(put)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension PostDetailViewController: UITextFieldDelegate {
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
                self.textField.snp.remakeConstraints { make in
                    make.height.equalTo(50)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-keyboardHeight)
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        // 키보드가 사라질 때
        print("hidden")
        remakeTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        textField.resignFirstResponder()
        remakeTextField()
        // 댓글 등록
        commentsViewModel.createComment(postId: postInfo!.id, text: textField.text!) { error in
            switch error?.statusCode {
            case 400:
                self.showToast(message: "등록 실패")
            case 401:
                self.backToMainView()
            default:
                // 이동
                self.showToast(message: "등록 완료")
                self.getComments()
            }
        }
        
        textField.text = ""
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text!)
        remakeTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// view
extension PostDetailViewController {
    func setupViewAndConstraints() {
        textField.placeholder = "댓글을 입력해주세요"
        textField.setLeftPaddingPoints(10)
        textField.font = .systemFont(ofSize: 13)
        textField.backgroundColor = UIColor(named: "LabelBackgroundColor")
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.tintColor = .black
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.separatorStyle = .none
        tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        
        view.addSubview(contentView)
        view.addSubview(textField)
        
        [topView, tableView].forEach { item in
            contentView.addSubview(item)
        }
        
        view.bringSubviewToFront(tableView)

        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.bottom.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.greaterThanOrEqualTo(UIScreen.main.bounds.height / 4)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func remakeTextField() {
        textField.snp.remakeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
}



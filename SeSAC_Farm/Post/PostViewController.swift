//
//  PostViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/04.
//

import UIKit
import SnapKit

class PostViewController: UIViewController, UINavigationControllerDelegate {
    
    private var viewModel = PostViewModel()
    
    var tableView = UITableView()
    let footerView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        getAPIFromServer(dec: true, ace: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setupViewAndConstraints()
        setNavigationController()
        setDelegate()
        
        getAPIFromServer(dec: true, ace: false)
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViewAndConstraints() {
        tableView.register(PostViewCell.self, forCellReuseIdentifier: "PostViewCell")
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .lightGray
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func getAPIFromServer(dec: Bool, ace: Bool) {
        if !dec && !ace { return }
        else {
            if dec && !ace {
                self.viewModel.getPostsInDecendingOrder { error in
                    switch error?.statusCode {
                    case 400:
                        self.showToast(message: "오류 발생")
                    case 401:
                        self.backToMainView()
                    default:
                        self.tableView.reloadData()
                    }
                }
            } else if ace && !dec {
                self.viewModel.getPosts { error in
                    switch error?.statusCode {
                    case 400:
                        self.showToast(message: "오류 발생")
                    case 401:
                        self.backToMainView()
                    default:
                        self.tableView.reloadData()
                    }
                }
            } else { return }
        }
    }
}

extension PostViewController {
    func setNavigationController() {
        let firstBarItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(plusButtonPressed))
        
        let image = UIImage(systemName: "ellipsis")
        let newImage = image?.rotate(radians: .pi/2)
        let secondBarItem = UIBarButtonItem(image: newImage, style: .plain, target: self, action: #selector(menuButtonPressed))
        
        let thiredBarItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(personButtonPressed))
        
        var rightBarButtons: [UIBarButtonItem] = []
        rightBarButtons.append(firstBarItem)
        rightBarButtons.append(secondBarItem)
        rightBarButtons.append(thiredBarItem)
        
        firstBarItem.tintColor = .black
        secondBarItem.tintColor = .black
        thiredBarItem.tintColor = .black
        
        self.navigationItem.rightBarButtonItems = rightBarButtons
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "새싹농장", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 18)], for: .normal)
        
    }
    
    @objc func plusButtonPressed(_ sender: UIButton) {
        // 글쓰기
        navigationController?.pushViewController(PostCreateViewController(), animated: true)
    }
    
    @objc func menuButtonPressed(_ sender: UIButton) {
        // 정렬
        showAlert()
    }
    
    @objc func personButtonPressed(_ sender: UIButton) {
        // 정렬
        let vc = ChangePasswordViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showAlert() {
        let alert =  UIAlertController(title: "정렬", message: nil, preferredStyle: .alert)
        
        let byLatest =  UIAlertAction(title: "최신순", style: .default) { (action) in
            self.getAPIFromServer(dec: true, ace: false)
        }
        let byOlderst =  UIAlertAction(title: "오래된순", style: .default) { (action) in
            self.getAPIFromServer(dec: false, ace: true)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(byLatest)
        alert.addAction(byOlderst)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as? PostViewCell else {
            return UITableViewCell() }
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.selectionStyle = .none
        cell.userIdLabel.text = " \(data.user.username) "
        cell.subTextLabel.text = data.text
        cell.dateLabel.text = dateFormatToMonthAndDate(inputData: data.updatedAt)
        
        let numberOfReply = viewModel.getNumberOfMemos(row: indexPath.row)
        
        if numberOfReply != 0 {
            cell.replyButton.setTitle(" 댓글 \(numberOfReply)", for: .normal)
        } else {
            cell.replyButton.setTitle("  댓글쓰기", for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let vc = PostDetailViewController()
        
        vc.postInfo = viewModel.cellForRowAt(at: indexPath)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

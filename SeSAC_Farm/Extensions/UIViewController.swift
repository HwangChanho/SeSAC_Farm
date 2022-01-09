//
//  UIViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import UIKit
import SnapKit

extension UIViewController {
    func showToast(message : String, font: UIFont = UIFont.boldSystemFont(ofSize: 18)) {
        let width: CGFloat = 280
        let height: CGFloat = 70
        
        let xCenter: CGFloat = (self.view.frame.size.width / 2) - (width / 2)
        let yCenter: CGFloat = (self.view.frame.size.height / 2) - (height / 2)
        
        let toastLabel = UILabel(frame: CGRect(x: xCenter, y: yCenter - 20, width: width, height: 100))
        
        toastLabel.backgroundColor = .lightGray
        toastLabel.alpha = 0.8
        toastLabel.textColor = .black
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 12;
        toastLabel.clipsToBounds = true
        toastLabel.adjustsFontSizeToFitWidth = true
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0 }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
    }
    
    func showEdgeToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 15)) {
        let view = UIView()
        let toastLabel = UILabel()
        
        view.backgroundColor = .green
        view.alpha = 0.8
        
        toastLabel.font = font
        toastLabel.textColor = .white
        toastLabel.backgroundColor = .clear
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        toastLabel.adjustsFontSizeToFitWidth = true
        toastLabel.textAlignment = .center
        
        self.view.addSubview(view)
        view.addSubview(toastLabel)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 22)
        }
        
        toastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveEaseOut, animations: {
            view.alpha = 0.0 }, completion: {(isCompleted) in
                view.removeFromSuperview()
            })
    }
    
    func backToMainView() {
        //        let ud = UserDefaults()
        //        ud.removeUserDefaults()
        navigationController?.popToRootViewController(animated: true)
        
        NotificationCenter.default.post(name: WelcomeViewController.notification, object: nil)
    }
    
    func moveToPostView() {
        let nav = PostViewController()
        
        navigationController?.pushViewController(nav, animated: true)
    }
    
    func dateFormatToMonthAndDate(inputData: String) -> String {
        let arr = inputData.split(separator: "-")
        let arr2 = arr[2].split(separator: "T")
        
        return "\(arr[1])/\(arr2[0])"
    }
}

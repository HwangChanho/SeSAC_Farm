//
//  UIViewController.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/03.
//

import UIKit

extension UIViewController {
    func showToast(message : String, font: UIFont = UIFont.boldSystemFont(ofSize: 18)) {
        let width: CGFloat = 280
        let height: CGFloat = 70
        
        let xCenter: CGFloat = (self.view.frame.size.width / 2) - (width / 2)
        let yCenter: CGFloat = (self.view.frame.size.height / 2) - (height / 2)
        
        let toastLabel = UILabel(frame: CGRect(x: xCenter, y: yCenter - 20, width: width, height: 100))
        
        toastLabel.backgroundColor = .lightGray
        toastLabel.alpha = 0.6
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
    
    func backToMainView() {
        let ud = UserDefaults()
        ud.removeUserDefaults()
        
        self.navigationController?.popToRootViewController(animated: true)
        
        showToast(message: "토큰 정보가 만료되었습니다. 재로그인 바랍니다.")
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

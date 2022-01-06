//
//  Utility.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2022/01/05.
//

import Foundation
import UIKit

enum AffineType {
    case translate
    case scale
    case rotate
}

public class Utility {
    func affineTransfrom(_ type: AffineType, button: UIButton) {
        switch type {
        case .translate:
            button.transform = .init(translationX: 50, y: 1.0)
            button.setTitle("(translationX:50, y:1.0)", for: .normal)
        case .rotate:
            button.transform = .init(rotationAngle: 45.0)
            button.setTitle("(rotationAngle:45.0)", for: .normal)
        case .scale:
            button.transform = .init(scaleX: 2.0, y: 1.0)
            button.setTitle("(scaleX:2.0, y:1.0)", for: .normal)
        }
    }
}

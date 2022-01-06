//
//  Observable.swift
//  SeSAC_Farm
//
//  Created by AlexHwang on 2021/12/30.
//

import Foundation

class Observable<T> {
    private var listener: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

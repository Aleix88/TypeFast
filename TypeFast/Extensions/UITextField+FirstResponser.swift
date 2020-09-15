//
//  UITextField+FirstResponser.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 15/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

extension UITextField {
    func becomeFirstResponserInMainThread() {
        DispatchQueue.main.async {
            self.becomeFirstResponder()
        }
    }
    
    func resignFirstResponserInMainThread() {
        DispatchQueue.main.async {
            self.resignFirstResponder()
        }
    }
}

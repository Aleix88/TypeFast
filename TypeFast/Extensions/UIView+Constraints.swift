//
//  UIView+Constraints.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 10/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(
        top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
        right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
        bot: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
        left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
        margin: (top: CGFloat, right: CGFloat, bot: CGFloat, left: CGFloat),
        height: CGFloat? = nil,
        width: CGFloat? = nil
        ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = top {
            self.topAnchor.constraint(equalTo: topAnchor, constant: margin.top).isActive = true
        }
        if let rightAnchor = right {
            self.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin.right).isActive = true
        }
        if let botAnchor = bot {
            self.bottomAnchor.constraint(equalTo: botAnchor, constant: -margin.bot).isActive = true
        }
        if let leftAnchor = left {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: margin.left).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}

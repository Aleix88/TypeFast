//
//  UIColor+RGB.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 04/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit


extension UIColor {

    static let TFGreen = UIColor.rgb(r: 116, g: 212, b: 132)
    static let TFYellow = UIColor.rgb(r: 254, g: 214, b: 107)
    static let TFBlue = UIColor.rgb(r: 142, g: 144, b: 242)
    static let TFRed = UIColor.rgb(r: 230, g: 92, b: 139)

    static func rgb (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

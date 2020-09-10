//
//  GradientBackgroundView.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 06/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class GradientBackgroundView: UIView {
    
    //MARK: Variables
    var topColor: UIColor?
    var bottomColor: UIColor?
    
    //MARK: Constants
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, topColor: UIColor, bottomColor: UIColor) {
        super.init(frame: frame)
        self.topColor = topColor
        self.bottomColor = bottomColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addGradientBackground()
        
    }

    private func addGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        let firstColor = self.topColor?.cgColor ?? UIColor.black.cgColor
        let secondColor = self.bottomColor?.cgColor ?? UIColor.white.cgColor

        gradient.colors = [firstColor, secondColor]

        self.layer.insertSublayer(gradient, at: 0)
    }
}

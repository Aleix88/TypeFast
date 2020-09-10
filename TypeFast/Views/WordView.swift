//
//  WordView.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 10/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class WordView: UIView {

    //MARK: Variables
    private var label: UILabel! = {
        let l = UILabel()
        l.text = "Word"
        l.backgroundColor = .clear
        l.textAlignment = .center
        return l
    }()
    
    private var word: String?
    
    //MARK: Constants
    
    //MARK: Life Cycle
    
    init(word: String) {
        super.init(frame: .zero)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 8
        self.addLabel()
        self.word = word
        self.label.text = self.word
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addLabel() {
        self.addSubview(self.label)
        self.label.anchor(top: self.topAnchor, right: self.rightAnchor, bot: self.bottomAnchor, left: self.leftAnchor, margin: (5,5,5,5))
    }
    
}

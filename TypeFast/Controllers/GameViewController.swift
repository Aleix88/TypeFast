//
//  GameViewController.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 10/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak private var topStackView: UIStackView!
    @IBOutlet weak private var bottomStackView: UIStackView!
    
    //MARK: Constants
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topStackView.addArrangedSubview(WordView(word: "Aleix"))
        self.topStackView.addArrangedSubview(WordView(word: "Paraulallarga"))
        self.topStackView.addArrangedSubview(WordView(word: "Pep"))

    }
    
    @IBAction func removeButton(_ sender: Any) {
        deleteFirstWord()
    }
    @IBAction func addButton(_ sender: Any) {
        addWord(word: "NewWord")
    }
    
    func addWord(word: String) {
        UIView.animate(withDuration: 1, animations: {
                    self.topStackView.addArrangedSubview(WordView(word: word))
        }, completion: nil)
    }
    
    func deleteFirstWord() {
        UIView.animate(withDuration: 0.3, animations: {
            guard let firstWordView = self.topStackView.arrangedSubviews.first else {return}
            firstWordView.isHidden = true
        }) { (_) in
            guard let firstWordView = self.topStackView.arrangedSubviews.first else {return}
            self.topStackView.removeArrangedSubview(firstWordView)
        }
    }
    
}

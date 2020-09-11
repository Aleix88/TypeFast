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
    @IBOutlet weak private var firstWordView: UIView!
    @IBOutlet weak private var secondWordView: UIView!
    @IBOutlet weak private var firstViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak private var secondViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak private var firstWordLabel: UILabel!
    @IBOutlet weak private var secondWordLabel: UILabel!
    @IBOutlet weak private var inputTextField: UITextField!
    
    private var focusedWordView: UIView?
    private var unfocusedWordView: UIView?
    private var focusedWordLabel: UILabel?
    private var unfocusedWordLabel: UILabel?
    private var focusedWordConstraint: NSLayoutConstraint?
    private var unfocusedWordConstraint: NSLayoutConstraint?
    
    private var gameManager: GameManager?
    
    //MARK: Constants
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondViewCenterConstraint.constant = self.view.frame.width
        self.view.layoutIfNeeded()
        self.setupFocusedView()
        self.gameManager = GameManager()
        self.hideTextField()
        self.inputTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gameManager?.startNewGame()
        self.firstWordLabel.text = self.gameManager?.nextWord()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showCountdownScreen()
        self.inputTextField.becomeFirstResponder()
    }
    
    @IBAction func addButton(_ sender: Any) {
        nextWordAnimation()
    }
    
    private func showCountdownScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countdownVC = storyboard.instantiateViewController(withIdentifier: "countdownViewController")
        countdownVC.modalTransitionStyle = .crossDissolve
        countdownVC.modalPresentationStyle = .overFullScreen
        self.present(countdownVC, animated: true)
    }
    
    private func nextChar(char: String) {
        guard let gameManager = self.gameManager else {return}
        if (gameManager.checkCharInput(char: char)) {
            self.updateCharacterColor()
            if (gameManager.nextWordIfCompleted()) {
                if (gameManager.areWordsFinished()) {
                    print("Win")
                } else {
                    self.showNextWord(word: gameManager.nextWord() ?? "")
                }
            }
        } else {
            //Animation?
        }
    }
    
    private func updateCharacterColor() {
        guard let word = self.gameManager?.currentWord else {return}
        guard let charIndex = self.gameManager?.characterIndex else {return}
        let okString = String(word.prefix(charIndex))
        let koString = String(word.suffix(word.count - charIndex))
        
        let attrText = NSMutableAttributedString(string: okString, attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue])
        attrText.append(NSAttributedString(string: koString))
            
        self.focusedWordLabel?.attributedText = attrText
    }
    
    private func showNextWord(word: String) {
        self.unfocusedWordLabel?.text = word
        nextWordAnimation()
    }
    
    private func hideTextField() {
        self.inputTextField.backgroundColor = .clear
        self.inputTextField.borderStyle = .none
        self.inputTextField.textColor = .clear
        self.inputTextField.tintColor = .clear
        self.inputTextField.autocorrectionType = .no
    }
    
    private func setupFocusedView() {
        self.focusedWordConstraint = self.firstViewCenterConstraint
        self.unfocusedWordConstraint = self.secondViewCenterConstraint
        self.focusedWordLabel = self.firstWordLabel
        self.unfocusedWordLabel = self.secondWordLabel
        self.focusedWordView = self.firstWordView
        self.unfocusedWordView = self.secondWordView
    }
    
    private func nextWordAnimation() {
        self.focusedWordConstraint?.constant = -self.view.frame.width
        self.focusedWordView?.backgroundColor = .green
        self.unfocusedWordConstraint?.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.swapFocusedView()
            self.unfocusedWordLabel?.textColor = .black
            self.unfocusedWordConstraint?.constant = self.view.frame.width
            self.unfocusedWordView?.backgroundColor = .lightGray
        }
    }
    
    private func swapFocusedView() {
        let tmpConstraint = self.focusedWordConstraint
        self.focusedWordConstraint = self.unfocusedWordConstraint
        self.unfocusedWordConstraint = tmpConstraint
        
        let tmpLabel = self.focusedWordLabel
        self.focusedWordLabel = self.unfocusedWordLabel
        self.unfocusedWordLabel = tmpLabel
        
        let tmpView = self.focusedWordView
        self.focusedWordView = self.unfocusedWordView
        self.unfocusedWordView = tmpView
    }
  
}


//MARK: Texfield Delegate

extension GameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.count > 0) {
            self.nextChar(char: String(string.last!).lowercased())
        }
        return true
    }
    
}

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
    @IBOutlet weak private var myProcessSlider: UISlider!
    @IBOutlet weak private var opponentProcessSlider: UISlider!
    @IBOutlet weak private var inputTextField: UITextField!
    
    private var focusedWordView: UIView?
    private var unfocusedWordView: UIView?
    private var focusedWordLabel: UILabel?
    private var unfocusedWordLabel: UILabel?
    private var focusedWordConstraint: NSLayoutConstraint?
    private var unfocusedWordConstraint: NSLayoutConstraint?
    
    private var gameManager: GameManager?
    
    //MARK: Constants
    private let defaultTextColor = UIColor.white
    private let correctTextColor = UIColor.black
    private let correctBackgroundColor = UIColor.TFGreen
    private let defaultBackogrundColor = UIColor.TFBlue
    
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
        self.setupSlider(slider: self.myProcessSlider, tintColor: .TFYellow)
        self.setupSlider(slider: self.opponentProcessSlider, tintColor: .TFRed)
        self.askForWords()
    }
    
    private func askForWords() {
        NetworkManager.shared.requestRandomWords(numberOfWords: 5) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let words):
                DispatchQueue.main.async {
                    self.gameManager?.startNewGame(words: words)
                    self.showCountdownScreen()
                    self.inputTextField.becomeFirstResponserInMainThread()
                    self.firstWordLabel.text = self.gameManager?.nextWord()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func setupSlider(slider: UISlider, tintColor: UIColor) {
        slider.tintColor = tintColor
        slider.thumbTintColor = tintColor
        slider.minimumValue = 0
        slider.maximumValue = Float(self.gameManager?.numberOfWords() ?? 1)
        slider.value = 0
    }
    
    private func showCountdownScreen() {
        _ = self.presentWith(id: "countdownViewController", presentationStyle: .overFullScreen, transitionStyle: .crossDissolve, completion: {_ in})
    }
    
    private func nextChar(char: String) {
        guard let gameManager = self.gameManager else {return}
        if (gameManager.checkCharInput(char: char)) {
            self.updateCharacterColor()
            if (gameManager.nextWordIfCompleted()) {
                self.myProcessSlider.value += 1
                if (gameManager.areWordsFinished()) {
                    self.focusedWordView?.backgroundColor = self.correctBackgroundColor
                    self.presentFinishScreen(didYouWin: true)
                } else {
                    self.showNextWord(word: gameManager.nextWord() ?? "")
                }
            }
        } else {
            //Animation?
        }
    }
    
    private func presentFinishScreen(didYouWin: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let finishVC = storyboard.instantiateViewController(identifier: "FinishViewController")
        finishVC.modalPresentationStyle = .overFullScreen
        self.present(finishVC, animated: true)
    }
    
    private func updateCharacterColor() {
        guard let word = self.gameManager?.currentWord else {return}
        guard let charIndex = self.gameManager?.characterIndex else {return}
        let okString = String(word.prefix(charIndex))
        let koString = String(word.suffix(word.count - charIndex))
        
        let attrText = NSMutableAttributedString(string: okString, attributes: [NSAttributedString.Key.foregroundColor : self.correctTextColor])
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
        
        self.focusedWordView?.backgroundColor = self.defaultBackogrundColor
        self.unfocusedWordView?.backgroundColor = self.defaultBackogrundColor
        self.focusedWordLabel?.textColor = self.defaultTextColor
        self.unfocusedWordLabel?.textColor = self.defaultTextColor
    }
    
    private func nextWordAnimation() {
        self.focusedWordConstraint?.constant = -self.view.frame.width
        self.focusedWordView?.backgroundColor = self.correctBackgroundColor
        self.unfocusedWordConstraint?.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.swapFocusedView()
            self.unfocusedWordLabel?.textColor = self.defaultTextColor
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

//
//  PopUpViewController.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 13/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak private var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var decorationView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var inputTextfield: UITextField!
    @IBOutlet weak private var createButton: UIButton!
    
    var popUpTitle: String? {
        didSet {
            guard let _ = self.titleLabel else {return}
            self.titleLabel.text = popUpTitle
        }
    }
    
    var popUpDescription: String? {
        didSet {
            guard let _ = self.descriptionLabel else {return}
            self.descriptionLabel.text = popUpDescription
        }
    }
    
    var textfieldPlaceholder: String? {
        didSet {
            guard let _ = self.inputTextfield else {return}
            self.inputTextfield.placeholder = textfieldPlaceholder
        }
    }
    
    var buttonTitle: String? {
        didSet {
            guard let _ = self.createButton else {return}
            self.createButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    var popUpID: String?
    
    var delegate: PopUpDelegate?
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))

    //MARK: Constants
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(tapGesture)
        self.view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupText()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.inputTextfield.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.decorationView.layer.cornerRadius = self.decorationView.frame.height/2
    }
    
    @objc func backgroundTapped() {
        self.dismiss(animated: true)
    }
    
    private func setupText() {
        self.titleLabel.text = popUpTitle
        self.descriptionLabel.text = popUpDescription
        self.inputTextfield.placeholder = textfieldPlaceholder
        self.createButton.setTitle(buttonTitle, for: .normal)
    }
    
    //MARK: Keyboard
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        let keyboardHeight = keyboardSize.height
        
        self.bottomConstraint.constant = keyboardHeight - 10

        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.bottomConstraint.constant = -10

        UIView.animate(withDuration: 0.01) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Actions
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.delegate?.buttonPressed(popUpID: self.popUpID, textfieldValue: self.inputTextfield.text)
    }
}

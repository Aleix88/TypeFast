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
    
    var popUpTitle: String? {
        didSet {
            self.titleLabel.text = popUpTitle
        }
    }
    
    var popUpDescription: String? {
        didSet {
            self.descriptionLabel.text = popUpDescription
        }
    }
    
    var textfieldPlaceholder: String? {
        didSet {
            self.inputTextfield.placeholder = textfieldPlaceholder
        }
    }
    
    //MARK: Constants
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.view.backgroundColor = UIColor.rgb(r: 30, g: 30, b: 30, a: 0.5)
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.decorationView.layer.cornerRadius = self.decorationView.frame.height/2
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
        self.bottomConstraint.constant = - 10

        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
}

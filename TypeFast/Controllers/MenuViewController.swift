//
//  MenuViewController.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 04/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    //MARK: Variables
    @IBOutlet weak private var joinButton: UIButton!
    @IBOutlet weak private var joinButtonContainer: UIView!
    @IBOutlet weak private var createButton: UIButton!
    @IBOutlet weak private var createButtonContainer: UIView!
    @IBOutlet weak private var firstTitleContainerView: UIView!
    @IBOutlet weak private var secondTitleContainerView: UIView!
    
    private var titleFirstTimer: Timer?
    private var titleSecondTimer: Timer?
    
    private var popUpViewController: PopUpViewController?
    
    //MARK: Constants
    private let createPopUpID = "createPopUpID"
    private let joinPopUpID = "joinPopUpID"
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        SocketManager.shared.connectToServer()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleFirstTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true, block: { (_) in
            self.changeTitleColor(self.firstTitleContainerView)
        })
        self.titleSecondTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.changeTitleColor(self.secondTitleContainerView)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.titleFirstTimer?.invalidate()
        self.titleSecondTimer?.invalidate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configureButtonView(button: self.joinButton, container: self.joinButtonContainer)
        self.configureButtonView(button: self.createButton, container: self.createButtonContainer)
    }
    
    private func configureButtonView(button: UIButton, container: UIView) {
        button.layer.cornerRadius = button.frame.height/2
        container.layer.cornerRadius = container.frame.height/2
    }
    
    private func changeTitleColor(_ titleView: UIView) {
        let colors = [UIColor.TFRed, UIColor.TFBlue, UIColor.TFYellow]
        let randomIndex = Int.random(in: 0...2)
        titleView.backgroundColor = colors[randomIndex]
    }
    
    private func addBackground() {
        let backgroundView = GradientBackgroundView(frame: self.view.frame, topColor: UIColor.rgb(r: 206, g: 126, b: 215), bottomColor: UIColor.rgb(r: 107, g: 69, b: 186))
        self.view.addSubview(backgroundView)
        self.view.sendSubviewToBack(backgroundView)
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        presentPopUp(title: "Room name", description: "You will need to share this name with your friend", placeholder: "Room name", buttonTitle: "Create room", id: self.createPopUpID)
    }
    
    @IBAction func joinButtonPressed(_ sender: Any) {
        presentPopUp(title: "Room name", description: "Ask your friend they room name to join.", placeholder: "Room name", buttonTitle: "Join room", id: self.joinPopUpID)
    }
    
    private func presentPopUp(title: String?, description: String?, placeholder: String?, buttonTitle: String?, id: String?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let popUpVC = storyboard.instantiateViewController(identifier: "PopUpViewController") as? PopUpViewController else {return}
        self.popUpViewController = popUpVC
        popUpVC.popUpTitle = title
        popUpVC.popUpDescription = description
        popUpVC.textfieldPlaceholder = placeholder
        popUpVC.buttonTitle = buttonTitle
        popUpVC.popUpID = id
        popUpVC.delegate = self
        self.present(popUpVC, animated: true)
    }
}

//MARK: PopUpDelegate

extension MenuViewController: PopUpDelegate {
    func buttonPressed(popUpID: String?, textfieldValue: String?) {
        guard let popUpViewController = self.popUpViewController else {return}
        guard let popUpID = popUpID, let value = textfieldValue else {return}
        if (popUpID == self.joinPopUpID) {
            popUpViewController.dismiss(animated: true) {
                _ = self.presentWith(id: "GameViewController", completion: {_ in})
            }
        } else if (popUpID == self.createPopUpID) {
            popUpViewController.dismiss(animated: true) {
                _ = self.presentWith(id: "GameViewController", completion: {_ in})
            }
        }
    }
}

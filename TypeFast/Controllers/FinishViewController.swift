//
//  FinishViewController.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 11/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goToMenu(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(identifier: "MenuViewController")
        menuVC.modalPresentationStyle = .overFullScreen
        self.present(menuVC, animated: true)
    }
    
}

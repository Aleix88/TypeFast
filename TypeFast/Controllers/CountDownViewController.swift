//
//  CountDownViewController.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 11/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {

    //MARK: Variables
    @IBOutlet weak private var countdownLabel: UILabel!
    @IBOutlet weak private var waitLabel: UILabel!
    
    private var timer: Timer?
    private var canDismiss = false
    
    @IBInspectable
    var counter: Int = 0 {
        didSet {
            guard let _ = self.countdownLabel else {return}
            self.countdownLabel.text = String(counter)
        }
    }

    //MARK: Constants

    //MARK: Life Cycle

    init(counter: Int) {
        super.init(nibName: nil, bundle: nil)
        self.counter = counter
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.counter = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countdownLabel.text = String(counter)
        self.waitLabel.isHidden = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.counter -= 1
            print("Top: \(self.counter)")

            self.countdownLabel.text = String(self.counter)
            if (self.isTimeOut()) {
                print(self.canDismiss)
                if (self.canDismiss) {
                    self.dismiss(animated: true)
                } else {
                    self.waitLabel.isHidden = false
                    self.counter = 1
                    print("Bot: \(self.counter)")

                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()

    }
    
    private func isTimeOut() -> Bool {
        return counter <= 0
    }
    
    func dismissIfFinished() {
        if (isTimeOut()) {
            self.dismiss(animated: true)
        }
        self.canDismiss = true
        print("Can dismiss changed: \(self.canDismiss)")
    }

}

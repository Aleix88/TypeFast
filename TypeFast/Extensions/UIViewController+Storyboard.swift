//
//  UIViewController+Storyboard.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 13/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentWith(id: String, presentationStyle: UIModalPresentationStyle = .overFullScreen, transitionStyle: UIModalTransitionStyle? = nil, completion: (@escaping (UIViewController)->())) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: id)
            vc.modalPresentationStyle = presentationStyle
            if let transitionStyle = transitionStyle {
                vc.modalTransitionStyle = transitionStyle
            }
            self.present(vc, animated: true, completion: {
                completion(vc)
            })
        }
    }
    
}

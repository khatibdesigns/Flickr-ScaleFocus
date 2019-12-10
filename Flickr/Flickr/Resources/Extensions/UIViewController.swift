//
//  UIViewController.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func alertwithaction(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
            
            alertController.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil))
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  ScoutiumInternCase
//
//  Created by Huseyn Valiyev on 13.12.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !NetworkMonitor.shared.isConneted {
            showAlert()
        }
    }
    
    private func showAlert() {
        DispatchQueue.main.async {
            let dialogMessage = UIAlertController(title: "Internet Problem", message: "You must be connected internet", preferredStyle: .alert)
             
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
            })
             
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}


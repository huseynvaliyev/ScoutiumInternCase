//
//  ViewController.swift
//  ScoutiumInternCase
//
//  Created by Huseyn Valiyev on 13.12.2020.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {
    
    @IBOutlet weak var remoteText: UILabel!
    private let remoteConfig = RemoteConfig.remoteConfig()

    override func viewDidLoad() {
        super.viewDidLoad()
        if !NetworkMonitor.shared.isConneted {
            showAlert()
        }else{
            fetchValues()
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
    
    private func fetchValues() {
        let defaults: [String: NSObject] = [
            "text": "Text" as NSObject
        ]
        
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: {status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate() { (changed, error) in
                    guard error == nil else {
                        return
                    }
                    let value = self.remoteConfig.configValue(forKey: "text").stringValue!
                    print("Fetched value:\(value)")
                    DispatchQueue.main.async{
                        self.remoteText.text = value
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tableViewController = storyboard.instantiateViewController(withIdentifier: "table") as! TableViewController
                        tableViewController.modalPresentationStyle = .fullScreen
                        self.present(tableViewController, animated: true, completion: nil)
                    })
                }
            }else{
                print("Fetching Error")
            }
        })
    }
}


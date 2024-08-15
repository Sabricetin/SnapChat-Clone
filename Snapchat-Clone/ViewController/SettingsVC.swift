//
//  SettingsVC.swift
//  Snapchat-Clone
//
//  Created by Sabri Çetin on 10.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        //Çıkış İşlemleri
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignVC", sender: nil)
        } catch {
            
        }
        
    }
    
}

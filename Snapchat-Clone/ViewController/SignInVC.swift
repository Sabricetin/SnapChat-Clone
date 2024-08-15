//
//  ViewController.swift
//  Snapchat-Clone
//
//  Created by Sabri Çetin on 10.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        //Giriş İşlemleri
        if  passwordText.text != "" && emailText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (result , error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
            
        } else {
            self.makeAlert(title: "Error", message: "Username/Password/Email ? ")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        //Kayıt İşlemleri
        
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) {  (auth , error ) in
                
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    
                    let fireStore = Firestore.firestore()
                    
                    let userDicitionary = ["email" : self.emailText.text! , "username" : self.usernameText.text!] as! [String : Any]
                    
                    fireStore.collection("UserInfo").addDocument(data: userDicitionary) { (error) in
                        if error != nil {
                            //
                        }
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
        } else {
            self.makeAlert(title: "Error", message: "Username/Password/Email ?")
        }
        
        
    }
    
    //Uyarı Fonksiyonu
    
    func makeAlert (title: String , message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
    }
}


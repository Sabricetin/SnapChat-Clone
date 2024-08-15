//
//  FeedVC.swift
//  Snapchat-Clone
//
//  Created by Sabri Çetin on 10.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
        
    let fireStoreDatabase = Firestore.firestore()
    var snapArray = [Snap] ()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        tableView.delegate = self
        tableView.dataSource = self
        
      
        
        getUserInfo()
        
        getSnapsFormFirebase()
    }

    func getSnapsFormFirebase () {
        
        print("test1")
        
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener {  (snapshot , error) in
            print("test2")

            if error != nil {
                print("test3")

                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                
            } else {
                print("test4")

                if snapshot?.isEmpty == false && snapshot != nil {
                    print("test5")

                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        print("test6")

                        
                        let  documentId = document.documentID
                        

                        print("test6/1 \(documentId)")

                        
                        if let username = document.get("snapOwner") as? String {
                            print("test7")

                            if let imageUrlArray =  document.get("imageurlArray") as? [String] {
                                print("test8")

                                if let date = document.get("date") as? Timestamp {
                                    print("test9")

                                    
                                    if let  difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()) .hour {
                                        print("test10 \(difference)")

                                        if difference <= 24 {
                                            print("test11")

                                            
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete { (error) in
                                                print("test11/1")

                                            }
                                            
                                        }
                                        
                                       //Timeleft-> /  SNAPVC
                                    }
                                    
                                    print("test12")

                                    let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                    print("test12/1")

                                    
                                }

                            }

                        }
                    }
                    self.tableView.reloadData()
                    print("test13")

                }
            }
        }
    }
    
    //Veritabanı Oluşturma Ve Veriyi Yazdırma
    func getUserInfo () {
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                            print("DOCUMENT:\(document)")
                        }
                    }
                }
            }
        }
    }
    
    //Uyarı Fonksiyonu
    
    func makeAlert (title: String , message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUsernameLabel.text = snapArray[indexPath.row].username
        cell.feedİmageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}


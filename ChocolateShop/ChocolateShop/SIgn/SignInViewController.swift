//
//  SignInViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 26/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import FirebaseAuth


class SignInViewController: UIViewController, UITextFieldDelegate {
    
     var handle: FIRAuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var emailtext: UITextField!
    
    
    @IBOutlet weak var passwordtext: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailtext.delegate = self
        passwordtext.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
          //  print(auth)
            if let user = user {
                if let email = user.email {
                     print("user email is \(email)")
                }
               // if let displayname = user.displayName {
                 //   print("displayname is \(displayname)")
                //}
                //if let photourl = user.photoURL {
                 //print("photo url is \(photourl)")
                //}
                print("uid is \(user.uid)")
                let firstVc = self.storyboard?.instantiateViewController(withIdentifier:"firstNa") as! UINavigationController
                
                self.present(firstVc, animated: true, completion: nil)
                
            }
            
        })
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
        print("removed state listener")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SIgnInAct(_ sender: UIButton)
    {
        if let email = emailtext.text , let pass = passwordtext.text {
            self.activity.alpha  = 1
            self.activity.startAnimating()
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                
                if let error = error {
                    self.activity.stopAnimating()
                    self.activity.alpha  = 0
                     let alert = UIAlertController(title:"\(error.localizedDescription)" , message: "Try Again" , preferredStyle: .alert)
                    
                    
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
             self.present(alert, animated: true, completion: nil)
                    print("sign in error is \(error.localizedDescription)")
                }
                else {
                   
                    
                    if let user = user {
                        let firstVc = self.storyboard?.instantiateViewController(withIdentifier:"firstNa") as! UINavigationController
                        self.activity.stopAnimating()
                        self.activity.alpha  = 0
                        self.present(firstVc, animated: true, completion: {
                          
                        })
                        //  self.navigationController?.pushViewController(firstVc, animated: true)
                        
                        
                        
                        
                    print("user is \(user)")
                        print("user uid number is \(user.uid)")
                    }
                    
                }
            })
    }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailtext || textField == passwordtext {
            textField.resignFirstResponder()
        }
         return true
    }
    

}

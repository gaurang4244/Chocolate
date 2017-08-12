//
//  SignUpViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 26/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailtext: UITextField!
    
    
    @IBOutlet weak var phonetext: UITextField!
    
    
    @IBOutlet weak var passwordtext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "Sign Up"
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func signUpAct(_ sender: UIButton)
    {
        if let email = emailtext.text , let pass = passwordtext.text , let phone = phonetext.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                
                if let error = error {
                    let alert = UIAlertController(title:"\(error.localizedDescription)" , message: "Try Again" , preferredStyle: .alert)
                    
                    
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    print("sign in error is \(error.localizedDescription)")
                }
                else
                {
                    
                    if let user1 = user {
                    
                        let firstVc = self.storyboard?.instantiateViewController(withIdentifier:"firstNa") as! UINavigationController
                        self.present(firstVc, animated: true, completion: nil)
                        print("user is \(user1)")
                        print("user uid number is \(user1.uid)")
                    }
                }
            })
            
    }
    
  
}
}

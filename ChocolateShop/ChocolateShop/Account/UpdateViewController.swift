//
//  UpdateViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 30/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import FirebaseAuth

class UpdateViewController: UIViewController {

    
    
    
    
    @IBOutlet weak var passwordtext: UITextField!
    
    var user : FIRUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = FIRAuth.auth()?.currentUser
    }

    @IBAction func SetPasswordAct(_ sender: UIButton)
    {
   if let pass = passwordtext.text
   {
    if let usr = user {
        usr.updatePassword(pass, completion: { (error) in
            if let error = error {
                print("password not changed \(error.localizedDescription)")
                alertaction(title: "\(error.localizedDescription)", message: "Try Again")
            }
            else
            {
                alertaction(title: "password update successfully", message: "")
                
            }
        })
     }
      }
    
        func alertaction(title: String , message: String)
        {
            let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    

}

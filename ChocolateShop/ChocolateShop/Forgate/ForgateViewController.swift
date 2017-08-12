//
//  ForgateViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 27/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import FirebaseAuth


class ForgateViewController: UIViewController {

    @IBOutlet weak var emailtest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func sendCodeAct(_ sender: UIButton)
    {
        if let email = emailtest.text {
            FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
                if let error1 = error {
                    print(error1.localizedDescription)
                    let alert = UIAlertController(title:"\(error1.localizedDescription)" , message: "Enter Your Email Again" , preferredStyle: .alert)
                    
                    
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                let alert = UIAlertController(title: "We have sent a varification link to your email address", message: "Varify your email ", preferredStyle: .alert )
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            emailtest.text = ""
    }
    }
    
}

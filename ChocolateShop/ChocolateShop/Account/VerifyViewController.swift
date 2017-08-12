//
//  VerifyViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 30/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import FirebaseAuth


class VerifyViewController: UIViewController {

     var user : FIRUser!
    @IBOutlet weak var emailtext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
user = FIRAuth.auth()?.currentUser
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = FIRAuth.auth()?.currentUser
    }

    
    @IBAction func verifyAction(_ sender: UIButton)
    {
    }
    
}

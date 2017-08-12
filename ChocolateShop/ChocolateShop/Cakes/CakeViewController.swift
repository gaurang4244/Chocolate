//
//  CakeViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 31/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import Firebase

class CakeViewController: UIViewController {

    var current : FiruserMain!
    var user : FIRUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.current = FiruserMain()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.current.handlingUser()
        DispatchQueue.main.async {
            self.user =  self.current.givinguser()
            print("getting user is \(self.user)")
            print("geting name \(String(describing: self.user?.displayName))")
        }
    }
   

}
  //  DispatchQueue.global(qos: .background).async {
 //   }
  // print(self.current.databasereference())

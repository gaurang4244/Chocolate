//
//  Firuser.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 31/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//
// firbase connection

import UIKit
import Firebase

class FiruserMain {

     var handle: FIRAuthStateDidChangeListenerHandle!
      var storageRef : FIRStorageReference?
    var databaseRef : FIRDatabaseReference?
    var user1 : FIRUser!
  
    func handlingUser() {
        handle = FIRAuth.auth()?.addStateDidChangeListener({ (auth, MUser)  in
                if let current = auth.currentUser
                {
                    self.user1 = current
                }
            })
    }
    
    func givinguser() -> FIRUser! {
        print(user1)
        return user1
    }
    
    
    
    func databasereference() -> FIRDatabaseReference?
    {
        databaseRef = FIRDatabase.database().reference()
        return databaseRef
        
    }
    
    func storagereference() -> FIRStorageReference?
    {
        storageRef = FIRStorage.storage().reference().child("User Image")
        return storageRef
    }
}

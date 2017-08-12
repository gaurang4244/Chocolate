//
//  CurrentUser.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 30/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import Foundation
import UIKit


class CurrentUser {
    
  let user1  = UserDefaults.standard

    func savedata(url2 :String)
    {
        user1.set(url2, forKey: "url")
        print("url saved successfully")
    }
    
    func retrivedata() -> String?
    {
        let url3 =  user1.object(forKey: "url") as? String
      print(url3)
        return url3
        
    }
    
}

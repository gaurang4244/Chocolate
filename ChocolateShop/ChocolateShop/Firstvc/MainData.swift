//
//  MainData.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 01/08/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import Foundation
import UIKit

class MainData
{
    var imageurlstring: String? = ""
    var itemName : String? = ""
    var itemPrice : Double = 0.0
    var itemDescr : String? = ""
    var first: String? = ""
    var second: String? = ""
    var third : String? = ""
    init(url : String , name : String , price :Double , desc : String , fir : String , sec : String , thi : String)
    {
        self.imageurlstring = url
        self.itemName = name
        self.itemPrice = price
        self.itemDescr = desc
        self.first = fir
        self.second = sec
        self.third = thi
        
    }

}

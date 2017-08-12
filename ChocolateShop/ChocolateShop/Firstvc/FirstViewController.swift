//
//  FirstViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 26/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class FirstViewController: UIViewController , UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var seacon = true
    
    var MainDa1 = [MainData]()
     var mainData = ["iphone3", "iphone4" , "iphone5" , "iphone6" , "iphone7" , "iphone7s" ,"iphone3", "iphone4" , "iphone5" ]
    
    var current : FiruserMain!
     var user : FIRUser!
    var dataRef : FIRDatabaseReference!
    
    
    
    let cu = CurrentUser()
     var handle: FIRAuthStateDidChangeListenerHandle?
    var storageRef : FIRStorageReference?
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var leadingview: NSLayoutConstraint!
    
    @IBOutlet weak var widthview: NSLayoutConstraint!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var searchTopcon: NSLayoutConstraint!
    
    var condition = true
    var lead : CGFloat = 0
    var width1 : CGFloat = 0
    var mainWidth : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        collectionview.delegate = self
        collectionview.dataSource = self 
        searchbar.alpha = 0
        searchbar.delegate = self
      mainWidth = self.view.frame.size.width
       
       storageRef = FIRStorage.storage().reference().child("User Image")
        
      
        navigationAtribute()

      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationAtribute()
        firedowndata()
        print("view will appear")
       
         print(" retrive url is \(cu.retrivedata())")
        if   let mainUrl = URL(string: cu.retrivedata()!) {
        userimage.kf.setImage(with: mainUrl)
        }
        
        storageRef = FIRStorage.storage().reference().child("User Image")
        downloadingdata()
        
        let wd = mainWidth / 2
        width1 = wd + CGFloat(20)
       
        widthview.constant = width1
        leadingview.constant = -width1
        
        if !condition {
            UIView.animate(withDuration: 0.1, animations: {
                self.view1.transform = CGAffineTransform(translationX: -self.width1, y: 0)
            }, completion: nil)
            condition  = true
            
        }
       
        
}
   
    @IBAction func searchAction(_ sender: UIBarButtonItem)
    {
    print("search")
        if seacon
        {
          self.navigationController?.setNavigationBarHidden(true, animated: true)
            searchbar.alpha = 1
            UIView.animate(withDuration: 0.8, animations: {
                self.searchTopcon.constant = 0
            })
            seacon = false
            
        }
   
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        if !seacon
        {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
           
            UIView.animate(withDuration: 0.8, animations: {
                self.searchTopcon.constant = -10
            })
             searchbar.alpha = 0
            seacon = true
        }
        
    }
    
    @IBAction func slidAct(_ sender: UIBarButtonItem)
    {
        if condition {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view1.transform = CGAffineTransform(translationX: self.width1, y: 0)
            }, completion: nil)
            
            
            condition = false
        }
        else
        {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view1.transform = CGAffineTransform(translationX: -self.width1, y: 0)
            }, completion: nil)
            condition  = true
        }
        
    
    }
    
    @IBAction func swipeLeftAct(_ sender: UISwipeGestureRecognizer)
    {
        if !condition {
            UIView.animate(withDuration: 0.5, animations: {
                self.view1.transform = CGAffineTransform(translationX: -self.width1, y: 0)
            }, completion: nil)
            condition  = true
            
        }
    
    }
    
    @IBAction func BtnsActs(_ sender: UIButton)
    {
    let rtag = sender.tag
        switch rtag {
        case 1:
            print("favourite")
             case 2:
            print("cakes")
             case 3:
            print("milk")
             case 4:
            print("sweet")
             case 5:
            print("white")
             case 6:
            print("account")
            let accountVC = storyboard?.instantiateViewController(withIdentifier: "account") as! AccountViewController
            self.navigationController?.pushViewController(accountVC, animated: true)
            
        default:
            print("default")
        }
    }
    
    func downloadingdata()
    {
        self.current.handlingUser()
  
        DispatchQueue.main.async {
            self.user =  self.current.givinguser()
            if let user = self.user {
                 print("getting user is \(user)")
                if let email = user.email {
                    print(" first user email is \(email)")
                }
                if let displayname = user.displayName {
                    print(" first displayname is \(displayname)")
                    self.label1.text = displayname
                }
            }
        }
    }
    
    func firedowndata()
    {
        dataRef = self.current.databasereference()
        dataRef = dataRef.child("MainScreenData").child("Items")
        print(dataRef)
        
        dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
             if !snapshot.exists() { return }
            if    let Items = snapshot.value as? [String: Any]  {
           // print("Items are \(Items)")
                for ( _ , value) in Items {
               if let val = value as? [String : Any]
               {
            //    print(val)
                
            if    let name = val["name"] as? String,  let url = val["photourl"] as? String ,  let des = val["description"] as? String , let price = val["price"] as? Double ,let first = val["first"] as? String , let second  = val["second"] as? String , let third  = val["third"] as? String
            {
               print(name)
               // print(first)
                //  print(url)
                 //print(des)
              //   print(price)
                let item1 = MainData(url: url, name: name, price: price, desc: des, fir: first, sec: second, thi: third)
                self.MainDa1.append(item1)
                }
                    }
                }
                print(self.MainDa1)
                self.collectionview.reloadData()
            }
            
        }) { (error) in
            print("error is \(error.localizedDescription)")
        }
       
    }
    
        
        /*
     dataRef.observe(.value) { (snapshot) in
     if let Items = snapshot.value as? [[String : Any]]
     {
     print("Items are \(Items)")
     }
     }
     
     
     
        handle = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
         
            if let user = user {
                if let email = user.email {
                    print(" first user email is \(email)")
                }
                if let displayname = user.displayName {
                    print(" first displayname is \(displayname)")
                    self.label1.text = displayname
                }
            }
        })
         print("getting user is \(self.user)")
         print("geting name \(String(describing: self.user?.displayName))")
 */
        
    
    func navigationAtribute()
    {
          self.current = FiruserMain()
        self.navigationController?.navigationBar.backgroundColor = UIColor.brown
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.blue]
        
        view1.endEditing(true)
        view1.isUserInteractionEnabled = true
        
        userimage.layer.cornerRadius = 30
        userimage.clipsToBounds = true
        
        view.endEditing(true)
        view.layoutIfNeeded()
    }
    
    
}

extension FirstViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainDa1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellc", for: indexPath) as! MainCollectionViewCell
        let onedict = MainDa1[indexPath.row]
        cell.Mlabel1.text = onedict.itemName
        cell.Mlabel2.text = onedict.itemDescr
        cell.Mlabel3.text = String(onedict.itemPrice)
        let url2 = URL(string: onedict.imageurlstring!)
        cell.Mimageview.kf.setImage(with: url2)
   
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let selectedDict = MainDa1[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        
        detailVC.firstU = (selectedDict.first)!
        detailVC.secondU = (selectedDict.second)!
        detailVC.thirdU = (selectedDict.third)!
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
    
    
    
}

















/*
 
 //  UINavigationBar.appearance().backgroundColor = UIColor.blue
 // UINavigationBar.appearance().tintColor = UIColor.white
 //  UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
 //  UINavigationBar.appearance().isTranslucent = false
 //   UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 14)]
 storageRef?.data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
 if let derror = error {
 print("downloading error \(error?.localizedDescription)")
 }
 else
 {
 if let imagedata = data  {
 self.userimage.image = UIImage(data: imagedata)
 }
 
 }
 })
 
 
 
 */


/*
 
 //   if let photourl = user.photoURL {
 //    }
 //     let modifyurl = "\(photourl)"
 //     let sepratedurl = modifyurl.components(separatedBy:  "file:///")
 //      if   let mainurl = sepratedurl.last {
 //      print("seprated url \(mainurl)")
 //    print(" first photo url is \(photourl)")
 //    if  let url1 = URL(string: "\(mainurl)") {
 //     self.userimage.kf.setImage(with: url1)
 
 
 //     }
 //       }
 
 /*
 do
 {
 let data1  = try  Data(contentsOf: photourl)
 
 
 let image = UIImage(data: data1)
 self.userimage.image = image
 }
 catch
 {
 print(error.localizedDescription)
 print("error to set photo")
 }
 
 */
 
 
 print(name)
 let url = val["photourl"] as? String
 print(url)
 let des = val["description"] as? String
 print(des)
 let price = val["price"] as? Double
 print(price)
 
 
 
 
 */

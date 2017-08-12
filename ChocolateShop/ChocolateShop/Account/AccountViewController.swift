//
//  AccountViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 27/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class AccountViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate {
    var handle: FIRAuthStateDidChangeListenerHandle?
   
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var imageview: UIImageView!
    
   public  let cu = CurrentUser()
    var changeRequest : FIRUserProfileChangeRequest!
    var user : FIRUser!
    
    let imagepicker = UIImagePickerController()
    let tapgesture = UITapGestureRecognizer()
    var storagereference : FIRStorageReference?
    
   
    
    @IBOutlet weak var nametext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nametext.delegate = self
        storagereference = FIRStorage.storage().reference().child("User Image")
        tapgesture.addTarget(self, action: #selector(selectingimage))
        imageview.addGestureRecognizer(tapgesture)
        imagepicker.delegate = self
        
       nametext.alpha = 0
        let rightbutton  = UIBarButtonItem(title: "Delete Account", style: .done, target: self, action: #selector(deleteAction))
        
        self.navigationItem.rightBarButtonItem = rightbutton
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayname()
        imagevarifications()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont.systemFont(ofSize: 5)]
        if   let cUser = FIRAuth.auth()?.currentUser  {
        user = cUser
            print("user is \(user) ans uid is \(user.uid)")
        }
         changeRequest = self.user.profileChangeRequest()
    }

    @objc func deleteAction()
    {
        user.delete { (errord) in
            if let derror = errord {
                print(" delete error \(derror.localizedDescription)")
                
            }
            else
            {
                let signInVc = self.storyboard?.instantiateViewController(withIdentifier: "loginNa") as! UINavigationController
                self.present(signInVc, animated: true, completion: nil)
                print("successfully deleted user")
                
                
            }
        }
       print("delete action")
        
    
    }
   

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
      if  let chossenimage = info[UIImagePickerControllerOriginalImage] as? UIImage
      {
        imageview.contentMode = .scaleToFill
        imageview.image = chossenimage
  
        if  let imagedata = UIImageJPEGRepresentation(chossenimage, 0.4)
       {
        let uploadMetaData = FIRStorageMetadata()
        
        storagereference?.put(imagedata, metadata: uploadMetaData , completion: { (metadata, error) in
            if let error1 = error {
                print("error1 is \(error1)")
            }
            else
            {
                if  let imageurl  = metadata?.downloadURL()?.absoluteString
                {
                    print("image url is \(imageurl)")
                  
                    self.cu.savedata(url2: imageurl)
                  
                    self.changeRequest.photoURL = URL(fileURLWithPath: imageurl)
                    self.changeRequest.commitChanges { error in
                        if let error11 = error {
                            print(error11.localizedDescription)
                        } else {
                            print("successfully photo saved")
                        }
                    }
            }
            }
        })
        }
        }
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    @objc func selectingimage()
    {
        print("ok select")
        let alertsheet = UIAlertController(title: "select Image Source", message: "camera or photolibrary", preferredStyle: .actionSheet)
        let photolibrary = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.changeRequest = self.user.profileChangeRequest()
            print("photo")
            self.imagepicker.sourceType = .photoLibrary
            self.imagepicker.allowsEditing = true
            self.imagepicker.modalPresentationStyle = .popover
            
            self.imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.imagepicker, animated: true, completion: nil )
        
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.changeRequest = self.user.profileChangeRequest()
            print("camera")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                self.imagepicker.sourceType = .camera
                self.imagepicker.allowsEditing = true
                self.imagepicker.cameraCaptureMode = .photo
                self.imagepicker.modalPresentationStyle = .fullScreen
               self.present(self.imagepicker, animated: true, completion: nil )
                
            }
            else
            {
                print("you don't have camers")
            }
        }
        let entername = UIAlertAction(title: "Your Name", style: .default) { (_) in
            
            self.nametext.alpha = 1
            self.btn1.alpha = 1
           
            self.nametext.isEnabled = true
            self.nametext.allowsEditingTextAttributes = true
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertsheet.addAction(photolibrary)
        alertsheet.addAction(camera)
        alertsheet.addAction(entername)
        alertsheet.addAction(cancel)
        present(alertsheet, animated: true, completion: nil)
    }
    
    
    
    @IBAction func settextAct(_ sender: UIButton)
    {
        changeRequest = self.user.profileChangeRequest()
        if let name = self.nametext.text {
            
            changeRequest.displayName = name
            print("name")
           self.navigationItem.title = name
            changeRequest.commitChanges { error in
                if let error11 = error {
                    print(error11.localizedDescription)
                } else {
                   print("successfully name saved")
                }
            }
        }
        nametext.text = ""
        nametext.alpha = 0
        btn1.alpha = 0
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nametext {
            textField.resignFirstResponder()
            
        }
        return true
    }
    func displayname()
    {
         handle = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let user1 =  user {
                if let nm = user1.displayName
                {
                   self.navigationItem.title = nm
                }
            }
            
    })
    
}
    
    @IBAction func updateAction(_ sender: UIBarButtonItem)
    {
        
    }
    
    
    @IBAction func VarificationAction(_ sender: UIBarButtonItem)
    {
        user.sendEmailVerification { (errorE) in
            if let error = errorE {
                print("varification error is \(error.localizedDescription)")
            }
            else
            {
                print("varify your email")
            }
        }
    print("varification ")
    }
    
    func imagevarifications()
    {
        if  let mainUrl = URL(string: cu.retrivedata()!) {
        imageview.kf.setImage(with: mainUrl)
        }
        
    }
    
    @IBAction func logoutAct(_ sender: UIBarButtonItem)
    {
        do
        {
            try FIRAuth.auth()?.signOut()
            print("successfully logout")
            let signInVc = storyboard?.instantiateViewController(withIdentifier: "loginNa") as! UINavigationController
            self.present(signInVc, animated: true, completion: nil)
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        
    
    }
    
    
}

//   let imageurl = info[UIImagePickerControllerImageURL] as! NSURL
//  print("image url is \(imageurl)")
//  if  let url4 = URL(string: imageurl) {
// let cu = CurrentUser()
//      print(" retrive url is \(cu.retrivedata())")
//   }
// self.Dimageurl = imageurl

//
//  DetailViewController.swift
//  ChocolateShop
//
//  Created by Gaurang Patel on 01/08/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import ImageSlideshow
import Firebase



class DetailViewController: UIViewController {

    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var view1: UIView!
    
  
    @IBOutlet weak var slidshow: ImageSlideshow!
    
    
    var  kingfisherS  : [KingfisherSource]!
    var count = 0
    var firstU = String()
    var secondU = String()
    var thirdU = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(firstU)

        
       
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         kingfisherS = [ KingfisherSource(urlString: firstU)!, KingfisherSource(urlString: secondU)!,
             KingfisherSource(urlString: thirdU)!
        ]
         slidshowEnabled()
        
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    func slidshowEnabled()
    {
        slidshow.backgroundColor = UIColor.white
        slidshow.slideshowInterval = 2.0
        slidshow.pageControlPosition = PageControlPosition.underScrollView
        slidshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slidshow.pageControl.pageIndicatorTintColor = UIColor.black
        slidshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slidshow.circular = true
        slidshow.zoomEnabled = true
        
        slidshow.currentPageChanged = { page in
          //  print("current page:", page)
            self.count = self.slidshow.currentPage
        }
        slidshow.setImageInputs(kingfisherS)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        slidshow.addGestureRecognizer(recognizer)
        
    }
    
    @objc func didTap() {
        print(count)
        _ = slidshow.presentFullScreenController(from: self)
        
        
    }

}
// KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!,

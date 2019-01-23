//
//  ViewController.swift
//  Nasa Pictures
//
//  Created by Lucas Daniel on 19/01/19.
//  Copyright © 2019 Lucas Daniel. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OTMClient.sharedInstance().getData() { (success, error) in
            if error == nil {
                self.result = success
                print(success?.photos?[0].earth_date)
                print(success?.photos?[0].img_src)                
            }
        }
        
        
    }


}


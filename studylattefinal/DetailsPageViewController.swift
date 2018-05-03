//
//  DetailsPageViewController.swift
//  studylattefinal
//
//  Created by Shayan Khan on 5/3/18.
//  Copyright © 2018 Samuel Higgs. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailsPageViewController: UIViewController {
    @IBOutlet weak var shopName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        populateUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var shop:MKMapItem?
    
    func populateUI() {
        if let shop = shop {
            shopName.text = shop.name
            self.title = shop.name
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
